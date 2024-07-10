//
//  FlightShowApp.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

@main
struct FlightShowApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameScreen(gameMode: .training)
            }
        }
    }
}
