//
//  BlobViews.swift
//  ios-login
//
//  Created by Vitaliy Paliy on 3/11/20.
//  Copyright © 2020 PALIY. All rights reserved.
//

import UIKit

class BlobViews: UIView {
    
    let blob1 = UIImageView(image: UIImage(named: "blob1"))
    let blob2 = UIImageView(image: UIImage(named: "blob2"))
    let blob3 = UIImageView(image: UIImage(named: "blob3"))
    
    var controllerView = UIView()
    
    init(for controller: LoginPage) {
        super.init(frame: .zero)
        self.controllerView = controller.view
        setupBlobViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlobViews() {
        controllerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: controllerView.topAnchor),
            bottomAnchor.constraint(equalTo: controllerView.centerYAnchor),
            leadingAnchor.constraint(equalTo: controllerView.leadingAnchor),
            trailingAnchor.constraint(equalTo: controllerView.trailingAnchor)
        ])
        
        addSubview(blob1)
        blob1.alpha = 0.2
        blob1.tintColor = .white
        
        addSubview(blob2)
        blob2.alpha = 0.2
        blob2.tintColor = .white
        
        addSubview(blob3)
        blob3.alpha = 0.2
        blob3.tintColor = .white
        
        setupViewFrames()
        
    }
    
    private func setupViewFrames() {
        if controllerView.frame.maxY < 1000 {
            blob1.frame = CGRect(x: 0, y: 0, width: 170, height: 200)
            blob2.frame = CGRect(x: -50, y: 250, width: 200, height: 250)
            blob3.frame = CGRect(x: 200, y: 170, width: 300, height: 250)
        }else{
            blob1.frame = CGRect(x: 0, y: 0, width: 170, height: 200)
            blob2.frame = CGRect(x: -50, y: 600, width: 200, height: 250)
            blob3.frame = CGRect(x: 800, y: 170, width: 300, height: 250)
        }
    }
    
    func handleSlideFrames() {
        if controllerView.frame.maxY < 1000 {
            blob1.frame.origin = CGPoint(x: -20, y: -40)
            blob2.frame.origin = CGPoint(x: -30, y: 200)
            blob3.frame.origin = CGPoint(x: 140, y: 70)
        }else{
            blob1.frame = CGRect(x: 230, y: 0, width: 170, height: 200)
            blob2.frame = CGRect(x: 25, y: 250, width: 200, height: 250)
            blob3.frame = CGRect(x: 650, y: 150, width: 300, height: 250)
        }
    }
    
    func changeBlobColors(alpha: CGFloat) {
        UIView.animate(withDuration: 0.6) {
            self.blob1.alpha = alpha
            self.blob2.alpha = alpha
            self.blob3.alpha = alpha
        }
    }
        
    
}
