//
//  Status.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import Foundation

enum GameStatus {
    case win
    case lose
    case exit
    
    var icon: String {
        switch self {
        case .win:
            return "winLogo"
        case .lose:
            return "loseLogo"
        case .exit:
            return "exitLogo"
        }
    }
    
    var iconFrame: CGSize {
        switch self {
        case .win:
            return CGSize(width: 124, height: 124)
        case .lose:
            return CGSize(width: 173, height: 181)
        case .exit:
            return CGSize(width: 134, height: 134)
        }
    }
    
    var title: String {
        switch self {
        case .win:
            return "Congratulations!"
        case .lose:
            return "Lose!"
        case .exit:
            return "Exit"
        }
    }
    
    var description: String {
        switch self {
        case .win:
            return "You've won!"
        case .lose:
            return "Unfortunately, you lost."
        case .exit:
            return "Are you sure you want to exit?"
        }
    }
}
