//
//  GameScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct GameScreen: View {
    @StateObject var gameVM: GameViewModel
    @StateObject var displayLink = DisplayLink()
    @State private var hasInfoRead: Bool = false
    @State private var planePositon: CGPoint = .zero
    let gameMode: GameMode
    
    init(gameMode: GameMode) {
        self.gameMode = gameMode
        _gameVM = StateObject(wrappedValue: GameViewModel(currentMode: gameMode))
    }
    
    var body: some View {
        ZStack {
            Image("gameBG")
                .resizable()
                .ignoresSafeArea()
            if hasInfoRead {
                ZStack {
                    switch gameMode {
                    case .tournament:
                        TournamentScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .targetEvent:
                        TargetEventScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .championship:
                        ChampionshipScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .training:
                        TrainingModeScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    PlaneView(position: $planePositon)
                }
            } else {
                GameInfoView(gameMode: gameMode, target: gameVM.targetElement) {
                    hasInfoRead = true
                }
            }
            if gameVM.gameStatus != nil {
                StatusScreen(gameStatus: gameVM.gameStatus!) {
                    switch gameVM.gameStatus {
                    case .lose:
                        gameVM.tryAgain = true
                    default: break
                    }
                    gameVM.gameStatus = nil
                }
            }
        }
        .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.mainBG, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    displayLink.stop()
                  //  coordinator.pop()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                switch gameMode {
                case .tournament:
                    ImageTextView(text: gameVM.seconds.toTimeText())
                case .targetEvent:
                    targetItem
                case .championship:
                    ImageTextView(text: "\(gameVM.scoreCount)")
                case .training:
                    EmptyView()
                }
            }
        }
    }
    
    var targetItem: some View {
    
            HStack(spacing: -25) {
                Image(gameVM.targetElement)
                    .resizable()
                    .frame(width: 42, height: 42)
                    .zIndex(1)
                RoundedRectangle(cornerRadius: 10)
                    .fill(.secondaryBG)
                    .frame(width: 84, height: 36)
                    .overlay {
                        HStack(spacing: 0) {
                            Text("\(gameVM.scoreCount)")
                                .customText(.interBold, color: .white)
                            Text("/\(gameVM.targetCount)")
                                .customText(.interBold, color: .secondaryText)
                        }
                    }
            }
    }
}

#Preview {
    GameScreen(gameMode: .training)
}
