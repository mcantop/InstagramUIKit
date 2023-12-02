//
//  IGButton.swift
//  InstagramUIKit
//
//  Created by Maciej on 02/12/2023.
//

import UIKit

private enum Constants {
    static let buttonHeight = 50.0
    static let cornerRadius = 4.0
    static let animationDuration = 0.2
}

final class IGButton: UIView {
    
    // MARK: - Properties
    var isEnabled: Bool {
        didSet {
            updateEnabledState()
        }
    }
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(text.capitalized, for: .normal)
        button.titleLabel?.font = .set(size: .headline, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = isEnabled
        return button
    }()
    
    private let text: String
    
    // MARK: - Init
    init(_ text: String, isEnabled: Bool = false) {
        self.text = text
        self.isEnabled = isEnabled
        
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
        updateEnabledState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension IGButton {
    
    func setupUI() {
        addSubview(button)
        
        layer.borderWidth = 1
        layer.cornerRadius = Constants.cornerRadius        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalTo: widthAnchor),
            
            heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    
    func updateEnabledState() {
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            guard let self else { return }
            
            button.isEnabled = isEnabled
            
            button.setTitleColor(.primaryColor.withAlphaComponent(
                isEnabled ? 1 : 0.35
            ), for: .normal)
            
            layer.borderColor = UIColor.white.withAlphaComponent(
                isEnabled ? 1 : 0.35
            ).cgColor
        }
    }
}

#Preview {
    IGButton("Log in")
}
