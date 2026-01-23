import SwiftUI

struct UrlField: View {
    @State private var url: String = ""
    @FocusState.Binding var isFocused: Bool
    
    var isDisable: Bool {
        url.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Enter Long URL....", text: $url, prompt: Text("Enter Long URL....")
                .foregroundColor(.white.opacity(0.65)), axis: .vertical)
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.leading, 16)
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
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 30))
        .padding(.bottom, isFocused ? 12 : 0)
    }
}

#Preview {
    @Previewable @FocusState var isFocused: Bool
    UrlField(isFocused: $isFocused)
}
