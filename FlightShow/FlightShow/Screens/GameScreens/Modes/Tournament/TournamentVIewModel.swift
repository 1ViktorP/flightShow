//
//  TournamentVIewModel.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import Foundation

class TournamentVIewModel: ObservableObject {
    
    var timer = Timer.publish(every: 1.5, on: .main, in: .default).autoconnect()
    @Published var elements: [GameTargetTournamentItem] = []
    var screenWidth: CGFloat = 0.0
    
    func appendElements() {
        if screenWidth > 0 {
            let randomPosition = CGFloat(Int.random(in: 0...(Int(screenWidth) - 30)))
            let name = "enemy-\(Int.random(in: 1...6))"
            elements.append(GameTargetTournamentItem(name: name, xPosition: randomPosition, offset: 0))
        }
    }
    
    func checkCollision(elementPosition: CGPoint, elementName: String, planePosition: CGPoint, isTouching: (Bool) -> Void) {
        let  elementFrame = CGRect(origin: CGPoint(x: elementPosition.x,
                                                   y: elementPosition.y),
                                   size: CGSize(width: GameTargetTournamentItem.size(name: elementName).width,
                                                height: GameTargetTournamentItem.size(name: elementName).height))
       
        let planePositionWidth = CGPoint(x: planePosition.x, y: planePosition.y + UserPlane.size.height / 3)
        let userPlaneFrameWidth = CGRect(origin: planePositionWidth, size: CGSize(width: UserPlane.size.width, height: 40))
        let planePositionHeight = CGPoint(x: planePosition.x + UserPlane.size.width / 3, y: planePosition.y)
        let userPlaneFrameHeight = CGRect(origin: planePositionHeight, size: CGSize(width: 40, height: UserPlane.size.height))

        if elementFrame.intersects(userPlaneFrameWidth) || elementFrame.intersects(userPlaneFrameHeight) {
            isTouching(true)
        }
    }
}
