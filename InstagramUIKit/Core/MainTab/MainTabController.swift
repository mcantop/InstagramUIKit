//
//  MainTabController.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import UIKit
import Firebase

final class MainTabController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To avoid weird black background before `setupViewControllers` is called
        view.backgroundColor = .backgroundColor
        
        if isUserLoggedIn {
            setupViewControllers()
        } else {
            presentLoginController(authDelegate: self)
        }
    }
}

// MARK: - Internal
extension MainTabController {
    
    func setupViewControllers() {
        let feedController = FeedController(collectionViewLayout: UICollectionViewLayout())
        feedController.authDelegate = self
        
        let feedNavigationController = constructNavigationController(
            type: .feed,
            rootController: feedController
        )
        let searchNavigationController = constructNavigationController(
            type: .search,
            rootController: SearchController()
        )
        let uploadNavigationController = constructNavigationController(
            type: .upload,
            rootController: UploadController()
        )
        let notificationsNavigationController = constructNavigationController(
            type: .notifications,
            rootController: NotificationsController()
        )
        let profileNavigationController = constructNavigationController(
            type: .profile,
            rootController: ProfileController(collectionViewLayout: UICollectionViewLayout())
        )
                
        let controllers = [
            feedNavigationController,
            searchNavigationController,
            uploadNavigationController,
            notificationsNavigationController,
            profileNavigationController
        ]
        
        setViewControllers(controllers, animated: true)
        
        tabBar.tintColor = .primaryColor
    }
}

// MARK: - AuthDelegate
extension MainTabController: AuthDelegate {
    
    func handleLoginFlow() {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            
            setupViewControllers()
        }
    }
}

// MARK: - Private
private extension MainTabController {
    
    var isUserLoggedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func constructNavigationController(
        type: MainTabType,
        rootController: UIViewController,
        authDelegate: AuthDelegate? = nil
    ) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.image = type.image
        navigationController.tabBarItem.selectedImage = type.selectedImage
        navigationController.navigationBar.tintColor = .primaryColor
        return navigationController
    }
}
