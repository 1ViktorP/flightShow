//
//  GameViewModel.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import Foundation

class GameViewModel: ObservableObject {
    
    var currentMode: GameMode
    @Published var scoreCount: Int = 0
    @Published var targetCount: Int = 0 // targetmode
    @Published var seconds: Int = 0 // tournamentMode
    let targetElement: String = "target-\(Int.random(in: 1...3))" // targetmode
    @Published var gameStatus: GameStatus?
    @Published var tryAgain: Bool = false
    @Published var pause: Bool = false
    @Published var continueGame: Bool = false
    init(currentMode: GameMode) {
        self.currentMode = currentMode
        
    }
}
