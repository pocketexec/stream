import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LiveView()
                .tabItem { Label("Live", systemImage: "bolt.fill") }
            LibraryView()
                .tabItem { Label("Library", systemImage: "square.grid.2x2") }
        }
    }
}

struct LiveView: View {
    @EnvironmentObject var session: SessionStore
    @State private var selectedEntrance: PrepItem?
    @State private var selectedGame: PrepItem?
    @State private var selectedExit: PrepItem?
    @State private var showingReset = false
    @State private var selectedTopicGroup = "Bell / Stream Lore"
    @State private var topicPicks: [PrepItem] = []

    private var topicGroups: [String] {
        Array(Set(ContentData.topics.map { $0.group })).sorted()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    header
                    liveCard(title:"ENTRANCE", icon:"door.left.hand.open", item:$selectedEntrance, source:ContentData.entrances)
                    topicQuickPicker
                    liveCard(title:"GAME", icon:"gamecontroller", item:$selectedGame, source:ContentData.games)
                    liveCard(title:"EXIT", icon:"figure.walk.departure", item:$selectedExit, source:ContentData.exits)
                    rhythm
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Stream Prep")
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    Button("Reset") { showingReset = true }
                }
            }
            .confirmationDialog("Reset all used items for a new stream?", isPresented:$showingReset) {
                Button("Reset Session", role:.destructive) {
                    session.resetSession()
                    randomizeTopics()
                }
            }
            .onAppear {
                if topicPicks.isEmpty { randomizeTopics() }
            }
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment:.leading, spacing:4) {
                Text("LIVE MODE").font(.caption.bold()).foregroundStyle(.secondary)
                Text("Glance. Pick a direction. Put the phone down.").font(.headline)
            }
            Spacer()
            Text("\(session.usedIDs.count) used")
                .font(.caption.bold()).padding(.horizontal,10).padding(.vertical,6)
                .background(.thinMaterial, in: Capsule())
        }
        .padding(.bottom,4)
    }

    private var topicQuickPicker: some View {
        VStack(alignment:.leading, spacing:12) {
            HStack {
                Label("QUESTIONS", systemImage:"quote.bubble").font(.caption.bold()).foregroundStyle(.secondary)
                Spacer()
                Button {
                    randomizeTopics()
                } label: {
                    Label("Randomize", systemImage:"shuffle")
                }
                .buttonStyle(.bordered)
            }

            Menu {
                ForEach(topicGroups, id:\.self) { group in
                    Button(group) {
                        selectedTopicGroup = group
                        randomizeTopics()
                    }
                }
            } label: {
                HStack {
                    VStack(alignment:.leading, spacing:2) {
                        Text("CATEGORY").font(.caption2.bold()).foregroundStyle(.secondary)
                        Text(selectedTopicGroup).font(.headline).foregroundStyle(.primary)
                    }
                    Spacer()
                    Image(systemName:"chevron.up.chevron.down").foregroundStyle(.secondary)
                }
                .padding(12)
                .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius:12, style:.continuous))
            }

            if topicPicks.isEmpty {
                Text("No unused questions left in this category.")
                    .font(.callout).foregroundStyle(.secondary)
                    .frame(maxWidth:.infinity, alignment:.leading)
                    .padding(.vertical,8)
            } else {
                VStack(spacing:8) {
                    ForEach(topicPicks) { question in
                        HStack(alignment:.top, spacing:10) {
                            Button {
                                session.toggleUsed(question.id)
                            } label: {
                                Image(systemName: session.usedIDs.contains(question.id) ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)
                                    .foregroundStyle(session.usedIDs.contains(question.id) ? .green : .secondary)
                            }
                            .buttonStyle(.plain)

                            Text(question.summary)
                                .font(.callout)
                                .foregroundStyle(session.usedIDs.contains(question.id) ? .secondary : .primary)
                                .strikethrough(session.usedIDs.contains(question.id))
                                .fixedSize(horizontal:false, vertical:true)
                                .frame(maxWidth:.infinity, alignment:.leading)
                        }
                        .padding(10)
                        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius:12, style:.continuous))
                    }
                }
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius:18, style:.continuous))
    }

    private func randomizeTopics() {
        let available = ContentData.topics.filter {
            $0.group == selectedTopicGroup && !session.usedIDs.contains($0.id)
        }
        topicPicks = Array(available.shuffled().prefix(5))
    }

    @ViewBuilder
    private func liveCard(title:String, icon:String, item:Binding<PrepItem?>, source:[PrepItem]) -> some View {
        let available = source.filter { !session.usedIDs.contains($0.id) }
        VStack(alignment:.leading, spacing:10) {
            HStack {
                Label(title, systemImage: icon).font(.caption.bold()).foregroundStyle(.secondary)
                Spacer()
                Button("Pick") { item.wrappedValue = available.randomElement() }
                    .buttonStyle(.bordered)
            }
            if let current = item.wrappedValue {
                NavigationLink {
                    ItemDetailView(item: current)
                } label: {
                    VStack(alignment:.leading, spacing:6) {
                        HStack {
                            Text(current.title).font(.title3.bold()).foregroundStyle(.primary)
                            Spacer()
                            if let badge = current.badge { Badge(text:badge) }
                        }
                        Text(current.summary).font(.body).foregroundStyle(.secondary).multilineTextAlignment(.leading)
                    }
                }
                Button(session.usedIDs.contains(current.id) ? "Undo Used" : "Mark Used") {
                    session.toggleUsed(current.id)
                    item.wrappedValue = available.filter{$0.id != current.id}.randomElement()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth:.infinity, alignment:.trailing)
            } else {
                Button {
                    item.wrappedValue = available.randomElement()
                } label: {
                    HStack { Text(available.isEmpty ? "Everything used" : "Tap to pick from \(available.count) unused"); Spacer(); Image(systemName:"shuffle") }
                        .frame(maxWidth:.infinity).padding(.vertical,8)
                }
                .buttonStyle(.bordered)
                .disabled(available.isEmpty)
            }
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius:18, style:.continuous))
    }

    private var rhythm: some View {
        VStack(alignment:.leading, spacing:8) {
            Text("RHYTHM").font(.caption.bold()).foregroundStyle(.secondary)
            Text("LISTEN → UNDERSTAND → FIND THE ANGLE → SHOOT → RELEASE → LISTEN AGAIN")
                .font(.callout.bold()).fixedSize(horizontal:false, vertical:true)
            Text("The list is a bank, not a script.").font(.footnote).foregroundStyle(.secondary)
        }
        .frame(maxWidth:.infinity, alignment:.leading)
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius:18, style:.continuous))
    }
}

struct LibraryView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink { ItemListView(title:"Entrances", items:ContentData.entrances) } label: { LibraryRow(icon:"door.left.hand.open", title:"Entrances", count:ContentData.entrances.count) }
                NavigationLink { ItemListView(title:"Topics", items:ContentData.topics) } label: { LibraryRow(icon:"quote.bubble", title:"Topics", count:ContentData.topics.count) }
                NavigationLink { ItemListView(title:"Chat Games", items:ContentData.games) } label: { LibraryRow(icon:"gamecontroller", title:"Chat Games", count:ContentData.games.count) }
                NavigationLink { ItemListView(title:"Exits", items:ContentData.exits) } label: { LibraryRow(icon:"figure.walk.departure", title:"Exits", count:ContentData.exits.count) }
                Section {
                    HStack { Spacer(); Text("Stream Prep 1.1 • Build 4").font(.caption).foregroundStyle(.secondary); Spacer() }
                }
            }
            .navigationTitle("Library")
        }
    }
}

struct LibraryRow: View {
    let icon:String; let title:String; let count:Int
    var body: some View {
        HStack(spacing:14) {
            Image(systemName:icon).font(.title2).frame(width:30)
            VStack(alignment:.leading) { Text(title).font(.headline); Text("\(count) items").font(.caption).foregroundStyle(.secondary) }
        }.padding(.vertical,5)
    }
}

struct ItemListView: View {
    @EnvironmentObject var session: SessionStore
    let title:String
    let items:[PrepItem]
    @State private var search = ""

    var filtered:[PrepItem] {
        if search.isEmpty { return items }
        return items.filter { $0.title.localizedCaseInsensitiveContains(search) || $0.summary.localizedCaseInsensitiveContains(search) || $0.group.localizedCaseInsensitiveContains(search) }
    }

    var groups:[String] { Array(Set(filtered.map{$0.group})).sorted { a,b in
        let order = ["Top 5","Exit"]
        let ia = order.firstIndex(of:a) ?? 99, ib = order.firstIndex(of:b) ?? 99
        return ia == ib ? a < b : ia < ib
    }}

    var body: some View {
        List {
            ForEach(groups, id:\.self) { group in
                Section(group) {
                    ForEach(filtered.filter{$0.group == group}) { item in
                        NavigationLink { ItemDetailView(item:item) } label: {
                            VStack(alignment:.leading, spacing:5) {
                                HStack {
                                    Text(item.title).font(.headline).strikethrough(session.usedIDs.contains(item.id))
                                    Spacer()
                                    if let badge=item.badge { Badge(text:badge) }
                                }
                                Text(item.summary).font(.caption).foregroundStyle(.secondary).lineLimit(2)
                            }
                            .opacity(session.usedIDs.contains(item.id) ? 0.45 : 1)
                        }
                        .swipeActions(edge:.leading, allowsFullSwipe:true) {
                            Button { session.toggleFavorite(item.id) } label: { Label("Favorite", systemImage: session.favoriteIDs.contains(item.id) ? "star.slash" : "star") }
                                .tint(.orange)
                        }
                        .swipeActions(edge:.trailing, allowsFullSwipe:true) {
                            Button { session.toggleUsed(item.id) } label: { Label(session.usedIDs.contains(item.id) ? "Undo" : "Used", systemImage:"checkmark") }
                                .tint(.green)
                        }
                    }
                }
            }
        }
        .searchable(text:$search)
        .navigationTitle(title)
    }
}

struct ItemDetailView: View {
    @EnvironmentObject var session: SessionStore
    let item:PrepItem
    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing:18) {
                HStack { if let badge=item.badge { Badge(text:badge) }; Spacer(); Button { session.toggleFavorite(item.id) } label: { Image(systemName:session.favoriteIDs.contains(item.id) ? "star.fill" : "star") } }
                Text(item.title).font(.largeTitle.bold())
                Text(item.summary).font(.title3).foregroundStyle(.secondary)
                Divider()
                if item.id.hasPrefix("exit-") {
                    Text("IDEA + EXAMPLE").font(.caption.bold()).foregroundStyle(.secondary)
                }
                Text(item.details).font(.body).textSelection(.enabled)
                Button(session.usedIDs.contains(item.id) ? "Undo Used" : "Mark Used") { session.toggleUsed(item.id) }
                    .buttonStyle(.borderedProminent).controlSize(.large)
                    .frame(maxWidth:.infinity)
            }.padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Badge: View {
    let text:String
    var body: some View { Text(text).font(.caption2.bold()).padding(.horizontal,7).padding(.vertical,4).background(.thinMaterial, in:Capsule()) }
}
