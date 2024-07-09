//
//  GameScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct GameScreen: View {
    let gameMode: GameMode
    @State private var hasInfoRead: Bool = false
    var body: some View {
        ZStack {
            Image("gameBG")
                .ignoresSafeArea()
            if hasInfoRead {
                switch gameMode {
                case .tournament:
                    EmptyView()
                case .event:
                    EmptyView()
                case .championship:
                    EmptyView()
                case .training:
                    TrainingModeScreen()
                }
            } else {
                GameInfoView(gameMode: gameMode) {
                    hasInfoRead = true
                }
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.mainBG, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                  //  coordinator.pop()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("My Profile")
                    .customText(.interSemiBold, size: 17, color: .secondaryText)
            }
            ToolbarItem(placement: .topBarTrailing) {
                ImageTextView(text: "100")
            }
        }
    }
}

#Preview {
    GameScreen()
}
