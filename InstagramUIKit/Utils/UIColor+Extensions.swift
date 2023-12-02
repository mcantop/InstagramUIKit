//
//  UIColor+Extensions.swift
//  InstagramUIKit
//
//  Created by Maciej on 01/12/2023.
//
//
import UIKit

extension UIColor {
    
    static var primaryColor: UIColor {
        return UIColor { $0.userInterfaceStyle == .light ? .black : .white }
    }
    
    static var backgroundColor: UIColor {
        return UIColor { $0.userInterfaceStyle == .light ? .white : .black }
    }
}
