import SwiftUI
enum FormFields {
    case description
}

struct CustomTextArea: View {
    var placeHolder: String
    @Binding var text: String
    @FocusState var focusedField: FormFields?

    var body: some View {
        TextField(placeHolder, text: $text, axis: .vertical)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Text("Done")
                    }
                }
            }
            .focused($focusedField, equals: .description)
            .lineLimit(5)
            .autocorrectionDisabled()

            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary, lineWidth: 1) // Customize border color and width
            )
    }
}
