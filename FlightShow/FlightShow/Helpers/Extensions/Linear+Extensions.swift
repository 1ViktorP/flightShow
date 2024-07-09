//
//  Linear+Extensions.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    static var yellowGradient: LinearGradient {
        LinearGradient(
            stops: [
            Gradient.Stop(color: Color(red: 1, green: 0.74, blue: 0.34), location: 0.00),
            Gradient.Stop(color: Color(red: 1, green: 0.84, blue: 0.33), location: 1.00)
            ],
            startPoint: UnitPoint(x: 0.12, y: 0),
            endPoint: UnitPoint(x: 1.16, y: 1.24)
            )
    }
}
