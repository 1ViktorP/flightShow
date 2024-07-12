//
//  ProfileViewModel.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    var gameModeStat: [GameModeStat] = []
    @Published var gameCountStat: GameStatCount = GameStatCount(winCount: 0, loseCount: 0)
    private var saveManager: Saveable
    init(saveManager: Saveable) {
        self.saveManager = saveManager
        fetchModeStat()
        fetchGameCountStat()
    }
    
    func fetchGameCountStat() {
        gameCountStat = saveManager.fetchStat()
    }
    
    func fetchModeStat() {
        gameModeStat = saveManager.fetchGameModeStat()
    }
    
    var winRate: String {
        let totalGames = gameCountStat.winCount + gameCountStat.loseCount
            guard totalGames > 0 else { return "0" }
        return String(Int(Double(gameCountStat.winCount) / Double(totalGames) * 100))
    }
    
    var played: String {
        "\(gameCountStat.winCount + gameCountStat.loseCount)"
    }
    
    var winLoseCount: String {
        "\(gameCountStat.winCount) / \(gameCountStat.loseCount)"
    }
    
    var longest: String {
        (gameModeStat.first(where: {$0.modeRaw == GameMode.tournament.rawValue})?.seconds.max()?.toTimeText() ?? "") + " min."
    }
}
