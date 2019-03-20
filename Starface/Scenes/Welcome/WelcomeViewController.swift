//
//  WelcomeViewController.swift
//  Starface
//
//  Created by Aleksander Lorenc on 30/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    let viewModel: WelcomeViewModelType

    init(viewModel: WelcomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        self.buildView()
    }

    private func buildView() {
        let playButton = UIView()
        playButton.backgroundColor = UIColor.blue

        let playButtonLabel = UILabel()
        playButtonLabel.textColor = UIColor.white
        playButtonLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        playButtonLabel.text = "Play"
        playButtonLabel.textAlignment = .center
        playButtonLabel.layer.cornerRadius = 5.0

        playButton.addSubview(playButtonLabel)

        playButtonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let playButtonGesture = UITapGestureRecognizer(target: self, action: #selector(self.playButtonTapped))
        playButtonGesture.numberOfTapsRequired = 1

        playButton.addGestureRecognizer(playButtonGesture)

        self.view.addSubview(playButton)

        playButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }

    @objc private func playButtonTapped(_ sender: Any) {
        self.viewModel.playButtonTapped()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
