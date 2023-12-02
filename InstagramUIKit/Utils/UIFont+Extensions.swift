//
//  UIFont+Extensions.swift
//  InstagramUIKit
//
//  Created by Maciej on 01/12/2023.
//

import UIKit

extension UIFont {
    
    static func set(size: UIFont.TextStyle = .body, weight: UIFont.Weight = .regular) -> UIFont {
        return .systemFont(ofSize: UIFont.preferredFont(forTextStyle: size).pointSize, weight: weight)
    }
}
