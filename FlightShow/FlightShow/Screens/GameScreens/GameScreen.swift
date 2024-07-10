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
                        EmptyView()
                    case .event:
                        EmptyView()
                    case .championship:
                        EmptyView()
                    case .training:
                        TrainingModeScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    PlaneView(position: $planePositon)
                }
            } else {
                GameInfoView(gameMode: gameMode) {
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
                    EmptyView()
                case .event:
                    EmptyView()
                case .championship:
                    EmptyView()
                case .training:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    GameScreen(gameMode: .training)
}
