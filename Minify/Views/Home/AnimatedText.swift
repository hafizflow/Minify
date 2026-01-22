import SwiftUI

struct AnimatedText: View {
    let isAnimating: Bool
    
    @State private var currentIndex = 0
    @State private var displayedText = AppStrings.featureDescriptions[0]
    
    var body: some View {
        Text(displayedText)
            .font(.callout)
            .fontDesign(.rounded)
            .foregroundStyle(.gray)
            .offset(y: isAnimating ? -50 : 0)
            .opacity(isAnimating ? 1 : 0)
            .id(displayedText)
            .transition(
                .asymmetric(
                    insertion: .opacity.combined(with: .move(edge: .bottom)),
                    removal: .opacity.combined(with: .move(edge: .top))
                )
            )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                    currentIndex = (currentIndex + 1) % AppStrings.featureDescriptions.count
                    withAnimation(.smooth(duration: 0.75)) {
                        displayedText = AppStrings.featureDescriptions[currentIndex]
                    }
                }
            }
    }
}

#Preview {
    AnimatedText(isAnimating: true)
}
