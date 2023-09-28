//
//  Images.swift
//  SocialNetwork
//
//  Created by MahmoudFares on 19/09/2023.
//

import SwiftUI

public protocol ImageProvider {
    // name of Image
    var name: String { get }
    /// which bundle will os get image
    var bundle: Bundle { get }
}

public enum SystemImages: String {
    case eyeFill = "eye.fill"
    case eyeSlashFill = "eye.slash.fill"
}


public extension Image {
    static func horizon(_ image: ImageProvider) -> Image {
        Image(image.name, bundle: image.bundle)
    }

    static func horizon(_ systemImage: SystemImages) -> Image {
        Image(systemName: systemImage.rawValue)
    }
}
