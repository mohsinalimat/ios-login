//
//  MainView.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/14/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var controllerView = UIView()
    let logoView = UIImageView()
    let particles = UIImageView(image: UIImage(named: "particles"))
    let textLogo = UILabel()
    
    init(for controller: LoginPage) {
        super.init(frame: .zero)
        self.controllerView = controller.view
        setupMainView()
        setupTextLogo()
        setupParticles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMainView() {
        controllerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = (controllerView.frame.width+300)/2
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: controllerView.centerXAnchor),
            topAnchor.constraint(equalTo: controllerView.centerYAnchor, constant: 32),
            widthAnchor.constraint(equalToConstant: controllerView.frame.width+300),
            heightAnchor.constraint(equalToConstant: controllerView.frame.height),
        ])
    }
    
    func setupLogoView() {
        controllerView.addSubview(logoView)
        logoView.backgroundColor = .white
        logoView.tintColor = AppColors.darkBlue
        logoView.image = UIImage(named: "logo")
        logoView.frame = CGRect(x: controllerView.center.x-50, y: frame.origin.y-50, width: 100, height: 100)
        logoView.contentMode = .scaleAspectFill
        logoView.layer.cornerRadius = 50
        logoView.layer.masksToBounds = true
    }
    
    private func setupTextLogo() {
        controllerView.addSubview(textLogo)
        textLogo.text = "WELCOME"
        textLogo.textAlignment = .center
        textLogo.textColor = .white
        textLogo.font = UIFont.boldSystemFont(ofSize: 30)
        textLogo.frame.size = CGSize(width: 500, height: 30)
        textLogo.center = CGPoint(x: controllerView.center.x, y: controllerView.center.y-30)
    }
    
    private func setupParticles() {
        controllerView.addSubview(particles)
        if controllerView.frame.height > 1000 {
            particles.contentMode = .scaleAspectFill
        }
        particles.frame.size = CGSize(width: controllerView.frame.width, height: 200)
        particles.center.y = textLogo.center.y-10
    }
    
    func hideParticles() {
        textLogo.transform = CGAffineTransform(translationX: 0, y: -120)
        textLogo.alpha = 0
        particles.alpha = 0
        particles.transform = CGAffineTransform(translationX: 0, y: -120)
    }
    
}
