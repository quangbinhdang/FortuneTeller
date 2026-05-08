import SwiftUI

// MARK: - Shared localization helper

/// Returns `vi` when language is Vietnamese, otherwise `en`.
func loc(_ en: String, _ vi: String, language: String) -> String {
    language == "vi" ? vi : en
}

// MARK: - Birth time binding

/// Bridges a (birthHour, birthMinute) pair to a Date for DatePicker.
func birthTimeBinding(hour: Binding<Int>, minute: Binding<Int>) -> Binding<Date> {
    Binding<Date>(
        get: {
            let cal = Calendar.current
            var comps = DateComponents()
            comps.hour = hour.wrappedValue
            comps.minute = minute.wrappedValue
            return cal.date(from: comps) ?? Date()
        },
        set: { date in
            let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
            hour.wrappedValue = comps.hour ?? 12
            minute.wrappedValue = comps.minute ?? 0
        }
    )
}
