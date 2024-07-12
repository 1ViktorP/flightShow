//
//  Game.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import Foundation

enum GameMode: String, CaseIterable {
    case tournament
    case targetEvent
    case championship
    case training
    
    var title: String {
        switch self {
        case .tournament:
            return "Endless Soar"
        case .targetEvent:
            return "Accelerated Targets"
        case .championship:
            return "Element"
        case .training:
            return "Training"
        }
    }
    
    var subTitle: String {
        switch self {
        case .tournament:
            return "Tournament"
        case .targetEvent:
            return "Event"
        case .championship:
            return "Championship"
        case .training:
            return "Flights"
        }
    }
    
    var icon: String {
        switch self {
        case .tournament:
            return "tournament"
        case .targetEvent:
            return "event"
        case .championship:
            return "championship"
        case .training:
            return "training"
        }
    }
    
    var description: String {
        switch self {
        case .tournament:
            return "In this mode, your goal is to achieve the longest flight possible. Stay in the air as long as you can while avoiding obstacles. "
        case .targetEvent:
            return "Targets appear at increasing speeds. React quickly to avoid collisions and collect the designated elements on your flight path."
        case .championship:
            return "Collect all scattered elements during your flight. Each collected element increases your score. Missing any element will result in you losing the game."
        case .training:
            return "This is a free test mode where you practice flying between blocks to prepare for real flights."
        }
    }
    
    var paymentGame: Int {
        if self == .training {
            return 0
        } else {
            return 2
        }
    }
    
    func updateSpeedForLevel(level: Int) -> Double {
        return switch self {
        case .tournament:
            if level > 10 {
                 Double(level) * 0.05
            } else {
                3.0
            }
        case .targetEvent:
            4.0
        case .championship:
            if level > 30 {
                6.5
            } else if level > 10 {
                Double(level) * 0.1 + 3.2
            } else {
                3.2
            }
        case .training:
             3.2
        }
    }
    
}
