//
//  SettingsScreen.swift
//  PHLoan
//
//  Created by MacBook on 25.03.2024.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsScreen: View {
   // @EnvironmentObject var coordinator: Coordinator
    @State private var showMailAlert: Bool = false
    @State private var resultMail: Result<MFMailComposeResult, Error>?
    @State private var isShowingMailView = false
    
    private func isOnSwitch(settings: SettingsItem) -> Bool {
        if settings.type == .vibration {
            return  UserDefaults.standard.object(forKey: "vibration") as? Bool ?? false
        } else if settings.type == .notifications {
            return  UserDefaults.standard.object(forKey: "notifications") as? Bool ?? false
        }
        return false
    }
    
    var body: some View {
        ZStack {
            Color.mainBG.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center, spacing: 32) {
                    ForEach(Settings.items, id: \.self) { subItems in
                                Section {
                                    VStack(spacing: 24) {
                                    ForEach(subItems.items, id: \.id) { item in
                                        SettingsItemView(setting: item, isOn: isOnSwitch(settings: item) ) { isOn in
                                            switch item.type {
                                            case .notifications: notificationSwitchTapped(isOn: isOn)
                                            case .vibration: vibrationSwitchTapped(isOn: isOn)
                                            default: break
                                            }
                                        }
                                        .onTapGesture {
                                            switch item.type {
                                            case .shop: break//coordinator.push(.shop)
                                            case .feedback:
                                                if MFMailComposeViewController.canSendMail() {
                                                    self.isShowingMailView.toggle()
                                                } else {
                                                    self.showMailAlert = true
                                                }
                                            case .rateUs: ReviewHandler.requestReview()
                                            case .terms: break//coordinator.push(.terms(true))
                                            case .policy: break//coordinator.push(.terms(false))
                                            default: break
                                            }
                                        }
                                    }
                                    }.padding(16)
                                    .background {
                                        Color.secondaryBG
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                            }
                    }
                    Spacer()
                }.scrollContentBackground(.hidden)
                    .padding(.horizontal, 16)
            }.scrollIndicators(.hidden)
                .padding(.top, 36)
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: self.$isShowingMailView, result: self.$resultMail)
        }.alert(isPresented: $showMailAlert) {
            Alert(
                title: Text("Dear user"),
                message: Text("Unfortunately this function is not available at the moment. Please try again later and check the activity of your mail in the settings."),
                dismissButton: .default(Text("OK")))
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton {
                     //   coordinator.pop()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .customText(.interSemiBold, size: 17, color: .secondaryText)
                }
            }
    }
    
    func vibrationSwitchTapped(isOn: Bool) {
        if isOn {
            UserDefaults.standard.set(true, forKey: "vibration")
        } else {
            UserDefaults.standard.set(false, forKey: "vibration")
        }
    }
    
    func notificationSwitchTapped(isOn: Bool) {
        if isOn {
            UserDefaults.standard.set(true, forKey: "notifications")
            if let appSettings = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        } else {
            UserDefaults.standard.set(false, forKey: "notifications")
        }
    }
}

class ReviewHandler {
    
    static func requestReview() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}

#Preview {
    SettingsScreen()
}
