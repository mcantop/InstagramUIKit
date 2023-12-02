//
//  IGLogoView.swift
//  InstagramUIKit
//
//  Created by Maciej on 01/12/2023.
//

import UIKit

private enum Constants {
    static let headerHeight = 100.0
}

final class IGLogoView: UIImageView {
    
    // MARK: - Properties
    private let instagramLogo = UIImage.instagramLogo.withRenderingMode(.alwaysTemplate)
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension IGLogoView {
    
    func setupUI() {
        image = instagramLogo
        tintColor = .primaryColor
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }
}
