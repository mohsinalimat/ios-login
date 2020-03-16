//
//  ActivityLine.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/13/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class ActivityLine: CAShapeLayer {
    
    private var controller: LoginPage?
    private var mainView = UIView()
    private var controllerView = UIView()
    private var yCoordinate = CGFloat()
    private var xCoordinateLogin = CGFloat()
    private var xCoordinateSignUp = CGFloat()
    
    private let loginSecondaryLine = CAShapeLayer()
    private let signUpSecondaryLine = CAShapeLayer()
    
    init(for controller: LoginPage) {
        super.init()
        self.controller = controller
        self.mainView = controller.mainView
        self.controllerView = controller.view
        for layer in [loginSecondaryLine, signUpSecondaryLine] {
            setupSecondaryLine(layer)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    @objc func handleLoginActivityLine() {
        let loginActivityLine = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: mainView.center.x, y: mainView.frame.minY))
        path.addQuadCurve(to: CGPoint(x: -2, y: yCoordinate), controlPoint: CGPoint(x: xCoordinateLogin, y: mainView.frame.minY))
        loginActivityLine.fillColor = UIColor.clear.cgColor
        loginActivityLine.strokeColor = AppColors.lightRed.cgColor
        loginActivityLine.lineWidth = 6
        loginActivityLine.path = path.cgPath
        controllerView.layer.insertSublayer(loginActivityLine, below: controller?.mainView.logoView.layer)
        loginActivityLine.add(setupAnimation(), forKey: "move")
    }
    
    @objc func handleSignUpActivityLine() {
        let signUpActivityLine = CAShapeLayer()
        let path = UIBezierPath()
        xCoordinateSignUp = controllerView.frame.height < 1000 ? mainView.center.x*1.5 : mainView.center.x*1.5 + 40
        path.move(to: CGPoint(x: mainView.center.x, y: mainView.frame.minY))
        path.addQuadCurve(to: CGPoint(x: controllerView.frame.maxX+2, y: yCoordinate), controlPoint: CGPoint(x: xCoordinateSignUp, y: mainView.frame.minY))
        signUpActivityLine.fillColor = UIColor.clear.cgColor
        signUpActivityLine.strokeColor = AppColors.darkBlue.cgColor
        signUpActivityLine.lineWidth = 6
        signUpActivityLine.path = path.cgPath
        controllerView.layer.insertSublayer(signUpActivityLine, below: controller?.mainView.logoView.layer)
        signUpActivityLine.add(setupAnimation(), forKey: "move")
    }
    
    func endLoginActivityLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -2, y: yCoordinate))
        path.addQuadCurve(to: CGPoint(x: mainView.center.x, y: mainView.frame.minY), controlPoint: CGPoint(x: xCoordinateLogin, y: mainView.frame.minY))
        loginSecondaryLine.path = path.cgPath
        controllerView.layer.insertSublayer(loginSecondaryLine, below: controller?.mainView.logoView.layer)
        loginSecondaryLine.add(setupAnimation(), forKey: "move")
    }
    
    func endSignUpActivityLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: controllerView.frame.maxX+2, y: yCoordinate))
        path.addQuadCurve(to: CGPoint(x: mainView.center.x, y: mainView.frame.minY), controlPoint: CGPoint(x: xCoordinateSignUp, y: mainView.frame.minY))
        signUpSecondaryLine.path = path.cgPath
        controllerView.layer.insertSublayer(signUpSecondaryLine, below: controller?.mainView.logoView.layer)
        signUpSecondaryLine.add(setupAnimation(), forKey: "move")
    }
    
    func setupCoordinates() {
        var x: CGFloat = calculateHeight() < 25 ? -85 : -25
        let height = controllerView.frame.height
        if height == 896 { x = -5 }
        xCoordinateLogin = height < 1000 ? mainView.center.x/2 : mainView.center.x/2 - 40
        yCoordinate = (mainView.frame.minY + x + controllerView.frame.width)/2
    }
    
    private func setupSecondaryLine(_ layer: CAShapeLayer) {
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 6.5
    }
    
    private func setupAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.125
        return animation
    }
        
    private func calculateHeight() -> CGFloat {
        var topSafeAreaHeight: CGFloat = 0
        var bottomSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }
        return topSafeAreaHeight + bottomSafeAreaHeight
    }
    
}
