//
//  Sho.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import Foundation

struct Shop: Identifiable {
    let id = UUID()
    let tickets: Int
    let price: Int
    
    static let shopItems: [Shop] = [
    ]
}
