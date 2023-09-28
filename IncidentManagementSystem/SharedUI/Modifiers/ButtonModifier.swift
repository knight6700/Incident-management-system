//
//  ButtonModifier.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

/**
 A custom SwiftUI button style that provides a stylized, capsule-shaped button appearance.

 `CapsuleButtonStyle` can be applied to SwiftUI buttons to give them a distinctive, capsule-shaped design with customizable background and text color when button click with primary color and opacity
 It's especially useful for creating visually appealing buttons in your user interface.

 - Example Usage

    To use `CapsuleButtonStyle`, apply it as a button style to any SwiftUI button. You can customize the button's appearance by adjusting the background and text colors.

 ```swift
 Button("Click Me") {
     // Action to perform when the button is tapped
 }
 .buttonStyle(CapsuleButtonStyle()) // Apply the custom button style
 */
public struct CapsuleButtonStyle: ButtonStyle {
    var isDisable: Bool
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                Capsule()
                    .fill(
                        configuration.isPressed
                            ? Color.horizon(.whiteColor).opacity(0.8)
                        : isDisable ? Color.horizon(.tFBoderColor).opacity(0.5) : Color.horizon(.blackColor)
                    )
            )
    }
}
