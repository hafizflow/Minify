import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    AliasField()
                    UrlField()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Minify")
            .navigationSubtitle("Long URLs? Nope")
            .toolbarTitleDisplayMode(.inlineLarge)
        }
    }
}

#Preview {
    ContentView()
}

