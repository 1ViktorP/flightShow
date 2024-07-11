//
//  GameViewModel.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import Foundation

class GameViewModel: ObservableObject {
    
    var currentMode: GameMode
    var scoreCount: Int = 0
    @Published var gameStatus: GameStatus?
    @Published var tryAgain: Bool = false
   
    init(currentMode: GameMode) {
        self.currentMode = currentMode
        
    }
}
