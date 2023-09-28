//
//  Colors.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

/*
 Please Before Added new color write HEX Code
 hint Add Bundle .module to access colors from external projects
 */
#warning("Remove once we are use Xcode 15")
public enum HorizonColor: String {
    case whiteColor

    case primaryColor

    case grayColor
    case tabBarColor
    case tabBarSelectedColor
    case tabBarBorderColor
    case darkGray
    case blackColor
    case tFBoderColor
    case redLightColor
}

public extension Color {
    static func horizon(_ color: HorizonColor) -> Color {
        return Color(color.rawValue, bundle: .main)
    }
}
