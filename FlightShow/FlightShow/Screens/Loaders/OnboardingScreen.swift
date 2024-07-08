//
//  OnboardingScreen.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

struct OnboardingScreen: View {
    var action: () -> Void
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Welcome, Pilot! ")
                    .customText(.interBold, size: 60)
                Text("Prepare for thrilling aerial adventures! Our game features four unique modes where you can step into the shoes of a pilot. Exciting journeys await you in...")
                    .customText(.interRegular, size: 17)
            }.padding(.leading, 16)
                .padding(.trailing, 32)
                .padding(.top, 55)
            Spacer()
            Button("Start") {
                
            }.buttonStyle(MainButton())
            .padding(.horizontal, 16)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("onbBG")
                    .resizable()
                    .ignoresSafeArea()
            }
    }
}

#Preview {
    OnboardingScreen {
        
    }
}
