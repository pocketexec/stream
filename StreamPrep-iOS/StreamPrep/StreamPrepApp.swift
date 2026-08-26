import SwiftUI

@main
struct StreamPrepApp: App {
    @StateObject private var session = SessionStore()
    @StateObject private var customContent = CustomContentStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(session)
                .environmentObject(customContent)
        }
    }
}
