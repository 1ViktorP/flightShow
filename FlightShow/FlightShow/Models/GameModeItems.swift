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

struct GameChampionshipItem: Identifiable {
    let id = UUID()
    let name: String
    var xPosition: CGFloat
    var offset: CGFloat
    var isGoingToRemove: Bool = false
    
    static let size = CGSize(width: 36, height: 36)
}

struct GameTargetTournamentItem: Identifiable {
    let id = UUID()
    let name: String
    var xPosition: CGFloat
    var offset: CGFloat
    var isCatch: Bool = false
    
    static func size(name: String) -> CGSize {
        if name.contains("target") {
           return CGSize(width: 36, height: 36)
        } else {
            return switch name {
            case "enemy-1": CGSize(width: 98, height: 79)
            case "enemy-2": CGSize(width: 107, height: 59)
            case "enemy-3": CGSize(width: 98, height: 31)
            case "enemy-4": CGSize(width: 73, height: 53)
            case "enemy-5": CGSize(width: 87, height: 69)
            case "enemy-6": CGSize(width: 75, height: 54)
            default: CGSize.zero
            }
        }
    }
}

