//
//  IGTextField.swift
//  InstagramUIKit
//
//  Created by Maciej on 01/12/2023.
//

import UIKit

private enum Constants {
    static let textFieldHeight = 50.0
    static let backgroundOpacity = 0.15
    static let cornerRadius = 4.0
}

final class IGTextField: UIView {
    
    // MARK: - Properties
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = placeholderText
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.primaryColor.withAlphaComponent(0.7)
            ]
        )
        textField.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.primaryColor,
            NSAttributedString.Key.font: UIFont.set(size: .headline, weight: .semibold)
        ]
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = isSecure
        textField.borderStyle = .none
        textField.tintColor = .primaryColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var isEmpty: Bool {
        return textField.text?.isEmpty == true
    }
    
    private let placeholderText: String
    private let isSecure: Bool
    
    // MARK: - Init
    init(_ placeholderText: String = "", isSecure: Bool = false) {
        self.placeholderText = placeholderText
        self.isSecure = isSecure
        
        super.init(frame: .zero)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension IGTextField {
    
    func setupUI() {
        addSubview(textField)

        backgroundColor = .primaryColor.withAlphaComponent(Constants.backgroundOpacity)
        layer.cornerRadius = Constants.cornerRadius        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
}

#Preview {
    IGTextField("Email", isSecure: false)
}
