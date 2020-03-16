//
//  LoginPage.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class LoginPage: UIViewController, UITextFieldDelegate {
    
    var mainView: MainView!
    
    private var usernameTF: UsernameTF?
    
    private var passwordTF: PasswordTF?
    
    private var loginButton: LoginButton?
    
    private var signUpButton: SignUpButton?
    
    private var continueButton: ContinueButton?
    
    private var slideView: SlideView?
    
    private var gradientView = CAGradientLayer()
    
    private var blobViews: BlobViews?
    
    private var activityLines: ActivityLine?
    
    private var keyboardIsShown = false
        
    private var statusView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        notificationCenterHandler()
    }
    
    private func setupInitialUI() {
        blobViews = BlobViews(for: self)
        gradientView = setupGradientLayer()
        gradientView.frame = view.frame
        gradientView.locations = [0,0]
        view.layer.insertSublayer(gradientView, at: 0)
        mainView = MainView(for: self)
        slideView = SlideView(for: self)
        activityLines = ActivityLine(for: self)
    }
    
    private func setupInitialTFView() {
        usernameTF = UsernameTF(for: self)
        passwordTF = PasswordTF(for: self)
        continueButton = ContinueButton(for: self)
    }
    
    func handleSlideUp(with gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began , .changed:
            handleMovingState(for: gesture)
        case .ended:
            UIView.animate(withDuration: 0.3) {
                if self.view.safeAreaInsets.bottom*2 == 0 {
                    self.slideView!.center = CGPoint(x: self.slideView!.center.x, y: self.view.frame.maxY - 42)
                }else{
                    self.slideView!.center = CGPoint(x: self.slideView!.center.x, y: self.view.frame.maxY - self.view.safeAreaInsets.bottom*2 - 8)
                }
            }
        default:
            break
        }
    }
    
    private func handleMovingState(for gesture: UIPanGestureRecognizer) {
        guard let slideView = slideView else { return }
        let translation = gesture.translation(in: mainView)
        slideView.center = CGPoint(x: slideView.center.x, y: slideView.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: mainView)
        if slideView.frame.intersects(slideView.finishView.frame) {
            slideView.isHidden = true
            slideView.finishView.isHidden = true
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            handleUserDidSlide()
            gesture.isEnabled = false
        }
    }
    
    // MARK: USER DID SLIDE
    
    private func handleUserDidSlide() {
        UIView.animate(withDuration: 0.15) {
            self.curveMainView(by: 300)
            self.mainView.layer.cornerRadius = (self.view.frame.width+25)/2
        }
        UIView.animate(withDuration: 0.35, animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: -200)
            self.mainView.hideParticles()
            self.curveMainView(by: -300)
            self.mainView.layer.cornerRadius = (self.view.frame.width+300)/2
            self.blobViews?.handleSlideFrames()
        }) { (true) in
            self.activityLines?.setupCoordinates()
            self.activityLines?.handleLoginActivityLine()
            self.handleButtonsAnimation()
            self.mainView.setupLogoView()
            self.mainView.logoView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            UIView.animate(withDuration: 0.3) {
                self.mainView.logoView.transform = .identity
            }
            self.setupInitialTFView()
        }
    }
    
    private func curveMainView(by value: CGFloat) {
        self.mainView.center.x += value/2
        self.mainView.frame.size.width -= value
    }
    
    private func handleButtonsAnimation() {
        handleLoginButton()
        handleSignUpAnimation()
    }
    
    private func handleLoginButton() {
        loginButton = LoginButton(for: self)
        loginButton?.transform = CGAffineTransform(rotationAngle: (5 * .pi/3))
        loginButton?.center = CGPoint(x: -32, y: mainView.frame.minY + 50)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.loginButton?.alpha = 1
            self.loginButton?.transform = CGAffineTransform(rotationAngle: (11 * .pi)/5.8)
            self.loginButton?.center = CGPoint(x: self.mainView.center.x/2-30, y: self.mainView.frame.minY)
        })
    }
    
    private func handleSignUpAnimation() {
        signUpButton = SignUpButton(for: self)
        signUpButton?.center = CGPoint(x: mainView.center.x, y: mainView.frame.minY)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.signUpButton?.transform = CGAffineTransform(rotationAngle: (.pi)/8)
            self.signUpButton?.alpha = 0.3
            self.signUpButton?.center = CGPoint(x: self.mainView.center.x*1.5+32, y: self.mainView.frame.minY)
        })
    }
    
    // MARK: LOGIN BUTTON PRESSED
    @objc func loginButtonPressed() {
        guard loginButton?.alpha != 1 , let activityLines = activityLines else { return }
        activityLines.endSignUpActivityLine()
        handleTFFadeOut()
        let timer = Timer(timeInterval: 0.125, target: activityLines, selector: #selector(activityLines.handleLoginActivityLine), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .default)
        blobViews?.changeBlobColors(alpha: 0.2)
        UIView.animate(withDuration: 0.25, animations: {
            self.loginButton?.alpha = 1
            self.signUpButton?.alpha = 0.3
            self.mainView.logoView.tintColor = AppColors.darkBlue
        })
        animateGradientView(fromValue: [1,1], toValue: [0,0])
    }
    
    // MARK: SIGN UP BUTTON PRESSED
    @objc func signUpButtonPressed() {
        guard signUpButton?.alpha != 1, let activityLines = activityLines else { return }
        activityLines.endLoginActivityLine()
        handleTFFadeOut(isSignUp: true)
        let timer = Timer(timeInterval: 0.125, target: activityLines, selector: #selector(activityLines.handleSignUpActivityLine), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .default)
        blobViews?.changeBlobColors(alpha: 0.8)
        UIView.animate(withDuration: 0.25, animations: {
            self.signUpButton?.alpha = 1
            self.loginButton?.alpha = 0.3
            self.mainView.logoView.tintColor = AppColors.lightRed
        })
        animateGradientView(fromValue: [0,0], toValue: [1,1])
    }
    
    private func animateGradientView(fromValue: [CGFloat], toValue: [CGFloat]) {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.25
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        gradientView.add(animation, forKey: "changeColor")
    }
    
    private func handleTFFadeOut( isSignUp: Bool = false) {
        usernameTF?.fadeOut()
        passwordTF?.fadeOut()
        continueButton?.fadeOut()
        var timer = Timer()
        if isSignUp {
            timer = Timer(timeInterval: 0.3, target: self, selector: #selector(setupRegisterTF), userInfo: nil, repeats: false)
            RunLoop.current.add(timer, forMode: .default)
            return
        }
        timer = Timer(timeInterval: 0.3, target: self, selector: #selector(setupLoginTF), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .default)
    }
    
    @objc private func setupRegisterTF() {
        statusView = false
        usernameTF = UsernameTF(for: self, buttonPressed: true, animTime: 0.4)
        passwordTF = PasswordTF(for: self, isRegister: true, animTime: 0.4)
        continueButton = ContinueButton(for: self, isRegister: true, animTime: 0.4)
    }
    
    @objc private func setupLoginTF() {
        statusView = true
        usernameTF = UsernameTF(for: self, buttonPressed: true, animTime: 0.4)
        passwordTF = PasswordTF(for: self, animTime: 0.4)
        continueButton = ContinueButton(for: self, animTime: 0.4)
    }
    
    private func checkTF() -> String? {
        // setup your login logic here.
        if usernameTF?.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" && passwordTF?.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Make sure you fill in all fields."
        }
        guard statusView else { return nil }
        let password = passwordTF!.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if password.count < 6 {
            return "Password should be at least 6 characters long."
        }
        return nil
    }
    
    func goToNextController() {
        if let error = checkTF() {
            passwordTF?.errorLabel.text = error
            return
        }
        let controller = InfoPage()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: false, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = AppColors.darkBlue.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            textField.layer.borderWidth = 0
        }
    }
    
    // MARK: NOTIFICATION CENTER
    
    func notificationCenterHandler() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardOnTap()
    }
        
    @objc func handleKeyboardWillShow(notification: NSNotification){
        let kDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        guard let duration = kDuration else { return }
        if !keyboardIsShown {
            view.frame.origin.y -= 50
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
        keyboardIsShown = true
    }
    
    @objc func handleKeyboardWillHide(notification: NSNotification){
        let kDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        guard let duration = kDuration else { return }
        view.frame.origin.y = 0
        keyboardIsShown = false
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideKeyboardOnTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
        keyboardIsShown = false
    }
    
}

