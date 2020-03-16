//
//  SlideView.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class SlideView: UIView {
    
    var controller: LoginPage?
    
    var controllerView = UIView()
    
    let finishView = UIView()
    
    init(for controller: LoginPage) {
        super.init(frame: .zero)
        self.controller = controller
        self.controllerView = controller.view
        setupFinishView()
        setupSlideView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSlideView() {
        controllerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView()
        setupTextLabel()
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: controllerView.centerXAnchor),
            bottomAnchor.constraint(equalTo: controllerView.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            widthAnchor.constraint(equalToConstant: 100),
            heightAnchor.constraint(equalToConstant: 70),
        ])
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        addGestureRecognizer(panGesture)
    }
    
    private func setupImageView() {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.up"))
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    private func setupTextLabel() {
        let textLabel = UILabel()
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "SWIPE UP"
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = .gray
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        controller?.handleSlideUp(with: gesture)
    }
    
    private func setupFinishView() {
        controllerView.addSubview(finishView)
        finishView.translatesAutoresizingMaskIntoConstraints = false
        finishView.backgroundColor = UIColor(white: 0.93, alpha: 1)
        finishView.layer.cornerRadius = 25
        finishView.layer.masksToBounds = true
        guard let mainView = controller?.mainView else { return }
        NSLayoutConstraint.activate([
            finishView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            finishView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            finishView.widthAnchor.constraint(equalToConstant: 50),
            finishView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
