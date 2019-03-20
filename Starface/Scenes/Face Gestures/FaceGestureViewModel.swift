//
//  FaceGestureViewModel.swift
//  Starface
//
//  Created by Aleksander Lorenc on 30/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import Foundation

protocol FaceGestureViewModelCoordinatorDelegate: class {
    func faceGestureQuitButtonTapped()
}

protocol FaceGestureViewModelType {
    func quitButtonTapped()
}

class FaceGestureViewModel: FaceGestureViewModelType {
    var coordinatorDelegate: FaceGestureViewModelCoordinatorDelegate?

    func quitButtonTapped() {
        self.coordinatorDelegate?.faceGestureQuitButtonTapped()
    }
}
