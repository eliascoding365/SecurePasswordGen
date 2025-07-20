import SwiftUI

struct ContentView: View {
    @State private var password = ""
    @State private var length = 12
    @State private var useUppercase = true
    @State private var useNumbers = true
    @State private var useSymbols = true

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Password Generator 🔐")
                .font(.headline)

            Text(password)
                .font(.system(.body, design: .monospaced))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

            HStack {
                Text("Length: \(length)")
                Slider(value: Binding(get: {
                    Double(length)
                }, set: {
                    length = Int($0)
                }), in: 6...24, step: 1)
            }

            Toggle("Include Uppercase", isOn: $useUppercase)
            Toggle("Include Numbers", isOn: $useNumbers)
            Toggle("Include Symbols", isOn: $useSymbols)

            HStack {
                Button("Generate") {
                    password = PasswordGenerator.generate(length: length, useUppercase: useUppercase, useNumbers: useNumbers, useSymbols: useSymbols)
                }
                Button("Copy") {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(password, forType: .string)
                }
            }

            Spacer()
        }
        .padding()
        .frame(width: 280)
    }
}
