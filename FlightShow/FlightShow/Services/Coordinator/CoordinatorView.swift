//
//  CoordinatorVie.swift
//  NewStrategy
//
//  Created by MacBook on 16.02.2024.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var coordinator: MainCoordinator
    @StateObject var userManager: UserManager
    @State var isMainLoaded: Bool = false
    
    init(saveManager: Saveable) {
        _coordinator = StateObject(wrappedValue: MainCoordinator(saveManager: saveManager))
        _userManager = StateObject(wrappedValue: UserManager(saveManager: saveManager))
    }
    
    var body: some View {
        ZStack {
            if !isMainLoaded {
                NavigationStack {
                    PreloaderScreen {
                        withAnimation {
                            isMainLoaded = true
                        }
                    }
                }
            } else {
                NavigationStack(path: $coordinator.navPath) {
                    coordinator.build( .main)
                        .navigationDestination(for: Page.self) { page in
                            coordinator.build(page)
                        }
                }
//                .environmentObject(userManager)
//                .environmentObject(coordinator)
            }
        }.environmentObject(userManager)
            .environmentObject(coordinator)
    }
}
