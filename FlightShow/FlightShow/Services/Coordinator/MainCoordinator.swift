//
//  Coordinator.swift
//  NewStrategy
//
//  Created by MacBook on 14.02.2024.
//

import SwiftUI

enum Page: Identifiable, Hashable {
    
    case main
    case gameLoader(GameMode)
    case game(GameMode)
    case profile
    case shop
    case settings
    case terms(Bool)
    
    var id: UUID {
        return UUID()
    }
    
    static func == (lhs: Page, rhs: Page) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
}

final class MainCoordinator: ObservableObject {
    @Published var navPath = NavigationPath()
    
    private var saveManager: Saveable
    
    init(saveManager: Saveable) {
        self.saveManager = saveManager
    }
    
    func push(_ page: Page) {
        navPath.append(page)
    }
    
    func pop() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    @ViewBuilder func build(_ page: Page) -> some View {
        switch page {
        case .main:
            MainScreen()
        case .gameLoader(let game):
           GameLoaderScreen(game: game)
        case .game(let game):
            GameScreen(gameMode: game)
        case .profile:
            ProfileScreen(saveManager: saveManager)
        case .settings:
            let _ = print("open sett")
            SettingsScreen()
        case .shop:
            ShopScreen()
        case .terms(let isTerms):
            TermsScreen(isTerms: isTerms)
        }
    }
}
