//
//  MainScreen.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @EnvironmentObject var userManager: UserManager
    @Environment(\.scenePhase) var scenePhase
    @State var selectedIndex: Int = 0
    @State private var position: CGRect = .zero
    var body: some View {
        VStack {
            selectMode
                .padding(.bottom, 32)
                .padding(.horizontal, 16)
            ScrollViewReader { reader in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(Array(zip(GameMode.allCases.indices, GameMode.allCases)), id: \.0) { (index, item) in
                            TabItem(game: item)
                                .coordinateSpace(name: index)
                                .background {
                                     GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: ViewLocationPreferenceKey.self,
                                                    value: proxy.frame(in: CoordinateSpace.global).minPoint)
                                        .onPreferenceChange(ViewLocationPreferenceKey.self) { viewLocation in
                                            guard let x =  viewLocation?.x else { return }
                                            if 0...65 ~= x {
                                                selectedIndex = index
                                            }
                                        }
                                }
                                }
                        .padding(.trailing, 16)
                    }
                }.padding(.leading, 16)
                    .onAppear {
                        reader.scrollTo(selectedIndex, anchor: nil)
                    }
            }.scrollIndicators(.hidden)
                    .padding(.bottom, 36)
                .pagedScrollingTarget()
        }.enablePagedScrolling()
        CustomPageControl(totalIndex: GameMode.allCases.count, selectedIndex: selectedIndex)
        Spacer()
        Button("Play") {
            userManager.tickets -= GameMode.allCases[selectedIndex].paymentGame
            coordinator.push(.gameLoader(GameMode.allCases[selectedIndex]))
        }.buttonStyle(MainButton())
            .padding(.horizontal, 16)
            .padding(.bottom, 69)
    }.padding(.top, 44)
        .background {
            Color.mainBG.ignoresSafeArea()
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.mainBG, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    coordinator.push(.settings)
                }, label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.secondaryBG)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondaryText)
                        }
                })
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Spacer()
                    ImageTextView(text: String(userManager.userMoney))
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                ticketSubView
            }
        }.onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                userManager.updateUserData()
            }
        }
}

var selectMode: some View {
    HStack {
        Image("gamePad")
            .resizable()
            .frame(width: 24, height: 24)
        Text("Select Mode")
            .customText(.interSemiBold, size: 24, color: .secondaryText)
        Spacer()
    }
}

var ticketSubView: some View {
    ZStack {
        RoundedRectangle(cornerRadius: 10)
            .fill(.secondaryBG)
            .frame(width: 95, height: 36)
        HStack(spacing: 0) {
            Image("ticketStatus")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
            Text(String(userManager.tickets))
                .customText(.interBold, color: .secondaryText)
                .frame(width: 20)
                .offset(x: 10)
            Button(action: {
                coordinator.push(.shop)
            }, label: {
                Circle()
                    .fill(.shadow(.inner(color: Color(red: 0.9333, green: 0.4078, blue: 0), radius: 2, y: -2)))
                    .foregroundStyle( LinearGradient.yellowGradient)
                    .frame(width: 36, height: 36)
                    .overlay {
                        Image(systemName: "plus")
                            .font(.system(size: 10, weight: .black))
                            .foregroundStyle(.white)
                    }
            }).offset(x: 10)
        }.padding(.leading, 10)
    }
}
}

extension MainScreen {
    struct TabItem: View {
        var game: GameMode
        var body: some View {
            ZStack(alignment: .top) {
                Image(game.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 376)
                VStack {
                    Text(game.title)
                        .customText(.hamburgerHeaven, size: 34, color: .pink)
                        .shadow(color: .black.opacity(0.35), radius: 2.8, y: 2)
                    Text(game.subTitle)
                        .customText(.hamburgerHeaven, size: 34, color: .white)
                        .shadow(color: .black.opacity(0.35), radius: 2.8, y: 2)
                    Spacer()
                }.padding(.top, 20)
            }.frame(height: 376)
        }
    }
}

struct ViewLocationPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint?
    
    static func reduce(value: inout CGPoint?, nextValue: () -> CGPoint?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

#Preview {
    NavigationStack {
        MainScreen()
    }
}
