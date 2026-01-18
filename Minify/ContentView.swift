import SwiftUI

struct ContentView: View {
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .scrollDismissesKeyboard(.automatic)
            .contentShape(Rectangle())
            .onTapGesture { isFocused = false }
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .trailing) {
                    AliasField(isFocused: $isFocused)
                    UrlField(isFocused: $isFocused)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Minify")
            .navigationSubtitle("Long URLs? Nope")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("History", systemImage: "text.alignright") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

