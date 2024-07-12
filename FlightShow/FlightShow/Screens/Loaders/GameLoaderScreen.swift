//
//  GameLaoderScreen.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

struct GameLoaderScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var startPush: Bool = false
    var game: GameMode
    var body: some View {
        LoaderView()
            .onChange(of: startPush) { _ in
                coordinator.push(.game(game))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        startPush = true
                    }
            }.navigationBarBackButtonHidden(true)
    }
}
