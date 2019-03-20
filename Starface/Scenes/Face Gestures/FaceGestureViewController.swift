//
//  FaceGestureViewController.swift
//  Emoji Bling
//
//  Created by Aleksander Lorenc on 29/09/2018.
//  Copyright © 2018 Kelvin Lau. All rights reserved.
//

import ARKit
import UIKit

class FaceGestureViewController: UIViewController {
    private enum Const {
        static let labelAnimationDuration = 5.0
    }

    var pointsLabel: UILabel!
    var sceneView: ARSCNView!
    var checkView: UIView!

    private var timer: Timer!

    private var score = 0 {
        didSet {
            DispatchQueue.main.async {
                self.pointsLabel.text = "Points: \(self.score)"
            }
        }
    }

    private var faceGestures: [UILabel: FaceGesture] = [:]

    var viewModel: FaceGestureViewModelType!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARFaceTrackingConfiguration.isSupported else { fatalError() }

        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top

        self.sceneView = ARSCNView(frame: self.view.frame)

        self.view.addSubview(self.sceneView)

        let quitButton = UIButton()
        quitButton.setTitle("Quit", for: .normal)
        quitButton.setTitleColor(.white, for: .normal)
        quitButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(quitButton)

        quitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding ?? 0 + 16)
            make.trailing.equalToSuperview().inset(16)
        }

        quitButton.addTarget(self, action: #selector(self.quitTapped), for: .touchUpInside)

        self.pointsLabel = UILabel()
        self.pointsLabel.text = "Points: 0"
        self.pointsLabel.textColor = UIColor.white

        self.view.addSubview(self.pointsLabel)

        self.pointsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(topPadding ?? 0 + 16)
            make.left.equalToSuperview().offset(16)
        }

        self.checkView = UIView()
        self.checkView.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        self.view.addSubview(self.checkView)

        self.checkView.snp.makeConstraints { make in
            make.height.equalTo(128)
            make.leading.trailing.equalToSuperview()
            make.center.equalToSuperview()
        }

        self.configure()
    }

    private func configure() {
        self.sceneView.delegate = self
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.generateFaceGesture), userInfo: nil, repeats: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARFaceTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.sceneView.session.pause()
    }

    @objc func generateFaceGesture() {
        let faceGesture = FaceGestureFactory.randomFaceGesture()

        let label = self.label(forFaceGesture: faceGesture)
        self.addFaceGestureWithLabel(faceGesture: faceGesture, label: label)

        self.animateLabel(label)
    }

    private func animateLabel(_ label: UILabel) {
        UIView.animate(withDuration: Const.labelAnimationDuration, animations: {
            label.transform = CGAffineTransform(translationX: 0, y: self.sceneView.bounds.height)
        }, completion: { finished in
            if finished {
                label.removeFromSuperview()
                self.faceGestures.removeValue(forKey: label)
            }
        })
    }

    private func label(forFaceGesture faceGesture: FaceGesture) -> UILabel {
        let label = UILabel()

        label.text = faceGesture.description
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = UIColor.white
        label.textAlignment = .center

        return label
    }

    private func addFaceGestureWithLabel(faceGesture: FaceGesture, label: UILabel) {
        self.sceneView.addSubview(label)
        self.faceGestures[label] = faceGesture

        label.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: label,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: self.sceneView,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label,
                                                    attribute: NSLayoutConstraint.Attribute.top,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: self.sceneView,
                                                    attribute: NSLayoutConstraint.Attribute.top,
                                                    multiplier: 1,
                                                    constant: 50)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }

    private func detectFaceGestures(for node: SCNNode, using anchor: ARFaceAnchor) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            let labels = strongSelf.labelsInsideRect

            for label in labels {
                if let faceGesture = strongSelf.faceGestures[label] {
                    if strongSelf.isFaceGestureValid(faceGesture, forAnchor: anchor) {
                        strongSelf.score += 1
                        strongSelf.faceGestures.removeValue(forKey: label)
                    }
                }
            }
        }
    }

    private func isFaceGestureValid(_ faceGesture: FaceGesture, forAnchor anchor: ARFaceAnchor) -> Bool {
        let validator = FaceGestureDetector()
        return validator.isGesturePresent(faceGesture, withAnchor: anchor)
    }

    private var labelsInsideRect: [UILabel] {
        var labels: [UILabel] = []

        for label in self.faceGestures.keys {
            guard let labelRect = label.layer.presentation()?.frame else { continue }

            if labelRect.intersects(self.checkView.frame) {
                labels.append(label)
            }
        }

        return labels
    }

    @IBAction func quitTapped(_ sender: Any) {
        self.viewModel.quitButtonTapped()
    }
}

extension FaceGestureViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let device = sceneView.device else { return nil }
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        node.geometry?.firstMaterial?.transparency = 0.0

        self.detectFaceGestures(for: node, using: faceAnchor)
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry else { return }

        faceGeometry.update(from: faceAnchor.geometry)
        self.detectFaceGestures(for: node, using: faceAnchor)
    }
}
