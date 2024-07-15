//
//  TrainingViewModel.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import Foundation

class TrainingViewModel: ObservableObject {
    
    var timer = Timer.publish(every: 2.3, on: .main, in: .default).autoconnect()
   
    @Published var blocks: [GameTrainingItem] = []
    var screenWidth: CGFloat = 0.0
    
    func appendBlocks() {
        if screenWidth > 0 {
            let isRotate: Bool = .random()
            var randomPosition: CGFloat = 0.0
            if isRotate {
                randomPosition = CGFloat(Int.random(in: 15...(Int(screenWidth) - (Int(GameTrainingItem.size.height) - 16))))
            } else {
                randomPosition =  CGFloat(Int.random(in: 15...(Int(screenWidth) - (Int(GameTrainingItem.size.width) - 16))))
            }
            blocks.append(GameTrainingItem(xPosition: randomPosition, offset: 0, isRotate: isRotate))
        }
    }
    
    func checkCollision(isRotate: Bool, elementPosition: CGPoint, planePosition: CGPoint, isTouching: (Bool) -> Void) {
        var elementFrame: CGRect = .zero
        if isRotate {
            elementFrame = CGRect(origin: CGPoint(x: elementPosition.x,
                                                  y: elementPosition.y),
                                  size: CGSize(width: GameTrainingItem.size.height, height: GameTrainingItem.size.width))
            
        } else {
            elementFrame = CGRect(origin: CGPoint(x: elementPosition.x,
                                                  y: elementPosition.y),
                                  size: CGSize(width: GameTrainingItem.size.width, height: GameTrainingItem.size.height))
        }
        
        let planePositionWidth = CGPoint(x: planePosition.x - 5, y: planePosition.y + UserPlane.size.height / 3.3)
        let userPlaneFrameWidth = CGRect(origin: planePositionWidth, size: CGSize(width: UserPlane.size.width, height: 35))
        let planePositionHeight = CGPoint(x: planePosition.x + UserPlane.size.width / 3.2, y: planePosition.y)
        let userPlaneFrameHeight = CGRect(origin: planePositionHeight, size: CGSize(width: 35, height: UserPlane.size.height))

        if elementFrame.intersects(userPlaneFrameWidth) || elementFrame.intersects(userPlaneFrameHeight) {
            isTouching(true)
            print("element min/max X: \(elementFrame.minX)" + ":" + "\(elementFrame.maxX)")
            print("element min/max Y: \(elementFrame.minY)" + ":" + "\( elementFrame.maxY)")
            print("userPlaneFrameWidth X: \(userPlaneFrameWidth.minX)" + ":" + "\(userPlaneFrameWidth.maxX) ")
            print("userPlaneFrameWidth Y: \(userPlaneFrameWidth.minY)" + ":" +  "\(userPlaneFrameWidth.maxY) ")
            print("userPlaneFrameheight X: \(userPlaneFrameHeight.minX)" + ":" +  "\(userPlaneFrameHeight.maxX)")
            print("userPlaneFrameheight Y: \(userPlaneFrameHeight.minY)" + ":" +  "\(userPlaneFrameHeight.maxY)")
        }
    }
}
