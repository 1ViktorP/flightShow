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
}
