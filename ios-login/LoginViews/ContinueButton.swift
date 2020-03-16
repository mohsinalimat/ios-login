//
//  ContinueButton.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class ContinueButton: UIButton {
    
    var controller: LoginPage?
    
    var controllerView = UIView()
    
    var animationTime = Double()
    
    init(for controller: LoginPage, isRegister: Bool = false, animTime: Double = 0.7) {
        super.init(frame: .zero)
        self.controller = controller
        self.animationTime = animTime
        controllerView = controller.view
        setupLoginButton()
        backgroundColor = !isRegister ? AppColors.darkBlue : AppColors.lightRed
        initialAnim()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLoginButton() {
        controllerView.addSubview(self)
        layer.cornerRadius = 24
        layer.masksToBounds = true
        setImage(UIImage(systemName: "arrow.right"), for: .normal)
        imageView?.contentMode = .scaleAspectFill
        imageView?.tintColor = .white
        frame = CGRect(x: controllerView.frame.maxX-80, y: controllerView.frame.maxY*2, width: 48,height: 48)
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func initialAnim() {
        UIView.animate(withDuration: animationTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin.y = self.controllerView.frame.maxY-80
        })
    }
    
    @objc private func buttonPressed() {
        controller?.goToNextController()
    }
    

    func fadeOut() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
}

