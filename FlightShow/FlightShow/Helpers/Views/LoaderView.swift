//
//  LoaderView.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var drawingStroke = false
    let animation = Animation
        .easeOut(duration: 2.1)
        .repeatForever(autoreverses: false)
        .delay(0.1)
    
    var body: some View {
        VStack {
          ring()
                .frame(width: 44, height: 44)
            Text("Loading")
                .customText(.interRegular, size: 17, color: .white.opacity(0.5))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("loaderBG")
                    .resizable()
                    .ignoresSafeArea()
            }.animation(animation, value: drawingStroke)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    drawingStroke.toggle()
                }
            }
    }
    
    func ring() -> some View {
        ZStack {
            Circle()
                .trim(from: 0, to: drawingStroke ? 1 : 0)
                .stroke(.pink,
                        style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .background {
                    Circle()
                        .stroke(Color(red: 0.3451, green: 0.851, blue: 0.9961).opacity(0.3), lineWidth: 5)
                }
        }
        .rotationEffect(.degrees(-90))
    }
}
