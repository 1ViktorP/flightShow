//
//  StatusScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct StatusScreen: View {
   
    let gameStatus: Status
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                Image(gameStatus.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: gameStatus.iconFrame.width, height: gameStatus.iconFrame.height)
                    .offset(y: gameStatus == .lose ? -76 : -44)
                    .padding(.bottom, gameStatus == .lose ? -76 : 0)
                Text(gameStatus.title)
                    .customText(.interBold, size: 24)
                    .padding(.bottom, 12)
                Text(gameStatus.description)
                    .customText(size: 17)
                    .padding(.bottom, 20)
                if gameStatus == .win {
                    statItem
                } else {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 36)
                }
                buttons
                    .padding(.bottom, 36)
            }.background {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.mainBG)
            }.padding(16)
            Spacer()
        }.background {
            Color.mainBG.opacity(0.2).ignoresSafeArea()
            BackdropBlurView(radius: 7)
                .ignoresSafeArea()
        }
    }
    
    var buttons: some View {
        VStack {
            switch gameStatus {
            case .win:
                Button("Continue") {
                    
                }.buttonStyle(MainButton(isHamburger: false))
                Button("Go Home") {
                    
                }.buttonStyle(MainButton(isHamburger: false, isClear: true))
            case .lose:
                Button("Try Again") {
                    
                }.buttonStyle(MainButton(isHamburger: false))
                Button("Go Home") {
                    
                }.buttonStyle(MainButton(isHamburger: false, isClear: true))
            case .exit:
                Button("Go Home") {
                    
                }.buttonStyle(MainButton(isHamburger: false))
                Button("Continue") {
                    
                }.buttonStyle(MainButton(isHamburger: false, isClear: true))
            }
            
        }.padding(.horizontal, 32)
    }
    
    var statItem: some View {
        HStack {
            Text("Reward:")
                .customText(size: 17)
            statSubItem(icon: "coin", value: "11")
            statSubItem(icon: "ticketStatus", value: "11")
        }.padding(.bottom, 36)
    }
    
    @ViewBuilder func statSubItem(icon: String, value: String) -> some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
            Text(value)
                .customText(.interBold, size: 17, color: .white)
        }
    }
}

#Preview {
    StatusScreen(gameStatus: .lose)
}