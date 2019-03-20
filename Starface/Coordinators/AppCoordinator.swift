//
//  AppCoordinator.swift
//  CleanArchitecture
//
//  Created by Aleksander Lorenc on 08/07/2018.
//  Copyright © 2018 Unwrapped Software. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let viewModel = WelcomeViewModel()
        let viewController = WelcomeViewController(viewModel: viewModel)

        viewModel.coordinatorDelegate = self

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        self.navigationController = navigationController

        self.window?.rootViewController = navigationController
    }
}

extension AppCoordinator: WelcomeViewModelCoordinatorDelegate {
    func welcomePlayButtonTapped() {
        let faceGestureViewController = FaceGestureViewController()

        let viewModel = FaceGestureViewModel()
        faceGestureViewController.viewModel = viewModel

        viewModel.coordinatorDelegate = self

        self.navigationController?.pushViewController(faceGestureViewController, animated: false)
    }
}

extension AppCoordinator: FaceGestureViewModelCoordinatorDelegate {
    func faceGestureQuitButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}
