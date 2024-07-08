//
//  SettingsItemView.swift
//  IgniteTracker
//
//  Created by MacBook on 29.01.2024.
//

import SwiftUI

struct SettingsItemView: View {
    var setting: SettingsItem
    @State var isOn: Bool = false
    var switchHandler: ((Bool) -> Void) = { _ in }
    var body: some View {
                HStack {
                    Image(setting.iconName)
                        .frame(width: 24, height: 24)
                    Text(setting.name)
                        .customText(.interRegular, size: 17)
                    Spacer()
                    if setting.isSwither {
                        ZStack {
                            CustomToggle(isOn: $isOn)
                            Rectangle()
                                .fill(Color.black.opacity(0.0001))
                                .frame(width: 51)
                                .simultaneousGesture(TapGesture().onEnded({
                                    isOn.toggle()
                                    switchHandler(isOn)
                                }))
                        }
                    } else {
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                            .foregroundStyle(.secondaryText)
                    }
                }
            .contentShape(Rectangle())
    }
}


struct CustomToggle: UIViewRepresentable {
    
   @Binding var isOn: Bool
    
    func makeUIView(context: Context) -> UISwitch {
         UISwitch()
    }
    
    func updateUIView(_ uiView: UISwitch, context: Context) {
        uiView.onTintColor = UIColor(Color.mainYellow)
        uiView.backgroundColor = UIColor(red: 0.4784, green: 0.4784, blue: 0.4784, alpha: 1)
        uiView.layer.cornerRadius = 16
        uiView.isOn = isOn
    }
}
