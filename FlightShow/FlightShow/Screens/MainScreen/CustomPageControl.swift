//
//  CustomPageControl.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct CustomPageControl: View {
    let totalIndex: Int
    let selectedIndex: Int
    var color = Color.mainYellow

    @Namespace private var animation
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<totalIndex, id: \.self) { index in
                if selectedIndex == index {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white.opacity(0.12))
                        .frame(height: 8)
                        .frame(width: 33)
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(color)
                                .frame(height: 8)
                                .frame(width: 33)
                                .matchedGeometryEffect(id: "IndicatorAnimationId", in: animation)
                        }
                } else {
                    Circle()
                        .fill(.white.opacity(0.12))
                        .frame(height: 8)
                }
            }
        }.animation(.spring(), value: UUID())
    }
}
