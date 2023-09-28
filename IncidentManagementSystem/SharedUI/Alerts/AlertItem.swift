import Foundation
import SwiftUI

public struct AlertItem: Identifiable {
    public var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

public enum AlertContext {
    // MARK: - Network Errors

    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("There is an error trying to reach the server. If this persists, please contact support."),
                                      dismissButton: .default(Text("Ok")))

    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                            dismissButton: .default(Text("Ok")))

    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           message: Text("Invalid response from the server. Please try again or contact support."),
                                           dismissButton: .default(Text("Ok")))

    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("The data received from the server was invalid. Please try again or contact support."),
                                       dismissButton: .default(Text("Ok")))
    static func customAlert(message: String) -> AlertItem {
        AlertItem(title: Text("Server Error"),
                  message: Text(message),
                  dismissButton: .default(Text("Ok")))
    }
}

public enum CustomError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case custom(message: String)

    func showUrlAlert() -> AlertItem {
        switch self {
        case .invalidData:
            return AlertContext.invalidData

        case .invalidURL:
            return AlertContext.invalidURL

        case .invalidResponse:
            return AlertContext.invalidResponse

        case .unableToComplete:
            return AlertContext.unableToComplete
        case let .custom(message: message):
            return AlertContext.customAlert(message: message)
        }
    }
}

