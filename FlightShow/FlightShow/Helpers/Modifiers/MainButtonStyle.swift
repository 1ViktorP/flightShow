//
//  MainButtonStyle.swift
//  MasterBall
//
//  Created by MacBook on 27.05.2024.
//

import SwiftUI

struct MainButton: ButtonStyle {
    var height: CGFloat = 54
    var isHamburger: Bool = true
    var disable: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom(isHamburger ? "HamburgerHeaven" : "Inter-Bold", size: isHamburger ? 34 : 17))
            .shadow(color: .black.opacity(0.35), radius: 2.8, y: 2)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background {
                if disable {
                    Color.gray
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.shadow(.inner(color: Color(red: 0.9333, green: 0.4078, blue: 0), radius: 2, y: -2)))
                        .foregroundStyle( LinearGradient.yellowGradient)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
