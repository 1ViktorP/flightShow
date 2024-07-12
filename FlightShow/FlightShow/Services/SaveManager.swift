//
//  SaveManager.swift
//  LinkoBolls
//
//  Created by MacBook on 20.06.2024.
//

import Foundation

protocol Saveable {
    func updateBaseData(userBase: UserBase)
    func fetchBaseData() -> UserBase
    func fetchStat() -> GameStatCount
    func saveStat(stat: GameStatCount)
    func fetchGameModeStat() -> [GameModeStat]
    func saveGameModeStat(stat: [GameModeStat])
}

class SaveManager: Saveable, ObservableObject {
  
    static let shared = SaveManager()
    
    private init() { }
    
    func updateBaseData(userBase: UserBase) {
        saveData(encodeData: userBase, key: Keys.userBase.rawValue)
    }
    
    func fetchBaseData() -> UserBase {
        if let userBase: UserBase = retrieveData(key: Keys.userBase.rawValue) {
            return userBase
        } else {
            return UserBase(money: 0, ticket: 0)
        }
    }
    
    func fetchStat() -> GameStatCount {
        if let gameStat: GameStatCount = retrieveData(key: Keys.statCount.rawValue) {
            return gameStat
        } else {
            return GameStatCount(winCount: 0, loseCount: 0)
        }
    }
    
    func saveStat(stat: GameStatCount) {
        saveData(encodeData: stat, key: Keys.statCount.rawValue)
    }
    
    func fetchGameModeStat() -> [GameModeStat] {
        if let gameModeStat: [GameModeStat] = retrieveData(key: Keys.gameModeStat.rawValue) {
            return gameModeStat
        } else {
            return []
        }
    }
    
    func saveGameModeStat(stat: [GameModeStat]) {
        saveData(encodeData: stat, key: Keys.gameModeStat.rawValue)
    }
 
    private func removeAllData(key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}

extension SaveManager {
    // only general logic
   private func saveData<T: Encodable>(encodeData: T, key: String) {
       let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(encodeData) {
              print("saved")
              UserDefaults.standard.set(encoded, forKey: key)
          }
   }
   
    private func retrieveData<T: Decodable>(key: String) -> T? {
       var data: T?
       if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
           print("tryToRetrieve")
               let decoder = JSONDecoder()
               if let loadedData = try? decoder.decode(T.self, from: savedData) {
                  print("retrieved")
                   data = loadedData
               }
       }
       return data
   }
}

enum Keys: String {
    case userBase
    case statCount
    case gameModeStat
}
