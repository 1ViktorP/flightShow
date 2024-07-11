//
//  ChampionshipViewModel.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import Foundation

class ChampionshipViewModel: ObservableObject {
    var timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @Published var elements: [GameChampionshipItem] = []
    var screenWidth: CGFloat = 0.0
    
    func appendElements() {
        if screenWidth > 0 {
            let randomPosition = CGFloat(Int.random(in: 15...(Int(screenWidth) - 16)))
            let name = "target-\(Int.random(in: 1...6))"
            elements.append(GameChampionshipItem(name: name, xPosition: randomPosition, offset: 0))
        }
    }
    
    func checkCollision(elementPosition: CGPoint, planePosition: CGPoint, isTouching: (Bool) -> Void) {
        let  elementFrame = CGRect(origin: CGPoint(x: elementPosition.x,
                                                   y: elementPosition.y),
                                   size: CGSize(width: GameTrainingItem.size.width, height: GameTrainingItem.size.height))
        let userPlaneFrame = CGRect(origin: planePosition, size: CGSize(width: UserPlane.size.width - 10, height: UserPlane.size.height - 10))
        
        let elementXRange = elementFrame.minX...elementFrame.maxX
        let elementYRange = elementFrame.minY...elementFrame.maxY
        let userPlaneXRange = userPlaneFrame.minX...userPlaneFrame.maxX
        let userPlaneYRange = userPlaneFrame.minY...userPlaneFrame.maxY
        
        if (elementXRange.contains(userPlaneXRange.lowerBound) || elementXRange.contains(userPlaneXRange.upperBound)) && (elementYRange.contains(userPlaneYRange.lowerBound) || elementYRange.contains(userPlaneYRange.upperBound)) {
            isTouching(true)
            print("fail here")
            print("element X:  \(elementFrame.minX), \(elementFrame.maxX)")
            print("element Y:  \(elementFrame.minY), \(elementFrame.maxY)")
            
            print("user plane X:  \(userPlaneFrame.minX), \(userPlaneFrame.maxX)")
            print("user plane Y:  \(userPlaneFrame.minY), \(userPlaneFrame.maxY)")
            
        }
    }
}
