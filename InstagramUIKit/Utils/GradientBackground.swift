//
//  GradientBackground.swift
//  InstagramUIKit
//
//  Created by Maciej on 01/12/2023.
//

import UIKit

extension CAGradientLayer {
    
    static func gradient(in bounds: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.darkPink.cgColor,
            UIColor.purpleRed.cgColor
        ]
        return gradientLayer
    }
}
