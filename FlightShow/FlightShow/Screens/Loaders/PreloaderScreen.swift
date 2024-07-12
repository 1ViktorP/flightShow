//
//  PreloaderScreen.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

struct PreloaderScreen: View {
    var action: () -> Void
    @State private var showOnboarding: Bool = false
    
    var body: some View {
        ZStack {
            LoaderView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if  UserDefaults.standard.object(forKey: "openOnb") == nil {
                            UserDefaults.standard.set(true, forKey: "openOnb")
                            withAnimation {
                                showOnboarding = true
                            }
                        } else {
                            action()
                        }
                    }
                }
            if showOnboarding {
                OnboardingScreen {
                    action()
                }
            }
        }
    }
}
