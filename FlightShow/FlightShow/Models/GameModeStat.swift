//
//  GameModeStat.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import Foundation

struct GameModeStat: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let played: String
    let winLose: String
}
