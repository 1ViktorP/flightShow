//
//  WeightGenerator.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import Foundation

class WeightedRandomGenerator {
    private var weights: [BaseElements]
    
    init(targetIcon: String) {
        // Define the base weight for each type
        let randomElement = "target-\(Int.random(in: 1...6))"
        let randomEnemyElement = "enemy-\(Int.random(in: 1...6))"

        var baseWeights: [BaseElements] = [
            BaseElements(name: randomElement, weight: 1.0),
            BaseElements(name: randomEnemyElement, weight: 1.0),
            BaseElements(name: targetIcon, weight: 1.5)
        ]
        
        // Increase the weight for bombs based on the level
//        if level >= 3 {
//            baseWeights[.bomb] = Double(level) * 0.2
//        }
        
        self.weights = baseWeights
    }
    
    func getRandomIcon() -> String {
        // Calculate the total weight
        let totalWeight = weights.reduce(0) {$0 + $1.weight}
        
        // Generate a random number within the range of the total weight
        let randomValue = Double.random(in: 0..<totalWeight)
        
        // Select a ball type based on the random value and weights
        var cumulativeWeight = 0.0
        for item in weights {
            cumulativeWeight += item.weight
            if randomValue < cumulativeWeight {
                return item.name
            }
        }
        
        // Fallback in case of any rounding errors
        return ""
    }
    
    struct BaseElements {
        let name: String
        let weight: Double
    }
}
