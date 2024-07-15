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
                    .fill(Color.red.opacity(0.00001))
                    .overlay {
                        Image(item.name)
                            .resizable()
                            .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    }
                    .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    .onChange(of: displayLink.updateValue) { _ in
                        if targetVM.elements.count > index {
                         //   targetVM.elements[index].offset += gameVM.speed
                            targetVM.checkCollision(elementPosition: CGPoint(x: targetVM.elements[index].xPosition,
                                                                             y: targetVM.elements[index].offset),
                                                    elementName: item.name,
                                                    planePosition: planePosition) { isTouch in
                                if isTouch && targetVM.elements[index].name == gameVM.targetElement {
                                    if !targetVM.elements[index].isCatch {
                                        gameVM.scoreCount += 1
                                    }
                                    targetVM.elements[index].isCatch = true
                                    if  self.targetVM.elements[index].isCatch {
                                        self.targetVM.elements.remove(at: index)
                                    }
                                } else {
                                    if !targetVM.elements[index].isCatch {
                                        displayLink.stop()
                                        targetVM.timer.upstream.connect().cancel()
                                        gameVM.gameStatus = .lose
                                    }
                                }
                            }
                            if targetVM.elements[index].offset > 920 {
                                targetVM.elements.remove(at: index)
                            }
                            targetVM.elements[index].offset += gameVM.speed
                        }
                    }
                    .position(x: item.xPosition + GameTargetTournamentItem.size(name: item.name).width / 2)
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
                    gameVM.scoreCount = 0
                    targetVM.elements.removeAll()
                    targetVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
                    displayLink.start()
                    gameVM.tryAgain = false
                }
            }.onChange(of: gameVM.pause) { _ in
                if gameVM.pause {
                    displayLink.stop()
                    targetVM.timer.upstream.connect().cancel()
                } else {
                    displayLink.start()
                    targetVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
                }
            }.onChange(of: gameVM.continueGame) { _ in
                if gameVM.continueGame {
                    gameVM.scoreCount = 0
                    targetVM.elements.removeAll()
                    targetVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
                    displayLink.start()
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
