//
//  WelcomeViewModel.swift
//  Starface
//
//  Created by Aleksander Lorenc on 30/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import Foundation

protocol WelcomeViewModelCoordinatorDelegate: class {
    func welcomePlayButtonTapped()
}

protocol WelcomeViewModelType {
    func playButtonTapped()
}

class WelcomeViewModel: WelcomeViewModelType {
    var coordinatorDelegate: WelcomeViewModelCoordinatorDelegate?

    func playButtonTapped() {
        self.coordinatorDelegate?.welcomePlayButtonTapped()
    }
}
