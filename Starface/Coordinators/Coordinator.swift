//
//  Coordinator.swift
//  CleanArchitecture
//
//  Created by Aleksander Lorenc on 08/07/2018.
//  Copyright © 2018 Unwrapped Software. All rights reserved.
//

import UIKit

class Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    weak var navigationController: UINavigationController?

    public func addChildCoordinator(_ coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }

    public func removeChildCoordinatorsOfType<T>(_ type: T.Type) {
        self.childCoordinators = self.childCoordinators.filter { $0 is T == false }
    }

    public func removeAllChildCoordinators() {
        self.childCoordinators.removeAll()
    }
}
