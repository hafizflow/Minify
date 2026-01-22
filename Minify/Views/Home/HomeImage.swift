import SwiftUI

struct HomeImage: View {
    let isAnimating: Bool
    
    var body: some View {
        Image(.link)
            .resizable()
            .scaledToFit()
            .offset(y: isAnimating ? -50 : 0)
            .opacity(isAnimating ? 1 : 0)
    }
}

#Preview {
    HomeImage(isAnimating: true)
}
