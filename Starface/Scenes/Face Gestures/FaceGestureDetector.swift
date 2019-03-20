//
//  FaceGestureDetector.swift
//  Starface
//
//  Created by Aleksander Lorenc on 29/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import ARKit

class FaceGestureDetector {
    func isGesturePresent(_ faceGesture: FaceGesture, withAnchor anchor: ARFaceAnchor) -> Bool {
        switch faceGesture {
        case .eyeBlinkLeft:
            let value = anchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.2
            return value >= 0.5
        case .eyeBlinkRight:
            let value = anchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.2
            return value >= 0.5
        case .openMouth:
            let value = anchor.blendShapes[.jawOpen]?.floatValue ?? 0.2
            return value >= 0.5
        case .tongueOut:
            let value = anchor.blendShapes[.tongueOut]?.floatValue ?? 0.2
            return value >= 0.5
        case .cheekPuff:
            let value = anchor.blendShapes[.cheekPuff]?.floatValue ?? 0.2
            return value >= 0.3
        case .mouthFunnel:
            let value = anchor.blendShapes[.mouthFunnel]?.floatValue ?? 0.2
            return value >= 0.3
        case .mouthFrown:
            let mouthFrownLeftValue = anchor.blendShapes[.mouthFrownLeft]?.floatValue ?? 0.2
            let mouthFrownRightValue = anchor.blendShapes[.mouthFrownRight]?.floatValue ?? 0.2
            return mouthFrownLeftValue >= 0.5 || mouthFrownRightValue >= 0.5
        case .eyesWide:
            let eyeWideLeftValue = anchor.blendShapes[.eyeWideLeft]?.floatValue ?? 0.2
            let eyeWideRightValue = anchor.blendShapes[.eyeWideRight]?.floatValue ?? 0.2
            return eyeWideLeftValue >= 0.5 || eyeWideRightValue >= 0.5
        case .mouthSmile:
            let mouthSmileLeftValue = anchor.blendShapes[.mouthSmileLeft]?.floatValue ?? 0.2
            let mouthSmileRightValue = anchor.blendShapes[.mouthSmileRight]?.floatValue ?? 0.2
            return mouthSmileLeftValue >= 0.5 || mouthSmileRightValue >= 0.5
        case .lookDown:
            let eyeLookDownLeftValue = anchor.blendShapes[.eyeLookDownLeft]?.floatValue ?? 0.2
            let eyeLookDownRightValue = anchor.blendShapes[.eyeLookDownRight]?.floatValue ?? 0.2
            return eyeLookDownLeftValue >= 0.5 || eyeLookDownRightValue >= 0.5
        case .lookUp:
            let eyeLookUpLeftValue = anchor.blendShapes[.eyeLookUpLeft]?.floatValue ?? 0.2
            let eyeLookUpRightValue = anchor.blendShapes[.eyeLookUpRight]?.floatValue ?? 0.2
            return eyeLookUpLeftValue >= 0.5 || eyeLookUpRightValue >= 0.5
        }
    }
}
