//
//  TournamentScreen.swift
//  FlightShow
//
//  Created by MacBook on 11.07.2024.
//

import SwiftUI

struct TournamentScreen: View {
    @ObservedObject var gameVM: GameViewModel
    @StateObject var tournamentVM = TournamentVIewModel()
    @ObservedObject var displayLink: DisplayLink
    @State private var position: CGRect = .zero
    @State private var animation = Animation.linear
    var planePosition: CGPoint
   
    var body: some View {
        ZStack(alignment: .top) {
            ForEach( Array(zip(tournamentVM.elements.indices, tournamentVM.elements)), id: \.1.id) { (index, item) in
                Rectangle()
                    .fill(.clear)
                    .overlay {
                        Image(item.name)
                            .resizable()
                            .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    }
                    .frame(width: GameTargetTournamentItem.size(name: item.name).width, height: GameTargetTournamentItem.size(name: item.name).height)
                    .onChange(of: displayLink.updateValue) { _ in
                        if tournamentVM.elements.count > index {
                            tournamentVM.elements[index].offset += gameVM.speed
                            tournamentVM.checkCollision(elementPosition: CGPoint(x: tournamentVM.elements[index].xPosition,
                                                                              y: tournamentVM.elements[index].offset),
                                                    elementName: item.name,
                                                    planePosition: planePosition) { isTouch in
                                
                                if isTouch {
                                    displayLink.stop()
                                    tournamentVM.timer.upstream.connect().cancel()
                                    gameVM.gameStatus = .lose
                                }
                            }
                            if tournamentVM.elements[index].offset > 1000 {
                                tournamentVM.elements.remove(at: index)
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
                    tournamentVM.screenWidth = newValue.width
                }
        }.onReceive(tournamentVM.timer) { _ in
            tournamentVM.appendElements()
            gameVM.seconds += 1
        }.onAppear {
            displayLink.start()
        }.onChange(of: gameVM.tryAgain) { _ in
            if  gameVM.tryAgain {
                gameVM.seconds = 0
                tournamentVM.elements.removeAll()
                tournamentVM.timer = Timer.publish(every: 1.5, on: .main, in: .default).autoconnect()
                displayLink.start()
                gameVM.tryAgain = false
            }
        }.onChange(of: gameVM.pause) { _ in
            if gameVM.pause {
                displayLink.stop()
                tournamentVM.timer.upstream.connect().cancel()
            }
        }.onChange(of: gameVM.continueGame) { _ in
            if gameVM.continueGame {
                displayLink.start()
                tournamentVM.timer = Timer.publish(every: 1.5, on: .main, in: .default).autoconnect()
            }
        }
    }
}
