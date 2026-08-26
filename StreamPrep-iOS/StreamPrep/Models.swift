import Foundation

enum PrepSection: String, CaseIterable, Identifiable, Codable {
    case entrance = "Entrance"
    case topic = "Topic"
    case game = "Game"
    case exit = "Exit"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .entrance: return "door.left.hand.open"
        case .topic: return "quote.bubble"
        case .game: return "gamecontroller"
        case .exit: return "figure.walk.departure"
        }
    }
}

struct PrepItem: Identifiable, Hashable, Codable {
    let id: String
    let title: String
    let summary: String
    let details: String
    let group: String
    let badge: String?
}

struct CustomPrepItem: Identifiable, Hashable, Codable {
    let id: String
    var section: PrepSection
    var item: PrepItem

    init(id: String = UUID().uuidString, section: PrepSection, item: PrepItem) {
        self.id = id
        self.section = section
        self.item = item
    }
}

final class CustomContentStore: ObservableObject {
    @Published var entries: [CustomPrepItem] = [] { didSet { save() } }

    private let storageKey = "StreamPrep.customItems.v1"

    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([CustomPrepItem].self, from: data) else { return }
        entries = decoded
    }

    func items(for section: PrepSection) -> [PrepItem] {
        entries.filter { $0.section == section }.map(\.item)
    }

    func entry(for itemID: String) -> CustomPrepItem? {
        entries.first { $0.item.id == itemID }
    }

    func add(section: PrepSection, title: String, summary: String, details: String, group: String, badge: String?) {
        let cleanBadge = badge?.trimmingCharacters(in: .whitespacesAndNewlines)
        let item = PrepItem(
            id: "custom-\(UUID().uuidString)",
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            summary: summary.trimmingCharacters(in: .whitespacesAndNewlines),
            details: details.trimmingCharacters(in: .whitespacesAndNewlines),
            group: group.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? defaultGroup(for: section) : group.trimmingCharacters(in: .whitespacesAndNewlines),
            badge: cleanBadge?.isEmpty == false ? cleanBadge : nil
        )
        entries.append(CustomPrepItem(section: section, item: item))
    }

    func update(_ entryID: String, section: PrepSection, title: String, summary: String, details: String, group: String, badge: String?) {
        guard let index = entries.firstIndex(where: { $0.id == entryID }) else { return }
        let cleanBadge = badge?.trimmingCharacters(in: .whitespacesAndNewlines)
        let existingID = entries[index].item.id
        entries[index] = CustomPrepItem(
            id: entryID,
            section: section,
            item: PrepItem(
                id: existingID,
                title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                summary: summary.trimmingCharacters(in: .whitespacesAndNewlines),
                details: details.trimmingCharacters(in: .whitespacesAndNewlines),
                group: group.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? defaultGroup(for: section) : group.trimmingCharacters(in: .whitespacesAndNewlines),
                badge: cleanBadge?.isEmpty == false ? cleanBadge : nil
            )
        )
    }

    func delete(_ entryID: String) {
        entries.removeAll { $0.id == entryID }
    }

    func duplicate(_ item: PrepItem, section: PrepSection) {
        add(
            section: section,
            title: "\(item.title) Copy",
            summary: item.summary,
            details: item.details,
            group: item.group,
            badge: item.badge
        )
    }

    private func defaultGroup(for section: PrepSection) -> String {
        switch section {
        case .entrance: return "Entrance"
        case .topic: return "My Topics"
        case .game: return "My Games"
        case .exit: return "Exit"
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

final class SessionStore: ObservableObject {
    @Published var usedIDs: Set<String> = [] { didSet { save() } }
    @Published var favoriteIDs: Set<String> = [] { didSet { save() } }

    private let usedKey = "StreamPrep.usedIDs"
    private let favoritesKey = "StreamPrep.favoriteIDs"

    init() {
        usedIDs = Set(UserDefaults.standard.stringArray(forKey: usedKey) ?? [])
        favoriteIDs = Set(UserDefaults.standard.stringArray(forKey: favoritesKey) ?? [])
    }

    func toggleUsed(_ id: String) {
        if usedIDs.contains(id) { usedIDs.remove(id) } else { usedIDs.insert(id) }
    }

    func toggleFavorite(_ id: String) {
        if favoriteIDs.contains(id) { favoriteIDs.remove(id) } else { favoriteIDs.insert(id) }
    }

    func resetSession() { usedIDs.removeAll() }

    private func save() {
        UserDefaults.standard.set(Array(usedIDs), forKey: usedKey)
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
