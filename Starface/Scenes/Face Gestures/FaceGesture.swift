//
//  FaceGesture.swift
//  Emoji Bling
//
//  Created by Aleksander Lorenc on 29/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import Foundation

enum FaceGesture: CaseIterable {
    case openMouth
    case eyeBlinkLeft
    case eyeBlinkRight
    case cheekPuff
    case tongueOut
    case mouthFunnel
    case mouthFrown
    case eyesWide
    case mouthSmile
    case lookDown
    case lookUp

    var description: String {
        switch self {
        case .openMouth: return "Open mouth"
        case .eyeBlinkLeft: return "Blink left eye"
        case .eyeBlinkRight: return "Blink right eye"
        case .cheekPuff: return "Cheek puff"
        case .tongueOut: return "Tongue out"
        case .mouthFunnel: return "Mouth funnel"
        case .mouthFrown: return "Mouth frown"
        case .eyesWide: return "Eyes wide"
        case .mouthSmile: return "Smile"
        case .lookDown: return "Look down"
        case .lookUp: return "Look up"
        }
    }
}

class FaceGestureFactory {
    static func randomFaceGesture() -> FaceGesture {
        let allCases = FaceGesture.allCases
        return allCases.randomElement() ?? .openMouth
    }
}
