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

struct GameTrainingItem: Identifiable {
    let id = UUID()
    let name = "trainingBlock"
    var xPosition: CGFloat
    var offset: CGFloat
    var isGoingToRemove: Bool = false
    var isRotate: Bool
    
    static let size = CGSize(width: 112, height: 53)
}
