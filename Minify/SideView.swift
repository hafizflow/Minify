import SwiftUI

struct SideView: View {
    @Binding var currentView: theviews
    @Binding var enable: Bool
    var Close: () -> Void
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    
                }
            }
            .navigationTitle("History")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Hello", systemImage: "plus") {}
                }
            }
        }
    }
}

#Preview {
    SideView(currentView: .constant(.home), enable: .constant(true), Close: {})
}
