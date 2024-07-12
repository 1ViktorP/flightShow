//
//  TrainingModeScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct TrainingModeScreen: View {
    @ObservedObject var gameVM: GameViewModel
    @StateObject var trainingVM = TrainingViewModel()
    @ObservedObject var displayLink: DisplayLink
    @State private var position: CGRect = .zero
    @State private var animation = Animation.linear
    var planePosition: CGPoint
    var body: some View {
        ZStack(alignment: .top) {
            ForEach( Array(zip(trainingVM.blocks.indices, trainingVM.blocks)), id: \.1.id) { (index, item) in
                Rectangle()
                    .fill(.yellow)
                    .overlay {
                        Image("trainingBlock")
                            .resizable()
                            .frame(width: GameTrainingItem.size.width, height: GameTrainingItem.size.height)
                    }
                    .frame(width: GameTrainingItem.size.width, height: GameTrainingItem.size.height)
                    .rotationEffect(.degrees(item.isRotate ? 90 : 0))
                    .onChange(of: displayLink.updateValue) { _ in
                        if trainingVM.blocks.count > index {
                            trainingVM.blocks[index].offset += 3.2
                            trainingVM.checkCollision(isRotate: item.isRotate, elementPosition: CGPoint(x: trainingVM.blocks[index].xPosition,
                                                                           y: trainingVM.blocks[index].offset),
                                                  planePosition: planePosition) { isTouch in
                                if isTouch {
                                    displayLink.stop()
                                    trainingVM.timer.upstream.connect().cancel()
                                    gameVM.gameStatus = .lose
                                
                                }
                            }
                            if trainingVM.blocks.count > 10 {
                                trainingVM.blocks.removeFirst(5)
                            }
                        }
                    }
                    .position(x: item.xPosition)
                    .offset(y: item.offset)
                    .animation(animation, value: item.offset)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            PositionObserver(position: $position)
                .onChange(of: position) { newValue in
                    trainingVM.screenWidth = newValue.width
                }
        }.onReceive(trainingVM.timer) { _ in
             trainingVM.appendBlocks()
        }.onAppear {
            displayLink.start()
        }.onChange(of: gameVM.tryAgain) { _ in
            if  gameVM.tryAgain {
                trainingVM.blocks.removeAll()
                trainingVM.timer = Timer.publish(every: 2.3, on: .main, in: .default).autoconnect()
                displayLink.start()
                gameVM.tryAgain = false
            }
        }.onChange(of: gameVM.pause) { _ in
            if gameVM.pause {
                displayLink.stop()
                trainingVM.timer.upstream.connect().cancel()
            }
        }.onChange(of: gameVM.continueGame) { _ in
            if gameVM.continueGame {
                displayLink.start()
                trainingVM.timer = Timer.publish(every: 2.3, on: .main, in: .default).autoconnect()
            }
        }
    }
}
