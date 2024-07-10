//
//  PositionObserver.swift
//  LinkoBolls
//
//  Created by MacBook on 20.06.2024.
//

import SwiftUI

struct PositionObserver: View {
    @Binding var position: CGRect
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: PositionPreferenceKey.self, value: geometry.frame(in: .global))
        }
        .onPreferenceChange(PositionPreferenceKey.self) { value in
            DispatchQueue.main.async {
                self.position = value
            }
        }
    }
}

struct PositionPreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
