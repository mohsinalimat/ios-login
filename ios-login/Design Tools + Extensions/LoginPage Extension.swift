//
//  LoginPage Extension.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/10/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

extension LoginPage {
    
    func setupGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let topColor = AppColors.lightRed.cgColor
        let bottomColor = AppColors.darkBlue.cgColor
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [1, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }
    
}
