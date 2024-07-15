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
        let userPlaneFrame = CGRect(origin: planePosition, size: CGSize(width: UserPlane.size.width - 40, height: UserPlane.size.height - 40))
        
//        let elementXRange = elementFrame.minX...elementFrame.maxX
//        let elementYRange = elementFrame.minY...elementFrame.maxY
//        let userPlaneXRange = (userPlaneFrame.minX + 20)...(userPlaneFrame.maxX - 20)
//        let userPlaneYRange = (userPlaneFrame.minY + 20)...(userPlaneFrame.maxY - 20)
//        
        if elementFrame.intersects(userPlaneFrame) {
            isTouching(true)
        }
    }
}
