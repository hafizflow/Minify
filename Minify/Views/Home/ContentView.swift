import SwiftUI

struct ContentView: View {
    @FocusState private var isFocused: Bool
    @Binding var enable: Bool
    var Open: () -> Void
    
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HomeImage(isAnimating: isAnimating)
                    AnimatedText(isAnimating: isAnimating)
                    
                    HStack(alignment: .center) {
                        HStack {
                            Text("render.com/hafizflow")
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        
                        Spacer().frame(width: 20)
                        HStack(alignment: .center, spacing: 14) {
                            Button("QR Code", systemImage: "qrcode") {}
                                .labelStyle(.iconOnly)
                                .tint(.red)
                            Button("Share", systemImage: "arrowshape.turn.up.forward") {}
                                .labelStyle(.iconOnly)
                                .tint(.green)
                            Button("Copy", systemImage: "square.on.square") {}
                                .labelStyle(.iconOnly)
                                .tint(Color(r: 113, g: 145, b: 175))
                        }
                    }
                    .padding(.horizontal, 16)
                    .glassEffect(.regular.tint(.blue.opacity(0.05)), in: .rect(cornerRadius: 20))
                    .offset(y: -30)
                }
                .padding(.horizontal)
            }
            .scrollDismissesKeyboard(.interactively)
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
                    Button("History", systemImage: "text.alignright") { Open() }
                    .contentShape(Rectangle())
                    .disabled(!enable)
                }
            }
            .onAppear { withAnimation(.spring(duration: 1)) { isAnimating = true } }
            .onDisappear { isAnimating = false }
        }
    }
}

#Preview {
    ContentView(enable: .constant(true), Open: {})
}
