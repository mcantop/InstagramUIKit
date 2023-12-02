//
//  LoginController.swift
//  InstagramUIKit
//
//  Created by Maciej on 30/11/2023.
//

import UIKit

final class LoginController: UIViewController {
    
    // MARK: - Properties
    private lazy var backgroundGradient: CAGradientLayer = {
        return .gradient(in: view.bounds)
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            emailTextField,
            passwordTextField,
            loginButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var logoView: IGLogoView = {
        return .init()
    }()
    
    private lazy var emailTextField: IGTextField = {
        .init("Email")
    }()
    
    private lazy var passwordTextField: IGTextField = {
        .init("Password", isSecure: true)

    }()
    
    private lazy var loginButton: IGButton = {
        return .init("Log in")
    }()
    
    private lazy var footerView: IGFooterView = {
        .init(type: .login)
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupTargets()
    }
    
    // MARK: - Selectors
    @objc private func presentSignUp() {
        let signUpViewController = SignUpController()
        signUpViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(signUpViewController, animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        loginButton.isEnabled = !emailTextField.isEmpty && !passwordTextField.isEmpty
    }
    
    @objc private func handleLogin() {
        print("[DEBUG] Handle login..")
    }
}

// MARK: - Private
private extension LoginController {
    
    func setupUI() {
        view.layer.addSublayer(backgroundGradient)

        view.addSubview(stackView)
        view.addSubview(footerView)

        overrideUserInterfaceStyle = .dark
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func setupTargets() {
        emailTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        loginButton.button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        footerView.button.addTarget(self, action: #selector(presentSignUp), for: .touchUpInside)
    }
}

#Preview {
    UINavigationController(rootViewController: LoginController())
}
