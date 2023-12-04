//
//  AuthService.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import UIKit
import FirebaseAuth

struct AuthService {
    
    static func signUp(email: String, password: String, name: String, profileImage: UIImage? = nil) async throws {
        do {
            // Create user on back end
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("[DEBUG] Created user with uid: \(result.user.uid)")
            
            // Handle user image if he has selected one
            var profilePicURL: String? = nil
            if let profileImage {
                profilePicURL = try await ImageService.upload(profileImage, type: .profile)
            }
            
            // Upload user data to back end
            let user = UserModel(
                id: result.user.uid,
                email: email,
                name: name,
                fullName: nil,
                profileImageURL: profilePicURL
            )
            UserService.uploadData(user)
        } catch {
            throw error
        }
    }
    
    static func login(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    static func logout() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
}
