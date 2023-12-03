//
//  UserModel.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import UIKit

struct UserModel: Identifiable, Codable {
    let id: String
    let email: String
    var name: String
    var fullName: String?
    var profileImageURL: String?
}
