import Foundation

extension Date {
    func formattedString() -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        return outputFormatter.string(from: self)
    }
}

