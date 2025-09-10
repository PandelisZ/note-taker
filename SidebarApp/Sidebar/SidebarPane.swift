import Foundation

enum SidebarPane {
    
    // MARK: Lists / General Section

    case todoList
}

// MARK: - Protocol Conformances

extension SidebarPane: Equatable, Identifiable {
    var id: Self { self }
}
