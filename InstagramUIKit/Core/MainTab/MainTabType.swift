//
//  MainTabType.swift
//  InstagramUIKit
//
//  Created by Maciej on 04/12/2023.
//

import UIKit

extension MainTabController {
    
    enum MainTabType {
        case feed
        case search
        case upload
        case notifications
        case profile
        
        var selectedImage: UIImage {
            switch self {
            case .feed:
                return .init(systemName: "house.fill") ?? .init()
            case .search:
                return .init(systemName: "magnifyingglass") ?? .init()
            case .upload:
                return .init(systemName: "plus.app") ?? .init()
            case .notifications:
                return .init(systemName: "heart.fill") ?? .init()
            case .profile:
                return .init(systemName: "person.fill") ?? .init()
            }
        }
        
        var image: UIImage {
            switch self {
            case .feed:
                return .init(systemName: "house") ?? .init()
            case .search:
                return .init(systemName: "magnifyingglass") ?? .init()
            case .upload:
                return .init(systemName: "plus.app") ?? .init()
            case .notifications:
                return .init(systemName: "heart") ?? .init()
            case .profile:
                return .init(systemName: "person") ?? .init()
            }
        }
    }
}
