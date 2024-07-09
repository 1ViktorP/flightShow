//
//  ShopScreen.swift
//  LinkoBolls
//
//  Created by MacBook on 18.06.2024.
//

import SwiftUI

struct ShopScreen: View {
    @State private var showBoughtAlert: Bool = false
    @State private var itemCount: Int = 0
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("Tickets")
                    .customText(.interSemiBold, size: 24, color: .secondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                    .padding(.bottom, 16)
                oneItems
                    .padding(.bottom, 24)
                Text("Special Items")
                    .customText(.interSemiBold, size: 24, color: .secondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 24)
                specialItems
                Spacer()
            }.padding(.top, 32)
                .padding(.leading, 16)
                .background {
                    Color.mainBG.ignoresSafeArea()
                }
            if showBoughtAlert {
                boughtAlert(itemCount: itemCount)
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                  //  coordinator.pop()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Shop")
                    .customText(.interSemiBold, size: 17, color: .secondaryText)
            }
            ToolbarItem(placement: .topBarTrailing) {
                ImageTextView(text: "100")
            }
        }
    }
    
    var oneItems: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(1...4, id: \.self) { item in
                    OneItem(item: Shop(tickets: 1, price: 100)) {
                        showBoughtAlert = true
                        itemCount = item
                    }
                }
            }
        }.scrollIndicators(.hidden)
    }
    
    var specialItems: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(1...4, id: \.self) { item in
                    SpecialItem(item: Shop(tickets: 1, price: 100)) {
                        showBoughtAlert = true
                        itemCount = item
                    }
                }
            }
        }.scrollIndicators(.hidden)
    }
    
    @ViewBuilder func boughtAlert(itemCount: Int) -> some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                Text("Done!")
                    .customText(.interBold, size: 24)
                    .padding(.bottom, 12)
                Text("You have successfully bought \(itemCount) tickets")
                    .customText(size: 17)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                    .padding(.horizontal, 50)
                Button("Go Home") {
                    
                }.buttonStyle(MainButton(isHamburger: false))
                    .padding(.horizontal, 32)
            }.padding(.vertical, 50)
                .background {
                    Color.mainBG.ignoresSafeArea()
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
                .padding(.horizontal, 16)
            Spacer()
        }
        .background {
            Color.mainBG.opacity(0.2).ignoresSafeArea()
            BackdropBlurView(radius: 7)
                .ignoresSafeArea()
        }
    }
}

extension ShopScreen {
        
    struct OneItem: View {
        let item: Shop
        var action: () -> Void
        var body: some View {
            VStack {
                Text("\(item.tickets) tickets")
                    .customText(size: 17, color: .mainYellow)
                Image("oneTicket")
                    .resizable()
                    .frame(width: 63, height: 71)
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("\(item.price)")
                        .customText(.interBold, size: 17)

                }
                    Button("Buy") {
                        action()
                    }.buttonStyle(MainButton(height: 39, isHamburger: false))
                        .frame(width: 122, height: 39)
            }.padding(.top, 14)
            .padding(.bottom, 18)
            .frame(width: 158)
            .background {
                Color.secondaryBG
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    struct SpecialItem: View {
        let item: Shop
        var action: () -> Void
        var body: some View {
            VStack {
                Text("\(item.tickets) tickets")
                    .customText(size: 17, color: .mainYellow)
                Image("multipleTickets")
                    .resizable()
                    .frame(width: 150, height: 116)
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text("\(item.price)")
                        .customText(.interBold, size: 17)
                }
                    Button("Buy") {
                        action()
                    }.buttonStyle(MainButton(height: 39, isHamburger: false))
                        .frame(width: 122, height: 39)
                
            }.padding(.vertical, 18)
            .frame(width: 218)
            .background {
                Color.secondaryBG
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        Image("maskItems")
                            .resizable()
                            .frame(width: 218)
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShopScreen()
    }
}
