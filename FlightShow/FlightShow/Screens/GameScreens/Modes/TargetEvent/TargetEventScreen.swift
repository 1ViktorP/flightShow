//
//  TargetEventScreen.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import SwiftUI

struct TargetEventScreen: View {
    @ObservedObject var gameVM: GameViewModel
    @StateObject var targetVM = TargetEventViewModel()
    @ObservedObject var displayLink: DisplayLink
    @State private var position: CGRect = .zero
    @State private var animation = Animation.linear
    var planePosition: CGPoint
   
    var body: some View {
        ZStack(alignment: .top) {
            ForEach( Array(zip(targetVM.elements.indices, targetVM.elements)), id: \.1.id) { (index, item) in
                Rectangle()
                    .fill(.clear)
                    .overlay {
                        Image(item.name)
                            .resizable()
                            .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    }
                    .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    .onChange(of: displayLink.updateValue) { _ in
                        if targetVM.elements.count > index {
                            targetVM.elements[index].offset += 4
                            targetVM.checkCollision(elementPosition: CGPoint(x: targetVM.elements[index].xPosition,
                                                                              y: targetVM.elements[index].offset),
                                                    elementName: item.name,
                                                    planePosition: planePosition) { isTouch in
                                
                                if isTouch && targetVM.elements[index].name == gameVM.targetElement {
                                    if !targetVM.elements[index].isCatch {
                                        gameVM.scoreCount += 1
                                    }
                                    targetVM.elements[index].isCatch = true
                                } else {
                                    if !targetVM.elements[index].isCatch {
                                        displayLink.stop()
                                        targetVM.timer.upstream.connect().cancel()
                                        gameVM.gameStatus = .lose
                                    }
                                    targetVM.elements[index].isCatch = true
                                }
                            }
                            if targetVM.elements[index].offset > 1000 {
                                targetVM.elements.remove(at: index)
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
                    targetVM.screenWidth = newValue.width
                }
        }.onReceive(targetVM.timer) { _ in
            targetVM.appendElements(targetIcon: gameVM.targetElement)
        }.onAppear {
            displayLink.start()
        }.onChange(of: gameVM.tryAgain) { _ in
            if  gameVM.tryAgain {
                gameVM.targetCount = 0
                targetVM.elements.removeAll()
                targetVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
                displayLink.start()
                gameVM.tryAgain = false
            }
        }.onChange(of: gameVM.pause) { _ in
            if gameVM.pause {
                displayLink.stop()
                targetVM.timer.upstream.connect().cancel()
            }
        }.onChange(of: gameVM.continueGame) { _ in
            if gameVM.continueGame {
                displayLink.start()
                targetVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
            }
        }.onChange(of: gameVM.scoreCount) { newValue in
            if newValue >= gameVM.targetCount {
                gameVM.gameStatus = .win
                displayLink.stop()
                targetVM.timer.upstream.connect().cancel()
            }
        }
    }
}
