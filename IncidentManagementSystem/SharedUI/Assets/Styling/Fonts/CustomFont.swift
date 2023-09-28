import SwiftUI


public extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        /// 60pt
        case .largeTitle: return 60 // Bold
        /// 40pt
        case .title: return 40 // Bid regular
        /// 34pt
        case .title2: return 34
        /// 24pt
        case .title3: return 20 // semiBold
        /// 18pt
        case .headline, .body: return 18
        /// 17pt
        case .subheadline, .callout: return 17 // Small regular
        /// 15pt
        case .footnote: return 15
        /// 13pt
        case .caption, .caption2: return 13
        @unknown default:
            return 8
        }
    }
}

public extension Font {
    /**
     A Method used to setup Font
     - parameter font:  regular , bold , semiBold
     - parameter style: size for font
     - largeTitle return  60
     - title return 40
     - title2 return 34
     - title3 return 24
     - headline, .body return 18
     - subheadline, .callout return 16
     - footnote return 14
     - caption, .caption2 return 12
     - returns: Font
     */
    static func horizonFont(relativeTo style: Font.TextStyle, weight: Font.Weight, design: Design = .default) -> Font {
        return system(size: style.size, weight: weight, design: design)
    }
}
