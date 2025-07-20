import Foundation

struct PasswordGenerator {
    static func generate(length: Int, useUppercase: Bool, useNumbers: Bool, useSymbols: Bool) -> String {
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        let symbols = "!@#$%&*?"

        var characters = lowercaseLetters
        if useUppercase { characters += uppercaseLetters }
        if useNumbers { characters += numbers }
        if useSymbols { characters += symbols }

        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}
