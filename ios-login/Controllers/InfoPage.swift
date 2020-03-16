//
//  InfoPage.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/15/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class InfoPage: UIViewController {
        
    let profileImage = UIImageView(image: UIImage(named: "profileImage"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.darkBlue
        setupHomeLabel()
        setupBellImage()
        setupSettingsImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupWavesBackground()
        setupProfileImage()
        setupCurrentBalance()
    }
    
    private func setupWavesBackground() {
        let wavesView = UIImageView(image: UIImage(named: "waves"))
        view.addSubview(wavesView)
        wavesView.contentMode = .scaleAspectFill
        wavesView.tintColor = UIColor(white: 0.98, alpha: 1)
        wavesView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y+600, width: view.frame.size.width, height: view.frame.size.height)
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            wavesView.frame.origin.y = self.view.frame.origin.y+50
        })
    }
    
    private func setupHomeLabel() {
        let homeLabel = UILabel()
        view.addSubview(homeLabel)
        homeLabel.translatesAutoresizingMaskIntoConstraints = false
        homeLabel.text = "Home"
        homeLabel.textColor = .white
        homeLabel.font = UIFont(name: "Din Condensed", size: 22)
        NSLayoutConstraint.activate([
            homeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            homeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }
    
    private func setupBellImage() {
        let bell = UIImageView(image: UIImage(named: "bell"))
        view.addSubview(bell)
        bell.translatesAutoresizingMaskIntoConstraints = false
        bell.contentMode = .scaleAspectFill
        bell.tintColor = .white
        NSLayoutConstraint.activate([
            bell.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            bell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            bell.widthAnchor.constraint(equalToConstant: 22),
            bell.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func setupSettingsImage() {
        let settings = UIImageView(image: UIImage(named: "settings"))
        view.addSubview(settings)
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.contentMode = .scaleAspectFill
        settings.tintColor = .white
        NSLayoutConstraint.activate([
            settings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            settings.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            settings.widthAnchor.constraint(equalToConstant: 22),
            settings.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func setupProfileImage() {
        profileImage.contentMode = .scaleAspectFill
        view.addSubview(profileImage)
        profileImage.frame.size = CGSize(width: 120, height: 120)
        profileImage.center = CGPoint(x: view.center.x, y: view.frame.origin.y+180)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.profileImage.frame.origin.y = self.view.frame.origin.y+100
            self.profileImage.frame.size = CGSize(width: 70, height: 70)
            self.profileImage.center.x = self.view.center.x
            self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        })
        setupNameLabel()
    }
    
    private func setupNameLabel() {
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Richard Miller"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Din Condensed", size: 22)
        nameLabel.alpha = 0
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 4),
        ])
        UIView.animate(withDuration: 1.5) {
            nameLabel.alpha = 1
        }
    }
    
    private func setupCurrentBalance() {
        let balanceView = UIImageView(image: UIImage(named: "balanceImg"))
        var finalY = CGFloat()
        if view.frame.height > 1000 {
            balanceView.contentMode = .scaleAspectFill
            finalY = self.view.center.y - 150
        }else{
            finalY = self.view.center.y - 100
        }
        balanceView.layer.shadowRadius = 10
        balanceView.layer.shadowOpacity = 0.1
        view.addSubview(balanceView)
        balanceView.frame = CGRect(x: 8, y: view.frame.maxY + balanceView.frame.height, width: self.view.frame.width - 16, height: 100)
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            balanceView.frame.origin.y = finalY
        })
        setupMonthlyChange()
    }
    
    private func setupMonthlyChange() {
        let monthlyChange = UIImageView(image: UIImage(named: "monthlyChange"))
        var finalY = CGFloat()
        monthlyChange.layer.shadowRadius = 10
        monthlyChange.layer.shadowOpacity = 0.1
        view.addSubview(monthlyChange)
        monthlyChange.frame = CGRect(x: 8, y: view.frame.maxY + monthlyChange.frame.height*2, width: self.view.frame.width - 16, height: 100)
        if view.frame.height > 1000 {
            monthlyChange.contentMode = .scaleAspectFill
            finalY = view.center.y + monthlyChange.frame.height + 50
        }else{
            finalY = view.center.y + 25
        }
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            monthlyChange.frame.origin.y = finalY
        })
        setupManageAccount()
    }
    
    private func setupManageAccount() {
        let manageAccountView = UIImageView(image: UIImage(named: "manageAccount"))
        var finalY = CGFloat()
        manageAccountView.layer.shadowRadius = 10
        manageAccountView.layer.shadowOpacity = 0.1
        view.addSubview(manageAccountView)
        print(manageAccountView.frame.height)
        manageAccountView.frame = CGRect(x: 8, y: view.frame.maxY + manageAccountView.frame.height*3, width: self.view.frame.width - 16, height: 100)
        if view.frame.height > 1000 {
            manageAccountView.contentMode = .scaleAspectFill
            finalY = view.center.y + manageAccountView.frame.height + 350
        }else{
            finalY = view.center.y + 150
        }
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            manageAccountView.frame.origin.y = finalY
        })
    }
    
}
