import SwiftUI

// MARK: - No-Chinese guard

/// Appends a language-specific instruction to avoid Chinese characters.
private func guardNoChinese(_ question: String, language: String) -> String {
    let guardLine = language == "vi"
        ? "\n\n(KHÔNG dùng chữ Hán hoặc ký tự Trung Quốc. Chỉ viết bằng tiếng Việt.)"
        : "\n\n(Do NOT include Chinese characters or Hanzi. Write only in English.)"
    return question + guardLine
}

// MARK: - Markdown message bubble

private struct MarkdownMessageBubble: View {
    let text: String
    let isUser: Bool
    @Environment(\.theme) private var theme

    var body: some View {
        if let attr = try? AttributedString(
            markdown: text,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            Text(attr)
                .font(.system(size: 15))
                .textSelection(.enabled)
                .padding(12)
                .foregroundColor(isUser ? .white : theme.starlight)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isUser ? theme.gold.opacity(0.3) : theme.surfaceContainer.opacity(0.7))
                )
        } else {
            Text(text)
                .font(.system(size: 15))
                .textSelection(.enabled)
                .padding(12)
                .foregroundColor(isUser ? .white : theme.starlight)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isUser ? theme.gold.opacity(0.3) : theme.surfaceContainer.opacity(0.7))
                )
        }
    }
}

// MARK: - Chat View Model

/// Chat interface for asking any divinatory question.
/// Pattern: messages array + optimistic UI + API call.
@MainActor
@Observable
final class ChatViewModel {
    var messages: [ChatMessage] = []
    var inputText = ""
    var isLoading = false
    var error: String?

    func send(api: FortuneAPI?, profile: Profile?, language: String) async {
        guard let api, let profile else {
            error = "Server or profile not configured."
            return
        }
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        // Add user message
        let userMsg = ChatMessage(id: UUID().uuidString, role: "user", content: text, timestamp: Date())
        messages.append(userMsg)
        inputText = ""
        isLoading = true
        error = nil

        do {
            let question = guardNoChinese(text, language: language)
            let resp = try await api.ask(
                question: question,
                birthDate: profile.birthDateString,
                birthHour: profile.birthHour,
                birthMinute: profile.birthMinute
            )
            let assistantMsg = ChatMessage(
                id: UUID().uuidString,
                role: "assistant",
                content: resp.answer,
                timestamp: Date(),
                sources: resp.sources.map { ChatMessage.ReadingSource(file: $0.file, relevance: $0.relevance) }
            )
            messages.append(assistantMsg)
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}

// MARK: - Chat View

struct ChatView: View {
    @Environment(AppSettings.self) private var settings
    @Environment(\.theme) private var theme
    @FocusState private var isFocused: Bool
    @State private var vm = ChatViewModel()

    private var lang: String { settings.language }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 10) {
                            if let err = vm.error {
                                Label(err, systemImage: "exclamationmark.triangle")
                                    .foregroundStyle(.red)
                                    .padding(4)
                            }
                            ForEach(vm.messages) { msg in
                                messageBubble(msg)
                            }
                            if vm.isLoading {
                                HStack {
                                    ProgressView()
                                        .tint(theme.gold)
                                    Text(lang == "vi" ? "Đang xem..." : "Consulting...")
                                        .font(.caption)
                                        .foregroundColor(theme.mutedStarlight)
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 4)
                            }
                            Color.clear.frame(height: 1).id("bottom")
                        }
                        .padding(12)
                        .onChange(of: vm.messages.count) { _, _ in
                            withAnimation { proxy.scrollTo("bottom", anchor: .bottom) }
                        }
                    }
                }
                .background(theme.background)
                .contentShape(Rectangle())
                .onTapGesture { isFocused = false }

                // Composer
                HStack(spacing: 8) {
                    TextField(
                        lang == "vi" ? "Hỏi bất cứ điều gì..." : "Ask anything...",
                        text: $vm.inputText,
                        axis: .vertical
                    )
                    .focused($isFocused)
                    .lineLimit(1...5)
                    .padding(10)
                    .background(theme.surfaceContainer.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(theme.starlight)

                    Button {
                        Task {
                            await vm.send(
                                api: FortuneAPI(serverURL: settings.serverURL),
                                profile: settings.activeProfile,
                                language: lang
                            )
                        }
                    } label: {
                        Image(systemName: vm.isLoading ? "hourglass" : "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundColor(vm.isLoading ? theme.mutedStarlight : theme.gold)
                    }
                    .disabled(vm.isLoading || vm.inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(theme.surface.opacity(0.8))
            }
            .navigationTitle(lang == "vi" ? "Trò chuyện" : "Chat")
            .background(theme.background)
        }
    }

    private func messageBubble(_ msg: ChatMessage) -> some View {
        HStack {
            if msg.isUser { Spacer(minLength: 40) }
            MarkdownMessageBubble(text: msg.content, isUser: msg.isUser)
                .frame(maxWidth: .infinity, alignment: msg.isUser ? .trailing : .leading)
            if msg.isAssistant { Spacer(minLength: 40) }
        }
    }
}
