//
//  IGFooterView.swift
//  InstagramUIKit
//
//  Created by Maciej on 02/12/2023.
//

import UIKit

private enum Constants {
    static let footerHeight = 70.0
}

enum IGFooterType {
    case login
    case signUp
    
    var defaultText: String {
        switch self {
        case .login:
            return "Don't have an account?"
        case .signUp:
            return "Already have an account?"
        }
    }
    
    var highlightedText: String {
        switch self {
        case .login:
            return "Sign Up."
        case .signUp:
            return "Log In."
        }
    }
}

final class IGFooterView: UIView {
    
    // MARK: - Properties
    private let type: IGFooterType
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryColor.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.15
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        let defaultText = type.defaultText
        let highlightedText = type.highlightedText
        let fullText = defaultText + " " + highlightedText
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let rangeToAttribute = (fullText as NSString).range(of: highlightedText)
        let textAttributes = [
            NSAttributedString.Key.font: UIFont.set(size: .subheadline, weight: .semibold)
        ]
        attributedText.addAttributes(textAttributes, range: rangeToAttribute)
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.tintColor = .primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    init(type: IGFooterType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension IGFooterView {
    
    func setupUI() {
        addSubview(divider)
//        addSubview(label)
        addSubview(blurEffectView)
        addSubview(button)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),

            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
//            button.topAnchor.constraint(equalTo: topAnchor),
//            button.leadingAnchor.constraint(equalTo: leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: trailingAnchor),
//            button.bottomAnchor.constraint(equalTo: bottomAnchor),

            heightAnchor.constraint(equalToConstant: Constants.footerHeight),
        ])
    }
}

#Preview {
    IGFooterView(type: .signUp)
}
