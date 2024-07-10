//
//  DisplayLink.swift
//  JungleAdventure
//
//  Created by MacBook on 01.07.2024.
//

import Foundation
import QuartzCore

class DisplayLink: NSObject, ObservableObject {
    
    private var displaylink: CADisplayLink?
    @Published var updateValue: TimeInterval = 0
    
    func start() {
            self.displaylink = CADisplayLink(target: self, selector: #selector(self.frame))
            self.displaylink?.add(to: .current, forMode: .common)
    }
    
    func stop() {
        displaylink?.invalidate()
    }
    
    @objc func frame(displaylink: CADisplayLink) {
        let frameDuration = 1 / displaylink.targetTimestamp - displaylink.timestamp
        updateValue = frameDuration
    }
}
