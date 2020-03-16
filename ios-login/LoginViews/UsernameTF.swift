//
//  UsernameTF.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class UsernameTF: UITextField {
    
    var controller: LoginPage?
    
    var controllerView = UIView()
    
    let iconView = UIImageView(image: UIImage(named: "user"))
    
    var animationTime = Double()
    
    init(for controller: LoginPage, buttonPressed: Bool = false, animTime: Double = 0.7) {
        super.init(frame: .zero)
        self.controller = controller
        self.controllerView = controller.view
        self.animationTime = animTime
        setupTF()
        setupIconView()
        handleAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupTF() {
        controllerView.addSubview(self)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        borderStyle = .none
        attributedPlaceholder = NSAttributedString(string: "username".uppercased(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textColor = .gray
        font = UIFont.boldSystemFont(ofSize: 12)
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        layer.masksToBounds = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 44))
        leftView = paddingView
        leftViewMode = .always
        delegate = controller
        frame = CGRect(x: controllerView.center.x-134, y: controllerView.frame.maxY + 50, width: 300, height: 44)
        autocapitalizationType = .none
        autocorrectionType = .no
        textContentType = .oneTimeCode
    }
    
    private func setupIconView() {
        controllerView.addSubview(iconView)
        iconView.contentMode = .scaleAspectFill
        iconView.tintColor = .black
        iconView.alpha = 0.7
        iconView.frame = CGRect(x: frame.origin.x - 32, y: controllerView.frame.maxY + 50, width: 30, height: 30)
    }
        
    private func handleAnimation() {
        UIView.animate(withDuration: animationTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin.y = self.controllerView.center.y-70
            self.iconView.center.y = self.center.y
        })
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3) {
            self.setViewAlpha(0)
            self.transformViews(anim: CGAffineTransform(scaleX: 0.95, y: 0.95))
        }
    }
    
    private func setViewAlpha(_ status: CGFloat) {
        self.alpha = status
        self.iconView.alpha = status
    }
        
    private func transformViews(anim: CGAffineTransform) {
        transform = anim
        iconView.transform = anim
    }
    
}
