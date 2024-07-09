//
//  ProfileScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
            ScrollView {
                VStack(spacing: 16) {
                useTopView
                overallStat
                        .padding(.bottom, 8)
                modeStat
            }
                .padding(16)
        }.scrollIndicators(.hidden)
            .background {
            Color.mainBG.ignoresSafeArea()
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
    
    var useTopView: some View {
        VStack(spacing: 4) {
            Image("userIcon")
                .resizable()
                .frame(width: 80, height: 80)
            Text("User Name")
                .customText(.interSemiBold, size: 17)
            Text("ID: 398304")
                .customText(size: 14, color: .mainYellow)
        }
    }
    
    // MARK: overview stat
    var overallStat: some View {
        VStack {
            Text("Overall Stat")
                .customText(.interSemiBold, size: 24, color: .secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 16) {
               overviewItem(name: "Total Games", value: "1")
                overviewItem(name: "Wins/Losses", value: "1")
                overviewItem(name: "Win Percentage", value: "1")
                overviewItem(name: "Longest Game", value: "1")
            }.padding(.horizontal, 16)
                .padding(.vertical, 18)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.secondaryBG)
                }
        }
    }
    
    @ViewBuilder func overviewItem(isMode: Bool = false, name: String, value: String) -> some View {
        HStack {
            Text(name)
                .customText(size: 17, color: .white.opacity(0.5))
            if !isMode {
                Spacer()
            }
            Text(value)
                .customText(.interMedium, size: 17, color: isMode ? .mainYellow : .white)
        }
    }
    
    // MARK: Mode stat
    
    var modeStat: some View {
        VStack(spacing: 16) {
            Text("Mode Stat")
                .customText(.interSemiBold, size: 24, color: .secondaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(1...4, id: \.self) { _ in
                gameModeItem(gameModeStat: GameModeStat(name: "name", icon: "1", played: "11", winLose: "11"))
            }
        }
    }
    
    @ViewBuilder func gameModeItem(gameModeStat: GameModeStat) -> some View {
        HStack(spacing: 16) {
            Image(gameModeStat.icon)
                .resizable()
                .frame(width: 89, height: 89)
            VStack(alignment: .leading, spacing: 8) {
                Text(gameModeStat.name)
                    .customText(.interMedium, size: 17)
                overviewItem(name: "Games Played:", value: "11")
                overviewItem(name: "Wins/Losses: ", value: "11")
            }
            Spacer()
        }.padding(.horizontal, 16)
            .padding(.vertical, 22)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.secondaryBG)
            }
    }
    
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
