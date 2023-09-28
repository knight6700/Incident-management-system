//
//  PrimaryButton.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI
/**
 A custom SwiftUI button view with a primary styling.

 `PrimaryButtonView` is designed to serve as the primary action button in your SwiftUI user interface. It offers a stylized button with customizable title text and a specified action to perform when tapped.

 - Parameters:
   - title: The text to display on the button.
   - isDisable: A boolean flag to enable or disable the button.
   - identifier: An accessibility identifier for UI testing.
   - action: A closure representing the action to execute when the button is tapped.

 - Example Usage:
 ```swift
 struct ContentView: View {
     var body: some View {
         VStack {
             // Other UI components here
             PrimaryButtonView(
                 title: "Sign in",
                 isDisable: false,
                 identifier: "signInButton",
                 action: {
                     // Custom action to perform when the button is tapped
                 }
             )
             // Other UI components here
         }
     }
 }
 */

public struct PrimaryButtonView: View {
    var title: String
    var isDisable: Bool
    var action: () -> Void
    var identifier: String
    public init(
        title: String,
        isDisable: Bool,
        identifier: String,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isDisable = isDisable
        self.identifier = identifier
        self.action = action
    }

    public var body: some View {
        Button(
            action: {
                action()
            }
        ) {
            Text(title)
                .font(.headline)
                .foregroundColor(.horizon(.whiteColor))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .accessibilityIdentifier(identifier)
        .buttonStyle(CapsuleButtonStyle(isDisable: isDisable))
        .disabled(isDisable)
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(
            title: "Sign in",
            isDisable: false, identifier: "",
            action: {
            }
        )
    }
}
