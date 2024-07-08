//
//  Settings.swift
//  YourLucky
//
//  Created by MacBook on 07.07.2023.
//

import Foundation

struct Settings: Identifiable, Hashable {
    var id = UUID()
    let title: String
    let items: [SettingsItem]
    
    static var items: [Settings] {
        [Settings(title: "",
                  items: [SettingsItem(iconName: "profile", name: "User Profile", isSwither: false, type: .profile),
                          SettingsItem(iconName: "shop", name: "Store", isSwither: false, type: .shop)]),
         Settings(title: "",
                  items: [SettingsItem(iconName: "notification", name: "Notifications", isSwither: true, type: .notifications),
                          SettingsItem(iconName: "notification", name: "Vibration", isSwither: true, type: .vibration)]),
         Settings(title: "",
                  items: [ SettingsItem(iconName: "policy", name: "Privacy Policy", isSwither: false, type: .policy),
                    SettingsItem(iconName: "terms", name: "Terms of Service", isSwither: false, type: .terms)
                         ]),
         Settings(title: "",
                  items: [SettingsItem(iconName: "rateUs", name: "Rate Us", isSwither: false, type: .rateUs),
                    SettingsItem(iconName: "feedback", name: "Feedback", isSwither: false, type: .feedback)
                         ])
        ]
    }
}

struct SettingsItem: Identifiable, Hashable {
    var id = UUID()
    let iconName: String
    let name: String
    let isSwither: Bool
    let type: SettingType
}

enum SettingType {
    case profile
    case shop
    case notifications
    case vibration
    case policy
    case terms
    case rateUs
    case feedback
}
