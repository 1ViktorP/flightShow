//
//  ChampionshipScreen.swift
//  FlightShow
//
//  Created by MacBook on 10.07.2024.
//

import SwiftUI

struct ChampionshipScreen: View {
    @ObservedObject var gameVM: GameViewModel
    @StateObject var championshipVM = ChampionshipViewModel()
    @ObservedObject var displayLink: DisplayLink
    @State private var position: CGRect = .zero
    @State private var animation = Animation.linear
    var planePosition: CGPoint
    var body: some View {
        ZStack(alignment: .top) {
            ForEach( Array(zip(championshipVM.elements.indices, championshipVM.elements)), id: \.1.id) { (index, item) in
                Rectangle()
                    .fill(.clear)
                    .overlay {
                        Image(item.name)
                            .resizable()
                            .frame(width: GameChampionshipItem.size.width, height: GameChampionshipItem.size.height)
                    }
                    .frame(width: GameChampionshipItem.size.width, height: GameChampionshipItem.size.height)
                    .onChange(of: displayLink.updateValue) { _ in
                        if championshipVM.elements.count > index {
                            championshipVM.elements[index].offset += 3.2
                            championshipVM.checkCollision(elementPosition: CGPoint(x: championshipVM.elements[index].xPosition,
                                                                           y: championshipVM.elements[index].offset),
                                                  planePosition: planePosition) { isTouch in
                                if isTouch {
                                    gameVM.scoreCount += 1
                                    championshipVM.elements[index].isGoingToRemove = true
                                }
                            }
                            if championshipVM.elements[index].offset > 1000 {
                                displayLink.stop()
                                championshipVM.timer.upstream.connect().cancel()
                                gameVM.gameStatus = .lose
                            }
                            if  championshipVM.elements[index].isGoingToRemove {
                                championshipVM.elements.remove(at: index)
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
                    championshipVM.screenWidth = newValue.width
                }
        }.onReceive(championshipVM.timer) { _ in
            championshipVM.appendElements()
        }.onAppear {
            displayLink.start()
        }.onChange(of: gameVM.tryAgain) { _ in
            if  gameVM.tryAgain {
                gameVM.scoreCount = 0
                championshipVM.elements.removeAll()
                championshipVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
                displayLink.start()
                gameVM.tryAgain = false
            }
        }.onChange(of: gameVM.pause) { _ in
            if gameVM.pause {
                displayLink.stop()
                championshipVM.timer.upstream.connect().cancel()
            }
        }.onChange(of: gameVM.continueGame) { _ in
            if gameVM.continueGame {
                displayLink.start()
                championshipVM.timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
            }
        }
    }
}
