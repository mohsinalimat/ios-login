//
//  PasswordTF.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class PasswordTF: UITextField {
    
    var controller: LoginPage?
    var controllerView = UIView()
    let errorLabel = UILabel()
    let forgotPasswordButton = UIButton(type: .system)
    let confirmPassword = UITextField()
    let confirmIconView = UIImageView(image: UIImage(named: "lock"))
    let passwordIconView = UIImageView(image: UIImage(named: "lock"))
    
    var animationTime = Double()
    
    init(for controller: LoginPage, isRegister: Bool = false, animTime: Double = 0.7) {
        super.init(frame: .zero)
        self.controller = controller
        self.controllerView = controller.view
        self.animationTime = animTime
        setupPasswordTF()
        setupIconView()
        if !isRegister {
            setupForgotPasswordButton()
        }else{
            setupConfirmPasswordTF()
            setupConfirmIconView()
        }
        setupErrorLabel(isRegister)
        handleAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPasswordTF() {
        controllerView.addSubview(self)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        borderStyle = .none
        attributedPlaceholder = NSAttributedString(string: "password".uppercased(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textColor = .gray
        placeholder = "password".uppercased()
        setupTF(self)
    }
    
    private func setupIconView() {
        controllerView.addSubview(passwordIconView)
        passwordIconView.contentMode = .scaleAspectFill
        passwordIconView.tintColor = .black
        passwordIconView.alpha = 0.7
    }
    
    private func setupConfirmIconView() {
        controllerView.addSubview(confirmIconView)
        confirmIconView.contentMode = .scaleAspectFill
        confirmIconView.tintColor = .black
        confirmIconView.alpha = 0.7
    }
    
    private func setupErrorLabel(_ isRegistered: Bool) {
        controllerView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .red
        errorLabel.font = UIFont.boldSystemFont(ofSize: 12)
        errorLabel.centerXAnchor.constraint(equalTo: controllerView.centerXAnchor).isActive = true
        if isRegistered {
            errorLabel.topAnchor.constraint(equalTo: confirmPassword.bottomAnchor, constant: 8).isActive = true
        }else{
            errorLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8).isActive = true
        }
    }
    
    private func setupForgotPasswordButton() {
        controllerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.tintColor = AppColors.darkBlue
        forgotPasswordButton.setTitle("Forgot password?".uppercased(), for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        forgotPasswordButton.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
    }
    
    private func setupConfirmPasswordTF() {
        controllerView.addSubview(confirmPassword)
        confirmPassword.backgroundColor = UIColor(white: 0.95, alpha: 1)
        confirmPassword.borderStyle = .none
        confirmPassword.attributedPlaceholder = NSAttributedString(string: "password".uppercased(), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        confirmPassword.textColor = .gray
        confirmPassword.placeholder = "confirm password".uppercased()
        setupTF(confirmPassword)
    }
    
    private func setupTF(_ textfield: UITextField) {
        textfield.font = UIFont.boldSystemFont(ofSize: 12)
        textfield.layer.cornerRadius = 25
        textfield.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        textfield.layer.masksToBounds = true
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 44))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.delegate = controller
        textfield.autocapitalizationType = .none
        textfield.autocorrectionType = .no
        textfield.textContentType = .oneTimeCode
        textfield.isSecureTextEntry = true 
    }
    
    private func handleAnimation() {
        initialViewFrame()
        UIView.animate(withDuration: animationTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.finalViewFrame()
        })
    }
            
    private func initialViewFrame() {
        frame = CGRect(x: controllerView.center.x-134, y: controllerView.frame.maxY + 94, width: 300, height: 44)
        passwordIconView.frame = CGRect(x: frame.origin.x - 32, y: controllerView.frame.maxY + 94, width: 30, height: 30)
        forgotPasswordButton.frame = CGRect(x: frame.maxX - 140, y: controllerView.frame.maxY + 100, width: 150, height: 30)
        confirmPassword.frame = CGRect(x: controllerView.center.x-134, y: frame.maxY + 65, width: 300, height: 44)
        confirmIconView.frame = CGRect(x: confirmPassword.frame.origin.x - 32, y: frame.maxY + 65, width: 30, height: 30)
    }
    
    private func finalViewFrame() {
        frame.origin.y = controllerView.center.y - 15
        passwordIconView.center.y = center.y
        forgotPasswordButton.frame.origin.y = controllerView.center.y + 35
        confirmPassword.frame.origin.y = controllerView.center.y + 40
        confirmIconView.center.y = confirmPassword.center.y
    }
    
    private func setViewAlpha(_ status: CGFloat) {
        self.passwordIconView.alpha = status
        self.alpha = status
        self.forgotPasswordButton.alpha = status
        self.confirmIconView.alpha = status
        self.confirmPassword.alpha = status
        self.errorLabel.alpha = 0
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 0.3) {
            self.setViewAlpha(0)
            self.transformViews(anim: CGAffineTransform(scaleX: 0.95, y: 0.95))
        }
    }
    
    private func transformViews(anim: CGAffineTransform) {
        passwordIconView.transform = anim
        transform = anim
        forgotPasswordButton.transform = anim
        confirmIconView.transform = anim
        confirmPassword.transform = anim
        errorLabel.transform = anim
    }
 
    @objc func forgotButtonPressed() {
        print("TODO")
    }
 

}
