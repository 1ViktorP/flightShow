//
//  GameScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct GameScreen: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject var gameVM: GameViewModel
    @StateObject var displayLink = DisplayLink()
    @State private var hasInfoRead: Bool = false
    @State private var hasRuleRead: Bool = false
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
            if !hasInfoRead {
                GameInfoView(gameMode: gameMode, target: gameVM.targetElement, targetCount: gameVM.targetCount) {
                    hasInfoRead = true
                }
            }
            if hasRuleRead {
                ZStack {
                    switch gameMode {
                    case .tournament:
                        TournamentScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                    case .targetEvent:
                        TargetEventScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                    case .championship:
                        ChampionshipScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .training:
                        TrainingModeScreen(gameVM: gameVM, displayLink: displayLink, planePosition: planePositon)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    PlaneView(position: $planePositon)
                }
            } else if hasInfoRead {
               ruleWindow
                    .onTapGesture {
                        hasRuleRead = true
                    }
            }
            if gameVM.gameStatus != nil {
                StatusScreen(gameStatus: gameVM.gameStatus!, currentGame: gameVM.currentMode, reward: rewardCalculation) {
                    switch gameVM.gameStatus {
                    case .exit:
                        gameVM.continueGame = true
                        gameVM.pause = false
                        updateLevel()
                    case .lose:
                        gameVM.tryAgain = true
                        updateLevel()
                    default: break
                    }
                    gameVM.gameStatus = nil
                }.onAppear {
                    if gameVM.gameStatus == .win {
                        userManager.saveGameCountStat(game: gameVM.currentMode, isWin: true)
                        userManager.saveModeStat(game: gameVM.currentMode, isWin: true, seconds: gameVM.seconds)
                        reward()
                    } else if gameVM.gameStatus == .lose {
                        userManager.saveGameCountStat(game: gameVM.currentMode, isWin: false)
                        userManager.saveModeStat(game: gameVM.currentMode, isWin: false, seconds: gameVM.seconds)
                        reward()
                    } else if  gameVM.gameStatus == .exit {
                        gameVM.pause = true
                        gameVM.continueGame = false
                    }
                }
            }
        }.onAppear {
           updateLevel()
        }
        .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.mainBG, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                    gameVM.gameStatus = .exit
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
    
    var ruleWindow: some View {
        VStack {
           Spacer()
            Text("Tap left or right on the screen to move your plane in that direction.")
                .customText(color: .white.opacity(0.5))
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                Image("left")
                    .resizable()
                    .frame(width: 42, height: 65)
                PlaneView(position: $planePositon)
                Image("right")
                    .resizable()
                    .frame(width: 42, height: 65)
            }.frame(height: 120)
            .padding(.horizontal, 32)
        }.frame(maxHeight: .infinity)
            .contentShape(Rectangle())
        .padding(.horizontal, 32)
    }
    
    private func reward() {
        userManager.userMoney += rewardCalculation
    }
    
    var rewardCalculation: Int {
       return switch gameVM.currentMode {
        case .tournament:
            gameVM.seconds / 2
        case .targetEvent:
            if gameVM.scoreCount >= gameVM.targetCount {
                100
            } else {
                0
            }
        case .championship:
            gameVM.scoreCount
        case .training: 0
        }
    }
    
    private func updateLevel() {
        let level = userManager.fetchLevelMode(mode: gameMode)
        gameVM.speed = gameMode.updateSpeedForLevel(level: level)
        if gameVM.currentMode == .targetEvent {
            gameVM.targetCount = gameVM.currentMode.getTargetCount(level: level)
        }
    }
}

#Preview {
    GameScreen(gameMode: .training)
}
