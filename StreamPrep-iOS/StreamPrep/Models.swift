import Foundation

enum PrepSection: String, CaseIterable, Identifiable, Codable {
    case entrance = "Entrance"
    case topic = "Topic"
    case game = "Game"
    case mid = "Mid Stream"
    case exit = "Exit"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .entrance: return "door.left.hand.open"
        case .topic: return "quote.bubble"
        case .game: return "gamecontroller"
        case .mid: return "theatermasks"
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
    @Published var overrides: [String: PrepItem] = [:] { didSet { save() } }

    private let storageKey = "StreamPrep.customItems.v1"
    private let overridesKey = "StreamPrep.builtinOverrides.v1"

    init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([CustomPrepItem].self, from: data) {
            entries = decoded
        }
        if let data = UserDefaults.standard.data(forKey: overridesKey),
           let decoded = try? JSONDecoder().decode([String: PrepItem].self, from: data) {
            overrides = decoded
        }
    }

    func items(for section: PrepSection) -> [PrepItem] {
        entries.filter { $0.section == section }.map(\.item)
    }

    // Built-in items with any on-device edits applied, followed by the user's custom items.
    func allItems(for section: PrepSection) -> [PrepItem] {
        ContentData.items(for: section).map { overrides[$0.id] ?? $0 } + items(for: section)
    }

    func resolved(_ item: PrepItem) -> PrepItem {
        overrides[item.id] ?? item
    }

    func isOverridden(_ itemID: String) -> Bool {
        overrides[itemID] != nil
    }

    func entry(for itemID: String) -> CustomPrepItem? {
        entries.first { $0.item.id == itemID }
    }

    func add(section: PrepSection, title: String, summary: String, details: String, group: String, badge: String?) {
        let item = makeItem(id: "custom-\(UUID().uuidString)", title: title, summary: summary, details: details, group: group, badge: badge, fallbackGroup: defaultGroup(for: section))
        entries.append(CustomPrepItem(section: section, item: item))
    }

    func update(_ entryID: String, section: PrepSection, title: String, summary: String, details: String, group: String, badge: String?) {
        guard let index = entries.firstIndex(where: { $0.id == entryID }) else { return }
        let existingID = entries[index].item.id
        entries[index] = CustomPrepItem(
            id: entryID,
            section: section,
            item: makeItem(id: existingID, title: title, summary: summary, details: details, group: group, badge: badge, fallbackGroup: defaultGroup(for: section))
        )
    }

    func setOverride(forBuiltin itemID: String, section: PrepSection, title: String, summary: String, details: String, group: String, badge: String?) {
        let original = ContentData.items(for: section).first { $0.id == itemID }
        overrides[itemID] = makeItem(id: itemID, title: title, summary: summary, details: details, group: group, badge: badge, fallbackGroup: original?.group ?? defaultGroup(for: section))
    }

    func removeOverride(forBuiltin itemID: String) {
        overrides.removeValue(forKey: itemID)
    }

    private func makeItem(id: String, title: String, summary: String, details: String, group: String, badge: String?, fallbackGroup: String) -> PrepItem {
        let cleanBadge = badge?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanGroup = group.trimmingCharacters(in: .whitespacesAndNewlines)
        return PrepItem(
            id: id,
            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
            summary: summary.trimmingCharacters(in: .whitespacesAndNewlines),
            details: details.trimmingCharacters(in: .whitespacesAndNewlines),
            group: cleanGroup.isEmpty ? fallbackGroup : cleanGroup,
            badge: cleanBadge?.isEmpty == false ? cleanBadge : nil
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
        case .mid: return "Mid Stream"
        case .exit: return "Exit"
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
        if let data = try? JSONEncoder().encode(overrides) {
            UserDefaults.standard.set(data, forKey: overridesKey)
        }
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
