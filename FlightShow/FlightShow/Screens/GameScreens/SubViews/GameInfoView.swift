//
//  GameInfoView.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct GameInfoView: View {
    let gameMode: GameMode
    var target: String = ""
    var targetCount: Int = 0
    var action: () -> Void
    var body: some View {
        VStack(spacing: 0) {
            Text("Welcome Pilot")
                .customText(.interBold, size: 24)
                .padding(.bottom, 12)
            Text(gameMode.description)
                .customText(size: 17)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
           detailInfo
                .padding(.bottom, 24)
            Button("Start", action: {
                action()
            }).buttonStyle(MainButton())
        }.padding(.horizontal, 16)
            .padding(.top, 40)
            .padding(.bottom, 44)
        .background {
            RoundedRectangle(cornerRadius: 40)
                .fill(.mainBG)
        }.padding(16)
    }
    
    var detailInfo: some View {
        VStack {
            switch gameMode {
            case .tournament:
                statSubItem(text: "Entry: ", icon: "ticketStatus", value: "\(gameMode.paymentGame)")
            case .targetEvent:
                statSubItem(text: "Entry: ", icon: "ticketStatus", value: "\(gameMode.paymentGame)")
                statSubItem(text: "Target: ", icon: target, value: "\(targetCount)")
            case .championship:
                statSubItem(text: "Entry: ", icon: "ticketStatus", value: "\(gameMode.paymentGame)")
            case .training:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder func statSubItem(text: String, icon: String, value: String) -> some View {
        HStack {
            Text(text)
                .customText(size: 17, color: .white.opacity(0.5))
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            Text(value)
                .customText(.interBold, size: 17, color: .white)
        }
    }
}
