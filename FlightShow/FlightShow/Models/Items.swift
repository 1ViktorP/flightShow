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
        Shop(tickets: 1, price: 10),
        Shop(tickets: 3, price: 27),
        Shop(tickets: 5, price: 45),
        Shop(tickets: 10, price: 85),
        Shop(tickets: 20, price: 170),
        Shop(tickets: 25, price: 210)

    ]
    
    static let shopSpecicalItems: [Shop] = [
        Shop(tickets: 100, price: 500),
        Shop(tickets: 100, price: 500),
        Shop(tickets: 100, price: 100)
    ]
}


struct UserBase: Codable {
    var money: Int
    var ticket: Int
}

struct GameModeStat: Identifiable, Codable {
    var id = UUID()
    let modeRaw: String
    let title: String
    let icon: String
    var played: Int
    var win: Int
    var lose: Int
    var level: Int
    var seconds: [Int]
}

struct GameStatCount: Codable {
    var winCount: Int
    var loseCount: Int
}
