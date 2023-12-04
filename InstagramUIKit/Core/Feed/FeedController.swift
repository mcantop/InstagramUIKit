//
//  FeedController.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

final class FeedController: UICollectionViewController {

    // MARK: - Properties
    weak var authDelegate: AuthDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
//        navigationController?.
        configureLogoutButton()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    func configureLogoutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Log Out",
            style: .plain,
            target: self,
            action: #selector(handleLogout)
        )
    }
    
    @objc private func handleLogout() {
        let alertController = UIAlertController(
            title: nil,
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Log Out",
                style: .destructive
            ) {  [weak self] _ in
                guard let self else { return }
                
                do {
                    try AuthService.logout()
                    
                    presentLoginController(authDelegate: authDelegate)
                } catch {
                    presentErrorAlert(message: error.localizedDescription)
                }
            }
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        
        present(alertController, animated: true)
    }
}
