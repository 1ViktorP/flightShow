//
//  TextModifier.swift
//  JungleAdventure
//
//  Created by MacBook on 28.06.2024.
//

import SwiftUI

struct TextModifier: ViewModifier {
    var fontType: FontType
    var size: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontType.name, size: size))
            .foregroundStyle(color)
    }
    
    enum FontType {
        case interRegular
        case interBold
        case hamburgerHeaven
       
        var name: String {
            switch self {
            case .interRegular: "Inter-Regular"
          //  case .medium: "Inter-Medium"
        //  case .semiBold: "Inter-SemiBold"
            case .interBold: "Inter-Bold"
            case .hamburgerHeaven: "HamburgerHeaven"
            }
        }
    }
}

extension View {
    func customText(_ fontType: TextModifier.FontType = .interRegular, size: CGFloat = 14, color: Color = .white) -> some View {
        self.modifier(TextModifier(fontType: fontType, size: size, color: color))
    }
}
