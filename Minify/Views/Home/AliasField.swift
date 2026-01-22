import SwiftUI

struct AliasField: View {
    @State private var alias: String = ""
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                TextField("Add Alias...", text: $alias)
                    .focused($isFocused)
                    .autocorrectionDisabled()
                    .padding(.leading, 12)
                    .padding(.vertical, 8)
                    .contentShape(Rectangle())
                    .disabled(true)
                
                
                Button("Primium", systemImage: "crown.fill") {
                    
                }
                .labelStyle(.iconOnly)
                .foregroundStyle(.yellow.opacity(0.9))
                .padding(.trailing, 8)
                .contentShape(Rectangle())
            }
            .frame(width: geo.size.width / 2)
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
            .frame(width: geo.size.width, alignment: .trailing)
        }
        .frame(height: 50)
    }
}


#Preview {
    @Previewable @FocusState var isFocused: Bool
    AliasField(isFocused: $isFocused)
}
