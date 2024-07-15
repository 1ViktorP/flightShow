//
//  TargetEventViewModel.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import Foundation

class TargetEventViewModel: ObservableObject {
    
    var timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @Published var elements: [GameTargetTournamentItem] = []
    var screenWidth: CGFloat = 0.0
    
    func appendElements(targetIcon: String) {
        if screenWidth > 0 {
            let randomPosition = CGFloat(Int.random(in: 0...(Int(screenWidth) - 30)))
            let name = WeightedRandomGenerator(targetIcon: targetIcon).getRandomIcon()
            elements.append(GameTargetTournamentItem(name: name, xPosition: randomPosition, offset: 0))
        }
    }
    
    func checkCollision(elementPosition: CGPoint, elementName: String, planePosition: CGPoint, isTouching: (Bool) -> Void) {
        let  elementFrame = CGRect(origin: CGPoint(x: elementPosition.x,
                                                   y: elementPosition.y),
                                   size: CGSize(width: GameTargetTournamentItem.size(name: elementName).width,
                                                height: GameTargetTournamentItem.size(name: elementName).height))
        let userPlaneFrame = CGRect(origin: planePosition, size: CGSize(width: UserPlane.size.width, height: UserPlane.size.height))
        
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
            
        } else {
            print("pass here")
            print(elementName)
            print("element X:  \(elementFrame.minX), \(elementFrame.maxX)")
            print("element Y:  \(elementFrame.minY), \(elementFrame.maxY)")
            
            print("user plane X:  \(userPlaneFrame.minX), \(userPlaneFrame.maxX)")
            print("user plane Y:  \(userPlaneFrame.minY), \(userPlaneFrame.maxY)")
        }
    }
}
