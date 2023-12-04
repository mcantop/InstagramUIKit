//
//  UIViewController+Extensions.swift
//  InstagramUIKit
//
//  Created by Maciej on 04/12/2023.
//

import UIKit

extension UIViewController {
    
    func presentLoginController(authDelegate: AuthDelegate?) {
        let loginController = LoginController()
        loginController.delegate = authDelegate
        
        let navigationController = UINavigationController(rootViewController: loginController)
        navigationController.modalPresentationStyle = .fullScreen
        // Has to be called on the main queue, otherwise it might not work
        DispatchQueue.main.async {
            self.present(navigationController, animated: true)
        }
    }
    
    func presentErrorAlert(message: String) {
        let alertController = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let close = UIAlertAction(title: "Close", style: .default)
        alertController.addAction(close)
        present(alertController, animated: true)
    }
}

