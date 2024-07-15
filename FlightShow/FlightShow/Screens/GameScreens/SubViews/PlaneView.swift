//
//  PlaneView.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import SwiftUI

struct PlaneView: View {
    @Binding var position: CGPoint
    @Binding var hasDragged: Bool
    @State private var insidePosition: CGPoint = .zero
    @State private var lastPosition: CGPoint = .zero
    @State private var insideRect: CGRect = .zero
    var body: some View {
        VStack {
            Spacer()
           Rectangle()
                .fill(Color.red.opacity(0.00001))
                .overlay {
                    Image("userPlane")
                        .resizable()
                        .frame(width: UserPlane.size.width, height: UserPlane.size.height)
                }
                .frame(width: UserPlane.size.width, height: UserPlane.size.height)
                .offset(x: insidePosition.x, y: insidePosition.y)
                .background {
                    if !hasDragged {
                        PositionObserver(position: $insideRect)
                            .onChange(of: insideRect) { newValue in
                                position.x = newValue.minX
                                position.y = newValue.minY
                            }
                    }
                }
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged { value in
                                hasDragged = true
                            insidePosition.x = value.translation.width + lastPosition.x
                                position.x = value.location.x - UserPlane.size.width / 2
                            if value.translation.height < 0 && value.translation.height > -30 {
                                insidePosition.y = value.translation.height + lastPosition.y
                                position.y = value.location.y - UserPlane.size.height
                            }
                        }
                        .onEnded({ value in
                            lastPosition.x += value.translation.width
                            lastPosition.y += value.translation.height
                        })
                )
        }
        .frame(maxWidth: .infinity)
        .onChange(of: hasDragged) { newValue in
            if !hasDragged {
            insidePosition = .zero
            lastPosition = .zero
            insideRect = .zero
            }
        }
    }
}
