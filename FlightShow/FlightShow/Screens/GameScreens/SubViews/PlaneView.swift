//
//  PlaneView.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import SwiftUI

struct PlaneView: View {
    @Binding var position: CGPoint
    @State private var insidePosition: CGPoint = .zero
    @State private var insideRect: CGRect = .zero
    @State private var hasDragged: Bool = false
    var body: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.clear)
                .overlay {
                    Image("userPlane")
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: UserPlane.size.width, height: UserPlane.size.height)
                .offset(x: insidePosition.x, y: insidePosition.y)
                .background {
                    if !hasDragged {
                        PositionObserver(position: $insideRect)
                            .onChange(of: insideRect) { newValue in
                                position.x = newValue.origin.x + UserPlane.size.width
                                position.y = newValue.origin.y + UserPlane.size.height
                            }
                    }
                }
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged { value in
                            hasDragged = true
                            insidePosition.x = value.translation.width
                            position.x = value.location.x
                            if value.translation.height < 0 && value.translation.height > -30 {
                                insidePosition.y = value.translation.height
                                position.y = value.location.y - UserPlane.size.height
                            }
                        }
                )
        }
        .frame(maxWidth: .infinity)
    }
}
