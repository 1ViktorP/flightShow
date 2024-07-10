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
