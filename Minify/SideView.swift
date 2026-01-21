import SwiftUI

struct SideView: View {
    @Binding var currentView: theviews
    @Binding var enable: Bool
    var Close: () -> Void
    
    @State private var search: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                }
            }
            .searchable(text: $search) { }
            .navigationTitle("History")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Hello", systemImage: "chevron.forward.dotted.chevron.forward") {
                        withAnimation(.spring(duration: 0.2)) {
                            Close()
                        }
                    }
                    .disabled(!enable)
                }
                
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Settings", systemImage: "gear") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    SideView(currentView: .constant(.home), enable: .constant(true), Close: {})
}
