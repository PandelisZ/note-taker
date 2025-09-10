import SwiftUI

struct GeneralSidebarSection: View {
    
    @Binding var selection: SidebarPane?
    
    var body: some View {
        
        Section(header: Text("General")) {
            
            NavigationLink {
                TodoListPane()
            } label: {
                Label("To‑Do List", systemImage: "list.bullet")
            }
        }
    }
}

struct GeneralSidebarSection_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSidebarSection(selection: .constant(.todoList))
    }
}
