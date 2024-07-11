//
//  MoneyView.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct ImageTextView: View {
    var text: String
    var image: String = "coin"
    
    var body: some View {
        HStack(spacing: -25) {
            Image(image)
                .resizable()
                .frame(width: 42, height: 42)
                .zIndex(1)
            RoundedRectangle(cornerRadius: 10)
                .fill(.secondaryBG)
                .frame(width: 84, height: 36)
                .overlay {
                    Text(text)
                        .customText(.interBold, color: .secondaryText)
                        .offset(x: 5)
                }
        }
    }
}
