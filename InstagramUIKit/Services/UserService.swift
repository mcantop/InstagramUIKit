//
//  UserService.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import Foundation
import FirebaseFirestore

struct UserService {
    
    static func uploadData(_ user: UserModel) {
        do {
            try FirebaseCollection.users.document(user.id).setData(from: user)
            print("[DEBUG] Uploaded user data..")
        } catch {
            print("[DEBUG] Error uploading user data.. \(error.localizedDescription)")
        }
    }
}
