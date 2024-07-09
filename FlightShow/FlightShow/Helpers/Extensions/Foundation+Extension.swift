//
//  Foundation+Extension.swift
//  FlightShow
//
//  Created by MacBook on 08.07.2024.
//

import Foundation
import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        if UserDefaults.standard.bool(forKey: "vibrations") == true {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }
}

extension CGRect {
    var minPoint: CGPoint {
        CGPoint(x: self.minX, y: self.minY)
    }
}
