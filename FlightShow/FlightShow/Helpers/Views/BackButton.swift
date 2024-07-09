//
//  BackButton.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

struct BackButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(.secondaryBG)
                .frame(width: 44, height: 44)
                .overlay {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondaryText)
                }
        })
    }
}
