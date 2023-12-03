//
//  FirebaseCollection.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import Foundation
import FirebaseFirestore

enum FirebaseCollection {
    static let users = Firestore.firestore().collection("users")
}
