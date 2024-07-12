//
//  UserManager.swift
//  JungleAdventure
//
//  Created by MacBook on 02.07.2024.
//

import Foundation

class UserManager: ObservableObject {
    @Published var userMoney: Int = 0
    @Published var tickets: Int = 0
    var gameModeStat: [GameModeStat] = []
    private var saveManager: Saveable
    init(saveManager: Saveable) {
        self.saveManager = saveManager
        addInitialData()
    }
    
    func addInitialData() {
        if  UserDefaults.standard.object(forKey: Keys.userBase.rawValue) == nil {
            userMoney = 5000
            tickets = 10
            saveManager.updateBaseData(userBase: UserBase(money: userMoney, ticket: tickets))
        } else {
            let baseData = saveManager.fetchBaseData()
            userMoney = baseData.money
            tickets = baseData.ticket
        }
    }
        
    func updateUserData() {
        saveManager.updateBaseData(userBase: UserBase(money: userMoney, ticket: tickets))
    }

    func saveGameCountStat(game: GameMode, isWin: Bool) {
        var gameCountStat = saveManager.fetchStat()

        if isWin {
            gameCountStat.winCount += 1
        } else {
            gameCountStat.loseCount += 1
        }
        saveManager.saveStat(stat: gameCountStat)
    }
    
    func saveModeStat(game: GameMode, isWin: Bool, seconds: Int = 0) {
        gameModeStat = saveManager.fetchGameModeStat()
        if let firstIndex = gameModeStat.firstIndex(where: {$0.modeRaw == game.rawValue }) {
            gameModeStat[firstIndex].played += 1
            gameModeStat[firstIndex].win += isWin ? 1 : 0
            gameModeStat[firstIndex].lose += isWin ? 0 : 1
            gameModeStat[firstIndex].seconds.append(seconds)
            if gameModeStat[firstIndex].played % 10 == 0 {
                gameModeStat[firstIndex].level += 1
            }
        } else {
            gameModeStat.append(GameModeStat(modeRaw: game.rawValue,
                                             title: game.title + " " + game.subTitle,
                                             icon: game.icon,
                                             played: 1,
                                             win: isWin ? 1 : 0,
                                             lose: isWin ? 0 : 1,
                                             level: 1, seconds: [seconds]))
        }
        saveManager.saveGameModeStat(stat: gameModeStat)
    }
    
    func fetchLevelMode(mode: GameMode) -> Int {
         saveManager.fetchGameModeStat().first(where: {$0.modeRaw == mode.rawValue})?.level ?? 1
    }
}
