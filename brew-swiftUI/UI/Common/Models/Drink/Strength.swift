//
//  Strength.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 17/11/2022.
//

import SwiftUI

enum Strength: String, CaseIterable {
    case extraWeak = "extra weak"
    case weak
    case medium
    case mediumToStrong = "medium to strong"
    case strong
    case extraStrong = "extra strong"
    case black = "black"

    var title: String {
        return rawValue
    }

    var color: Color {
        switch self {
        case .extraWeak:
            return Color("cream")
        case .weak:
            return Color("beige")
        case .medium:
            return Color("lightBrown")
        case .mediumToStrong:
            return Color("brown")
        case .strong:
            return Color("darkBrown")
        case .extraStrong:
            return Color("darkerBrown")
        case .black:
            return Color("black")
        }
    }

    var textcolor: UIColor {
        switch self {
        case .extraWeak:
            return #colorLiteral(red: 0.5960784314, green: 0.4196078431, blue: 0.2941176471, alpha: 1)
        case .weak:
            return #colorLiteral(red: 0.2117647059, green: 0.1490196078, blue: 0.1058823529, alpha: 1)
        case .medium:
            return #colorLiteral(red: 0.9607843137, green: 0.937254902, blue: 0.9215686275, alpha: 1)
        case .mediumToStrong:
            return #colorLiteral(red: 0.9607843137, green: 0.937254902, blue: 0.9215686275, alpha: 1)
        case .strong:
            return #colorLiteral(red: 0.8235294118, green: 0.7176470588, blue: 0.6431372549, alpha: 1)
        case .extraStrong:
            return #colorLiteral(red: 0.8235294118, green: 0.7176470588, blue: 0.6431372549, alpha: 1)
        case .black:
            return #colorLiteral(red: 0.8235294118, green: 0.7176470588, blue: 0.6431372549, alpha: 1)
        }
    }

    init?(value: Int) {
        let strengths = Strength.allCases
        self = strengths[value]
    }

    var value: Int {
        return Strength.allCases.firstIndex(of: self) ?? 4
    }
}
