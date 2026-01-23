import SwiftUI

struct HomeView: View {
    @State var xoffset: CGFloat = 0
    @State var sidePosition: CGFloat = 0
    @State var enablePushButton = true
    @FocusState var isKeyboardOpen: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ContentView(isFocused: _isKeyboardOpen, enable: $enablePushButton, Open: {
                    guard sidePosition == 0 else { return }
                    withAnimation(.spring(duration: 0.5)) {
                        sidePosition = -geo.size.width / 1.5
                        isKeyboardOpen = false
                    }
                })
                .offset(x: (xoffset + sidePosition) / 10)
                .blur(radius: abs((xoffset + sidePosition) / 10))
                
                SideView(isSearchFocused: $isKeyboardOpen, enable: $enablePushButton, Close: {
                    withAnimation(.spring(duration: 0.5)) {
                        sidePosition = 0
                        isKeyboardOpen = false
                    }
                })
                .offset(x: geo.size.width / 1.5 + xoffset + sidePosition)
                .opacity(max(0, min(1, (Double(abs(xoffset + sidePosition)) - 40) / 100)))
                .blur(radius: max(0, 10 - abs(xoffset + sidePosition) / 20))
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
                            if sidePosition == 0 && drag <= 0 {
                                xoffset = drag
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else if sidePosition < 0 && drag >= 0 {
                                xoffset = min(drag, -sidePosition)
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else if sidePosition < 0 && drag < 0 {
                                xoffset = drag / 10
                                isKeyboardOpen = false
                                enablePushButton = false
                            } else {
                                xoffset = 0
                            }
                            
                        case .ended:
                            withAnimation(.spring(duration: 0.2)) {
                                if drag < -50 && sidePosition == 0 {
                                    sidePosition = -geo.size.width / 1.5
                                } else if drag > 50 && sidePosition < 0 {
                                    sidePosition = 0
                                }
                                enablePushButton = true
                                xoffset = 0
                            }
                            
                        default:
                            break
                    }
                }
            )
        }
    }
}

#Preview {
    HomeView()
}
