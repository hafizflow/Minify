import SwiftUI

struct UrlField: View {
    @State private var url: String = ""
    @State private var isDisable: Bool = true
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Enter Long URL....", text: $url, axis: .vertical)
                .autocorrectionDisabled()
                .padding(.leading, 12)
                .padding(.vertical, 12)
                .clipShape(.capsule)
            
            Button {
                print(url)
            } label: {
                Image(systemName: "paperplane.fill")
                    .padding(4)
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(.concentric)
            .padding(.bottom, 4)
            .disabled(isDisable)
        }
        .padding(.trailing, 4)
        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
    }
}

#Preview {
    UrlField()
}
