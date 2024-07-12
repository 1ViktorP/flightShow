//
//  TermsView.swift
//  IgniteTracker
//
//  Created by MacBook on 29.01.2024.
//

import SwiftUI

struct TermsScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator
    var isTerms: Bool

    var body: some View {
        ZStack {
            Color.mainBG.ignoresSafeArea()
            ScrollView {
                Text(isTerms ? TermsPolicy.terms : TermsPolicy.policy)
                    .customText(size: 17, color: .white.opacity(0.5))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 20)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton {
                coordinator.pop()
                }
            }
            ToolbarItem(placement: .principal) {
                Text(isTerms ? "Terms" : "Policy")
                    .customText(.interSemiBold, size: 17, color: .secondaryText)
            }
        }
    }
}
