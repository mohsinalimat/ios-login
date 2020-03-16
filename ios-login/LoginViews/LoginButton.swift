//
//  LoginButton.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/11/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class LoginButton: UIButton {
    
    var controller: LoginPage?
    var controllerView = UIView()
    
    init(for controller: LoginPage) {
        super.init(frame: .zero)
        self.controller = controller
        self.controllerView = controller.view
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        controllerView.addSubview(self)
        frame.size = CGSize(width: 250, height: 44)
        titleLabel?.font = UIFont(name: "Din Condensed", size: 25)
        tintColor = .white
        alpha = 0
        setTitle("LOGIN", for: .normal)
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed() {
        controller?.loginButtonPressed()
    }
    
}
