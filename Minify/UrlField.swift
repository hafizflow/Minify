import SwiftUI

struct UrlField: View {
    @State private var url: String = ""
    @FocusState.Binding var isFocused: Bool
    
    var isDisable: Bool {
        url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Enter Long URL....", text: $url, axis: .vertical)
                .focused($isFocused)
                .autocorrectionDisabled()
                .padding(.leading, 12)
                .padding(.vertical, 12)
                .contentShape(Rectangle())
            
            Button {
                print(url)
            } label: {
                Image(systemName: "paperplane.fill").padding(4)
            }
            .buttonStyle(.glassProminent)
            .padding(.bottom, 4)
            .contentShape(Rectangle())
            .tint(Color(r: 113, g: 145, b: 175))
            .disabled(isDisable)
        }
        .padding(.trailing, 4)
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
        .padding(.bottom, 12)
    }
}

#Preview {
    @Previewable @FocusState var isFocused: Bool
    UrlField(isFocused: $isFocused)
}
