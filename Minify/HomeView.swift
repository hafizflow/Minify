import SwiftUI

enum theviews {
    case home, history
}

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
                Group {
                    switch currentView {
                        case .home:
                            ContentView()
                        case .history:
                            HistoryView()
                    }
                }
                .offset(x: (xoffset + sidePosition) / 10)
                .blur(radius: (xoffset + sidePosition) / 10)
                
                SideView(currentView: $currentView, enable: $enablePushButton, Close: {
                    show.toggle()
                    sidePosition -= geo.size.width / 1.5
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
                        drag = rawDrag > 0 ? threshold + slowedExcess : -(threshold + slowedExcess)
                    }
                    
                    switch gesture.state {
                        case.changed:
                            if (sidePosition == 0 && drag >= 0) || (sidePosition > 0 && drag <= 0) {
                                xoffset = drag
                                isKeyboardOpen = false
                                enablePushButton = false
                            }
                        case .ended:
                            withAnimation(.spring(duration: 0.2)) {
                                if drag > 100 && show == false {
                                    sidePosition += geo.size.width / 1.5
                                } else if drag < -100 && sidePosition > 0 {
                                    sidePosition -= geo.size.width / 1.5
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
                    sidePosition -= geo.size.width / 1.5
                }
            }
        }
        
    }
}

struct HistoryView: View {
    var body: some View {
        Text("History View")
    }
}

#Preview {
    HomeView()
}
