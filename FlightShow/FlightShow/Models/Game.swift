//
//  Game.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import Foundation

enum GameMode: CaseIterable {
    case tournament
    case event
    case championship
    case training
    
    var title: String {
        switch self {
        case .tournament:
            return "Endless Soar"
        case .event:
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
        case .event:
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
        case .event:
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
        case .event:
            return "Targets appear at increasing speeds. React quickly to avoid collisions and collect the designated elements on your flight path."
        case .championship:
            return "Collect all scattered elements during your flight. Each collected element increases your score. Missing any element will result in you losing the game."
        case .training:
            return "This is a free test mode where you practice flying between blocks to prepare for real flights."
        }
    }
}
