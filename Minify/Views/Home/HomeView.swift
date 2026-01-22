import SwiftUI

enum theviews { case home }

struct HomeView: View {
    @State var xoffset: CGFloat = 0
    @State var sidePosition: CGFloat = 0
    @State var currentView: theviews = .home
    @State var enablePushButton = true
    @FocusState var isKeyboardOpen: Bool
    @State var show = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ContentView(isFocused: _isKeyboardOpen, enable: $enablePushButton, Open: {
                        // Prevent opening if already open
                    guard sidePosition == 0 else { return }
                    
                    withAnimation(.spring(duration: 0.5)) {
                        sidePosition = geo.size.width / 1.5  // Set directly instead of adding
                    }
                })
                .offset(x: (xoffset + sidePosition) / 10)
                .blur(radius: (xoffset + sidePosition) / 10)
                
                SideView(currentView: $currentView, enable: $enablePushButton, Close: {
                    withAnimation(.spring(duration: 0.5)) {
                        show.toggle()
                        sidePosition = 0  // Set directly to 0 instead of subtracting
                    }
                })
                .offset(x: -geo.size.width / 1.5 + xoffset + sidePosition)
                .opacity(max(0, min(1, (Double(xoffset + sidePosition) - 40) / 100)))
                .blur(radius: max(0, 10 - (xoffset + sidePosition) / 20))
                .zIndex(1)
            }
            .gesture(
                CustomGesture { gesture in
                    let rawDrag = gesture.translation(in: gesture.view).x
                    let threshold = geo.size.width / 1.5
                    let drag: CGFloat
                    
                    if abs(rawDrag) <= threshold {
                        drag = rawDrag
                    } else {
                        let excess = abs(rawDrag) - threshold
                        let slowedExcess = excess / 10
                        drag = rawDrag > 0 ? threshold + slowedExcess : -threshold - slowedExcess
                    }
                    
                    switch gesture.state {
                        case .changed:
                            if sidePosition == 0 && drag >= 0 {
                                    // Closed state: allow drag right (opening)
                                xoffset = drag
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else if sidePosition > 0 && drag <= 0 {
                                    // Open state: allow drag left (closing) but limit it
                                xoffset = max(drag, -sidePosition) // Prevent going past closed position
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else if sidePosition > 0 && drag > 0 {
                                    // Open state: dragging right (beyond open) - slow it down
                                xoffset = drag / 10 // Slowed drag
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else {
                                xoffset = 0
                            }
                        case .ended:
                            withAnimation(.spring(duration: 0.2)) {
                                if drag > 50 && sidePosition == 0 {
                                    sidePosition = geo.size.width / 1.5  // Set directly
                                } else if drag < -50 && sidePosition > 0 {
                                    sidePosition = 0  // Set directly to 0
                                }
                                enablePushButton = true
                                xoffset = 0
                            }
                        default:
                            break
                    }
                }
            )
            .onChange(of: currentView) { oldValue, newValue in
                withAnimation(.spring(duration: 0.2)) {
                    sidePosition = 0  // Set directly to 0
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
