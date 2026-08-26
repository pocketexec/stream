import SwiftUI

struct ContentView: View {
    @EnvironmentObject var customContent: CustomContentStore
    @State private var showingAdd = false

    var body: some View {
        TabView {
            LiveView()
                .tabItem { Label("Live", systemImage: "bolt.fill") }
            LibraryView()
                .tabItem { Label("Library", systemImage: "square.grid.2x2") }
            CustomItemsView()
                .tabItem { Label("My Stuff", systemImage: "plus.square.fill") }
        }
        .sheet(isPresented: $showingAdd) {
            CustomItemEditor()
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                showingAdd = true
            } label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .frame(width: 56, height: 56)
            }
            .buttonStyle(.borderedProminent)
            .clipShape(Circle())
            .shadow(radius: 4)
            .padding(.trailing, 18)
            .padding(.bottom, 70)
            .accessibilityLabel("Add stream prep item")
        }
    }
}

struct LiveView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var customContent: CustomContentStore
    @State private var selectedEntrance: PrepItem?
    @State private var selectedGame: PrepItem?
    @State private var selectedExit: PrepItem?
    @State private var showingReset = false
    @State private var selectedTopicGroup = "Bell / Stream Lore"
    @State private var topicPicks: [PrepItem] = []

    private var entrances: [PrepItem] { ContentData.entrances + customContent.items(for: .entrance) }
    private var games: [PrepItem] { ContentData.games + customContent.items(for: .game) }
    private var exits: [PrepItem] { ContentData.exits + customContent.items(for: .exit) }
    private var topics: [PrepItem] { ContentData.topics + customContent.items(for: .topic) }

    private var topicGroups: [String] {
        Array(Set(topics.map { $0.group })).sorted()
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    header
                    liveCard(title:"ENTRANCE", icon:"door.left.hand.open", item:$selectedEntrance, source:entrances)
                    topicQuickPicker
                    liveCard(title:"GAME", icon:"gamecontroller", item:$selectedGame, source:games)
                    liveCard(title:"EXIT", icon:"figure.walk.departure", item:$selectedExit, source:exits)
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
            .onChange(of: customContent.entries) { _ in
                if !topicGroups.contains(selectedTopicGroup), let first = topicGroups.first {
                    selectedTopicGroup = first
                }
                randomizeTopics()
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
        let available = topics.filter {
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
    @EnvironmentObject var customContent: CustomContentStore

    private var entrances: [PrepItem] { ContentData.entrances + customContent.items(for: .entrance) }
    private var topics: [PrepItem] { ContentData.topics + customContent.items(for: .topic) }
    private var games: [PrepItem] { ContentData.games + customContent.items(for: .game) }
    private var exits: [PrepItem] { ContentData.exits + customContent.items(for: .exit) }

    var body: some View {
        NavigationStack {
            List {
                NavigationLink { ItemListView(title:"Entrances", section:.entrance, items:entrances) } label: { LibraryRow(icon:"door.left.hand.open", title:"Entrances", count:entrances.count) }
                NavigationLink { ItemListView(title:"Topics", section:.topic, items:topics) } label: { LibraryRow(icon:"quote.bubble", title:"Topics", count:topics.count) }
                NavigationLink { ItemListView(title:"Chat Games", section:.game, items:games) } label: { LibraryRow(icon:"gamecontroller", title:"Chat Games", count:games.count) }
                NavigationLink { ItemListView(title:"Exits", section:.exit, items:exits) } label: { LibraryRow(icon:"figure.walk.departure", title:"Exits", count:exits.count) }
                Section {
                    HStack { Spacer(); Text("Stream Prep 1.2 • Custom Content").font(.caption).foregroundStyle(.secondary); Spacer() }
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
    @EnvironmentObject var customContent: CustomContentStore
    let title:String
    let section: PrepSection
    let items:[PrepItem]
    @State private var search = ""
    @State private var editingEntry: CustomPrepItem?
    @State private var showingAdd = false

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
                        NavigationLink { ItemDetailView(item:item, section:section) } label: {
                            VStack(alignment:.leading, spacing:5) {
                                HStack {
                                    Text(item.title).font(.headline).strikethrough(session.usedIDs.contains(item.id))
                                    Spacer()
                                    if item.id.hasPrefix("custom-") {
                                        Image(systemName:"person.crop.circle.badge.plus").foregroundStyle(.secondary)
                                    }
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
                        .swipeActions(edge:.trailing, allowsFullSwipe:false) {
                            Button { session.toggleUsed(item.id) } label: { Label(session.usedIDs.contains(item.id) ? "Undo" : "Used", systemImage:"checkmark") }
                                .tint(.green)
                            if let entry = customContent.entry(for: item.id) {
                                Button { editingEntry = entry } label: { Label("Edit", systemImage:"pencil") }
                                    .tint(.blue)
                                Button(role:.destructive) { customContent.delete(entry.id) } label: { Label("Delete", systemImage:"trash") }
                            } else {
                                Button { customContent.duplicate(item, section: section) } label: { Label("Copy", systemImage:"doc.on.doc") }
                                    .tint(.indigo)
                            }
                        }
                    }
                }
            }
        }
        .searchable(text:$search)
        .navigationTitle(title)
        .toolbar {
            ToolbarItem(placement:.topBarTrailing) {
                Button { showingAdd = true } label: { Image(systemName:"plus") }
                    .accessibilityLabel("Add to \(title)")
            }
        }
        .sheet(isPresented:$showingAdd) {
            CustomItemEditor(initialSection: section)
        }
        .sheet(item:$editingEntry) { entry in
            CustomItemEditor(entry: entry)
        }
    }
}

struct ItemDetailView: View {
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var customContent: CustomContentStore
    let item:PrepItem
    var section: PrepSection? = nil
    @State private var editingEntry: CustomPrepItem?

    var body: some View {
        ScrollView {
            VStack(alignment:.leading, spacing:18) {
                HStack {
                    if let badge=item.badge { Badge(text:badge) }
                    Spacer()
                    if let entry = customContent.entry(for: item.id) {
                        Button { editingEntry = entry } label: { Image(systemName:"pencil") }
                    } else if let section {
                        Button { customContent.duplicate(item, section: section) } label: { Image(systemName:"doc.on.doc") }
                    }
                    Button { session.toggleFavorite(item.id) } label: { Image(systemName:session.favoriteIDs.contains(item.id) ? "star.fill" : "star") }
                }
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
        .sheet(item:$editingEntry) { entry in
            CustomItemEditor(entry: entry)
        }
    }
}

struct CustomItemsView: View {
    @EnvironmentObject var customContent: CustomContentStore
    @State private var showingAdd = false
    @State private var editingEntry: CustomPrepItem?

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("My Stuff")
                .toolbar {
                    ToolbarItem(placement:.topBarTrailing) {
                        Button { showingAdd = true } label: { Image(systemName:"plus") }
                    }
                }
                .sheet(isPresented:$showingAdd) {
                    CustomItemEditor()
                }
                .sheet(item:$editingEntry) { entry in
                    CustomItemEditor(entry: entry)
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if customContent.entries.isEmpty {
            CustomItemsEmptyState()
        } else {
            List {
                ForEach(PrepSection.allCases) { section in
                    sectionView(for: section)
                }
            }
        }
    }

    @ViewBuilder
    private func sectionView(for section: PrepSection) -> some View {
        let sectionEntries = customContent.entries.filter { $0.section == section }
        if !sectionEntries.isEmpty {
            Section(section.rawValue) {
                ForEach(sectionEntries) { entry in
                    CustomEntryRow(entry: entry) { editingEntry = entry }
                        .swipeActions {
                            Button(role:.destructive) { customContent.delete(entry.id) } label: { Label("Delete", systemImage:"trash") }
                            Button { editingEntry = entry } label: { Label("Edit", systemImage:"pencil") }.tint(.blue)
                        }
                }
            }
        }
    }
}

private struct CustomEntryRow: View {
    let entry: CustomPrepItem
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing:12) {
                Image(systemName: entry.section.icon).foregroundStyle(.secondary)
                VStack(alignment:.leading, spacing:3) {
                    Text(entry.item.title).font(.headline).foregroundStyle(.primary)
                    Text(entry.item.summary).font(.caption).foregroundStyle(.secondary).lineLimit(2)
                }
                Spacer()
                Image(systemName:"chevron.right").font(.caption).foregroundStyle(.tertiary)
            }
        }
    }
}

private struct CustomItemsEmptyState: View {
    var body: some View {
        VStack(spacing:14) {
            Image(systemName:"plus.square")
                .font(.system(size:52))
                .foregroundStyle(.secondary)
            Text("No Custom Items Yet")
                .font(.title2.bold())
            Text("Add your own entrances, topics, games, and exits. They will appear throughout Live Mode and the Library.")
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .padding(40)
    }
}

struct CustomItemEditor: View {
    @EnvironmentObject var customContent: CustomContentStore
    @Environment(\.dismiss) private var dismiss

    let entry: CustomPrepItem?
    @State private var section: PrepSection
    @State private var title: String
    @State private var summary: String
    @State private var details: String
    @State private var group: String
    @State private var badge: String

    init(entry: CustomPrepItem? = nil, initialSection: PrepSection? = nil) {
        self.entry = entry
        _section = State(initialValue: entry?.section ?? initialSection ?? .topic)
        _title = State(initialValue: entry?.item.title ?? "")
        _summary = State(initialValue: entry?.item.summary ?? "")
        _details = State(initialValue: entry?.item.details ?? "")
        _group = State(initialValue: entry?.item.group ?? "")
        _badge = State(initialValue: entry?.item.badge ?? "")
    }

    private var canSave: Bool {
        !title.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty &&
        !summary.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty
    }

    private var existingCategories: [String] {
        let all = ContentData.items(for: section) + customContent.items(for: section)
        return Array(Set(all.map { $0.group })).filter { !$0.isEmpty }.sorted()
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Type") {
                    Picker("Type", selection:$section) {
                        ForEach(PrepSection.allCases) { type in
                            Label(type.rawValue, systemImage:type.icon).tag(type)
                        }
                    }
                }

                Section("Content") {
                    TextField("Title", text:$title)
                    TextField("Short summary / prompt", text:$summary, axis:.vertical)
                        .lineLimit(2...5)
                    TextField("Full details, examples, setup, notes…", text:$details, axis:.vertical)
                        .lineLimit(5...12)
                }

                categorySection

                Section("Badge") {
                    TextField("Badge (optional)", text:$badge)
                }

                Section {
                    Text("Custom items are saved on this device and automatically join Live Mode, search, favorites, and used-item tracking.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(entry == nil ? "Add Your Own" : "Edit Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement:.confirmationAction) {
                    Button("Save") { save() }.disabled(!canSave)
                }
            }
        }
    }

    @ViewBuilder
    private var categorySection: some View {
        Section("Category") {
            if !existingCategories.isEmpty {
                Menu {
                    ForEach(existingCategories, id:\.self) { cat in
                        Button(cat) { group = cat }
                    }
                } label: {
                    HStack {
                        Text("Choose existing category")
                        Spacer()
                        Image(systemName:"chevron.up.chevron.down").font(.caption).foregroundStyle(.secondary)
                    }
                }
            }
            TextField("Category name", text:$group)
            Text("Pick an existing category or type a new one. Your item shows up under that category everywhere this type appears.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private func save() {
        let finalDetails = details.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty ? summary : details
        if let entry {
            customContent.update(entry.id, section:section, title:title, summary:summary, details:finalDetails, group:group, badge:badge)
        } else {
            customContent.add(section:section, title:title, summary:summary, details:finalDetails, group:group, badge:badge)
        }
        dismiss()
    }
}

struct Badge: View {
    let text:String
    var body: some View { Text(text).font(.caption2.bold()).padding(.horizontal,7).padding(.vertical,4).background(.thinMaterial, in:Capsule()) }
}
