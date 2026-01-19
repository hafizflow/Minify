import SwiftUI

struct ContentView: View {
    @FocusState private var isFocused: Bool
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Image(.link)
                        .resizable()
                        .scaledToFit()
                        .offset(y: isAnimating ? -50 : 0)
                        .opacity(isAnimating ? 1 : 0)

                    AnimatedText(isAnimating: isAnimating)
                }
                .padding(.horizontal)
            }
            .scrollDismissesKeyboard(.automatic)
            .contentShape(Rectangle())
            .onTapGesture { isFocused = false }
            .safeAreaInset(edge: .bottom) {
                VStack {
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
                    .contentShape(Rectangle())
                }
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
        }
    }
}

#Preview {
    ContentView()
}
