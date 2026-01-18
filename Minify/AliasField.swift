import SwiftUI

struct AliasField: View {
    @State private var alias: String = ""
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
                
                TextField("Alias...", text: $alias)
                    .autocorrectionDisabled()
                    .padding(.leading, 12)
                    .padding(.vertical, 8)
                    .frame(width: geo.size.width / 2)
                    .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
            }
        }
         .frame(height: 50)
    }
}


#Preview {
    AliasField()
}
