//
//  SignUpController.swift
//  InstagramUIKit
//
//  Created by Maciej on 02/12/2023.
//

import UIKit

final class SignUpController: UIViewController {

    // MARK: - Properties
    weak var delegate: AuthDelegate?
    
    private lazy var backgroundGradient: CAGradientLayer = {
        return .gradient(in: view.bounds)
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            logoView,
            usernameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            signUpButton
        ])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var logoView: IGLogoView = {
        return .init()
    }()
    
    private lazy var usernameTextField: IGTextField = {
        return .init("Username")
    }()
    
    private lazy var emailTextField: IGTextField = {
        return .init("Email")
    }()
    
    private lazy var passwordTextField: IGTextField = {
        return .init("Password", isSecure: true)
    }()
    
    private lazy var confirmPasswordTextField: IGTextField = {
        return .init("Confirm Password", isSecure: true)
    }()
    
    private lazy var signUpButton: IGButton = {
        return .init("Next")
    }()
    
    private lazy var footerView: IGFooterView = {
        return .init(type: .signUp)
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupTargets()
    }
    
    // MARK: - Selectors
    @objc private func dismissSignUp() {
        dismiss(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isEnabled = !usernameTextField.isEmpty
        && !emailTextField.isEmpty
        && !passwordTextField.isEmpty
        && !confirmPasswordTextField.isEmpty
        
        signUpButton.isEnabled = isEnabled
    }
    
    @objc private func navigateToUploadPicture() {
        guard let name = usernameTextField.textField.text,
              let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text else { return }
        
        let controller = SignUpImageController(
            name: name,
            email: email,
            password: password
        )
        controller.delegate = delegate
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Private
private extension SignUpController {
    
    func setupUI() {
        view.layer.addSublayer(backgroundGradient)
        
        view.addSubview(mainStack)
        view.addSubview(footerView)
        
        overrideUserInterfaceStyle = .dark
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTargets() {
        usernameTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmPasswordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        signUpButton.button.addTarget(self, action: #selector(navigateToUploadPicture), for: .touchUpInside)
        
        footerView.button.addTarget(self, action: #selector(dismissSignUp), for: .touchUpInside)
    }
}

#Preview {
    UINavigationController(rootViewController: SignUpController())
}
