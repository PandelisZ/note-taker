import SwiftUI

struct TodoItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var isDone: Bool = false
}

struct TodoListPane: View {

    @State private var items: [TodoItem] = []
    @State private var newTitle: String = ""

    @AppStorage("todolist.items") private var persistedData: Data = Data()

    var body: some View {
        Pane {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    TextField("Add a task…", text: $newTitle, onCommit: addItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        addItem()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                List {
                    ForEach($items) { $item in
                        HStack(spacing: 10) {
                            Toggle("", isOn: $item.isDone)
                                .toggleStyle(CheckboxToggleStyle())
                            TextField("Task", text: $item.title)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.inset)
            }
            .padding()
        }
        .navigationSubtitle("To‑Do List")
        .onAppear(perform: load)
        .onChange(of: items, perform: { _ in
            persist()
        })
    }

    private func addItem() {
        let title = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }
        items.append(TodoItem(title: title))
        newTitle = ""
    }

    private func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    private func load() {
        guard !persistedData.isEmpty else { return }
        if let loaded = try? JSONDecoder().decode([TodoItem].self, from: persistedData) {
            items = loaded
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(items) {
            persistedData = data
        }
    }
}

struct TodoListPane_Previews: PreviewProvider {
    static var previews: some View {
        TodoListPane()
    }
}