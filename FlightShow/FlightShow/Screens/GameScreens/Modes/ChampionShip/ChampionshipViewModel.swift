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
        let planePositionWidth = CGPoint(x: planePosition.x, y: planePosition.y + UserPlane.size.height / 3.4)
        let userPlaneFrameWidth = CGRect(origin: planePositionWidth, size: CGSize(width: UserPlane.size.width, height: 35))
        let planePositionHeight = CGPoint(x: planePosition.x + UserPlane.size.width / 3.4, y: planePosition.y)
        let userPlaneFrameHeight = CGRect(origin: planePositionHeight, size: CGSize(width: 35, height: UserPlane.size.height))

        if elementFrame.intersects(userPlaneFrameWidth) || elementFrame.intersects(userPlaneFrameHeight) {
            isTouching(true)
        }
    }
}
