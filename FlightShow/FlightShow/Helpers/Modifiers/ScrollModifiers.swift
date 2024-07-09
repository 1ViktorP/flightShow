//
//  ScrollModifiers.swift
//  FlightShow
//
//  Created by MacBook on 09.07.2024.
//

import SwiftUI

struct EnablePagedScrolling: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .scrollTargetBehavior(.viewAligned)
        } else {
            content
                .onAppear {
                    UIScrollView.appearance().isPagingEnabled = true
                }
        }
    }
}

extension View {
    func enablePagedScrolling() -> some View {
        modifier(EnablePagedScrolling())
    }
}

struct PagedScrollingTarget: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .scrollTargetLayout()
        } else {
            content
        }
    }
}

extension View {
    func pagedScrollingTarget() -> some View {
        modifier(PagedScrollingTarget())
    }
}
