import SwiftUI

// MARK: - City database for autocomplete

/// Pre-bundled city list for offline place search. Sorted by country/region.
private let placeDatabase: [String] = {
    // Vietnam — all 63 provinces + major cities
    let vn = [
        "An Giang", "Bà Rịa - Vũng Tàu", "Bắc Giang", "Bắc Kạn", "Bạc Liêu",
        "Bắc Ninh", "Bến Tre", "Bình Định", "Bình Dương", "Bình Phước",
        "Bình Thuận", "Cà Mau", "Cần Thơ", "Cao Bằng", "Đà Nẵng",
        "Đắk Lắk", "Đắk Nông", "Điện Biên", "Đồng Nai", "Đồng Tháp",
        "Gia Lai", "Hà Giang", "Hà Nam", "Hà Nội", "Hà Tĩnh",
        "Hải Dương", "Hải Phòng", "Hậu Giang", "Hòa Bình", "Hồ Chí Minh",
        "Hưng Yên", "Khánh Hòa", "Kiên Giang", "Kon Tum", "Lai Châu",
        "Lâm Đồng", "Lạng Sơn", "Lào Cai", "Long An", "Nam Định",
        "Nghệ An", "Ninh Bình", "Ninh Thuận", "Phú Thọ", "Phú Yên",
        "Quảng Bình", "Quảng Nam", "Quảng Ngãi", "Quảng Ninh", "Quảng Trị",
        "Sóc Trăng", "Sơn La", "Tây Ninh", "Thái Bình", "Thái Nguyên",
        "Thanh Hóa", "Thừa Thiên Huế", "Tiền Giang", "Trà Vinh", "Tuyên Quang",
        "Vĩnh Long", "Vĩnh Phúc", "Yên Bái",
        // Major Vietnamese cities / districts
        "Saigon", "Sài Gòn", "Hanoi", "Hue", "Huế", "Hoi An", "Hội An",
        "Nha Trang", "Da Lat", "Đà Lạt", "Vung Tau", "Vũng Tàu",
        "Buon Ma Thuot", "Buôn Ma Thuột", "My Tho", "Mỹ Tho",
    ]

    // East / Southeast Asia
    let asia = [
        "Bangkok", "Chiang Mai", "Phuket", "Yangon", "Mandalay",
        "Phnom Penh", "Siem Reap", "Vientiane", "Luang Prabang",
        "Singapore", "Kuala Lumpur", "Penang", "Jakarta", "Bandung",
        "Surabaya", "Manila", "Cebu", "Davao",
        "Beijing", "Shanghai", "Guangzhou", "Shenzhen", "Chengdu",
        "Chongqing", "Hong Kong", "Taipei", "Kaohsiung",
        "Tokyo", "Osaka", "Kyoto", "Nagoya", "Sapporo", "Fukuoka",
        "Seoul", "Busan", "Incheon",
        "Ulaanbaatar", "Kathmandu", "Dhaka", "Colombo",
        "New Delhi", "Mumbai", "Bangalore", "Chennai", "Kolkata",
        "Hyderabad", "Pune", "Ahmedabad", "Jaipur", "Lucknow",
    ]

    // Americas
    let americas = [
        "New York", "Los Angeles", "Chicago", "Houston", "Phoenix",
        "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose",
        "Austin", "San Francisco", "Seattle", "Denver", "Boston",
        "Miami", "Atlanta", "Portland", "Las Vegas", "Washington DC",
        "Toronto", "Vancouver", "Montreal", "Calgary", "Ottawa",
        "Mexico City", "Guadalajara", "Monterrey", "Buenos Aires",
        "São Paulo", "Rio de Janeiro", "Brasília", "Lima", "Santiago",
        "Bogotá", "Medellín", "Quito", "Caracas", "Havana",
    ]

    // Europe
    let europe = [
        "London", "Manchester", "Birmingham", "Edinburgh", "Dublin",
        "Paris", "Marseille", "Lyon", "Nice", "Berlin", "Munich",
        "Hamburg", "Frankfurt", "Cologne", "Rome", "Milan", "Naples",
        "Turin", "Madrid", "Barcelona", "Valencia", "Seville",
        "Lisbon", "Porto", "Amsterdam", "Rotterdam", "Brussels",
        "Vienna", "Zurich", "Geneva", "Stockholm", "Oslo",
        "Copenhagen", "Helsinki", "Warsaw", "Krakow", "Prague",
        "Budapest", "Bucharest", "Athens", "Moscow", "St. Petersburg",
        "Kyiv", "Istanbul", "Ankara", "Izmir",
    ]

    // Oceania
    let oceania = [
        "Sydney", "Melbourne", "Brisbane", "Perth", "Adelaide",
        "Gold Coast", "Canberra", "Auckland", "Wellington", "Christchurch",
    ]

    // Africa / Middle East
    let africa = [
        "Cairo", "Alexandria", "Lagos", "Nairobi", "Johannesburg",
        "Cape Town", "Pretoria", "Casablanca", "Marrakech", "Accra",
        "Dubai", "Abu Dhabi", "Doha", "Riyadh", "Jeddah",
        "Tel Aviv", "Jerusalem", "Tehran", "Baghdad",
    ]

    return (vn + asia + americas + europe + oceania + africa).sorted()
}()

// MARK: - Place Picker View

/// A searchable place picker with autocomplete from a pre-bundled city database.
/// Falls back to free text if no match is found.
struct PlacePickerView: View {
    @Environment(AppSettings.self) private var settings
    @Binding var selection: String
    @State private var query: String = ""
    @State private var showSuggestions: Bool = false

    private var isVi: Bool { settings.language == "vi" }

    private var placeholderText: String {
        isVi ? "Tìm kiếm thành phố..." : "Search cities..."
    }

    private var noResultsText: String {
        isVi ? "Không tìm thấy — nhấn để dùng \"\(query)\"" : "No results — tap to use \"\(query)\""
    }

    private var filteredPlaces: [String] {
        guard !query.isEmpty else { return [] }
        let q = query.lowercased()
        return placeDatabase.filter { $0.lowercased().contains(q) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundStyle(.secondary)
                TextField(placeholderText, text: $query)
                    .onChange(of: query) { _, _ in
                        withAnimation(.easeInOut(duration: 0.15)) {
                            showSuggestions = !query.isEmpty
                        }
                    }
                if !query.isEmpty {
                    Button {
                        query = ""
                        showSuggestions = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            if showSuggestions {
                Divider().padding(.vertical, 4)

                if filteredPlaces.isEmpty {
                    Button {
                        selection = query
                        showSuggestions = false
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                            Text(noResultsText)
                                .font(.subheadline)
                            Spacer()
                        }
                        .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 6)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(filteredPlaces.prefix(15), id: \.self) { place in
                                Button {
                                    selection = place
                                    query = place
                                    showSuggestions = false
                                } label: {
                                    HStack {
                                        Image(systemName: "building.2")
                                            .foregroundStyle(.secondary)
                                        Text(place)
                                            .font(.subheadline)
                                        Spacer()
                                        if place == selection {
                                            Image(systemName: "checkmark")
                                                .font(.caption)
                                                .foregroundStyle(.purple)
                                        }
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 4)
                                    .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)

                                if place != filteredPlaces.prefix(15).last {
                                    Divider().padding(.leading, 28)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 220)
                }
            }

            // Show selected place
            if !selection.isEmpty && !showSuggestions {
                HStack {
                    Text(isVi ? "Đã chọn:" : "Selected:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(selection)
                        .font(.caption.weight(.medium))
                    Button {
                        selection = ""
                        query = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 6)
            }
        }
        .onAppear {
            query = selection
        }
    }
}
