//
//  SignUpImageController.swift
//  InstagramUIKit
//
//  Created by Maciej on 02/12/2023.
//

import UIKit

final class SignUpImageController: UIViewController {
    
    // MARK: - Properties
    private let name: String
    private let email: String
    private let password: String
    private var selectedImage: UIImage?
    
    private lazy var backgroundGradient: CAGradientLayer = {
        return .gradient(in: view.bounds)
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            logoView,
            uploadButtonWrapper,
            photoInfoLabel,
            signUpInfoLabel,
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
    
    private lazy var uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleUploadPicture), for: .touchUpInside)
        button.setBackgroundImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var uploadButtonWrapper: UIView = {
        let view = UIView()
        view.addSubview(uploadButton)
        
        NSLayoutConstraint.activate([
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.heightAnchor.constraint(equalToConstant: 100),
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            
            view.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return view
    }()
    
    private lazy var photoInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Upload your profile picture here.\nYou can change it or delete it at any moment."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .set(size: .headline, weight: .medium)
        label.alpha = 0.77
        return label
    }()
    
    private lazy var signUpInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "When you are done setting up your account, press the button below to create it."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .set(size: .subheadline, weight: .light)
        label.alpha = 0.77
        return label
    }()
    
    private lazy var signUpButton: IGButton = {
        return .init("Sign up", isEnabled: true)
    }()
    
    // MARK: - Init
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        setupConstraints()
        setupNavigationBar()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func dismissUploadPicture() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleUploadPicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
    
    @objc private func handleSignUp() {
        Task {
            await AuthService.signUp(email: email, password: password, name: name, profileImage: selectedImage)
        }
    }
}

// MARK: - Private
private extension SignUpImageController {
    
    func setupUI() {
        view.layer.addSublayer(backgroundGradient)
        
        view.addSubview(mainStack)
        
        overrideUserInterfaceStyle = .dark
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        
        let backArrow = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(dismissUploadPicture)
        )
        
        navigationItem.setLeftBarButton(backArrow, animated: true)
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    func setupTargets() {
        signUpButton.button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
}

// MARK: - Protocols for UIImagePicker
extension SignUpImageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        self.selectedImage = profileImage
        
        uploadButton.layer.cornerRadius = uploadButton.frame.width / 2
        uploadButton.layer.masksToBounds = true
        uploadButton.layer.borderWidth = 2
        uploadButton.layer.borderColor = UIColor.white.cgColor
        uploadButton.setBackgroundImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        uploadButtonWrapper.layer.shadowColor = UIColor.black.cgColor
        uploadButtonWrapper.layer.shadowOpacity = 0.5
        uploadButtonWrapper.layer.shadowOffset = .zero
        uploadButtonWrapper.layer.shadowRadius = 5
                
        dismiss(animated: true)
    }
}

#Preview {
    SignUpImageController(name: "mcantop", email: "mcantop@gmail.com", password: "123456")
}
