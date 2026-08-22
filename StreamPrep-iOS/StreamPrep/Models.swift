import Foundation

struct PrepItem: Identifiable, Hashable {
    let id: String
    let title: String
    let summary: String
    let details: String
    let group: String
    let badge: String?
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
