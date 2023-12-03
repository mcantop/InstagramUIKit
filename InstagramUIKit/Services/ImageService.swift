//
//  ImageService.swift
//  InstagramUIKit
//
//  Created by Maciej on 03/12/2023.
//

import Foundation
import Firebase
import FirebaseStorage

enum ImageType: String {
    case profile
    case post
    
    var compressionQuality: CGFloat {
        switch self {
        case .profile:
            return 0.33
        case .post:
            return 0.66
        }
    }
}

struct ImageService {
    
    static func upload(_ image: UIImage, type: ImageType) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: type.compressionQuality) else { return nil }
        let filename = UUID().uuidString
        let reference = Storage.storage().reference(withPath:
            "/images/\(type)/\(filename)"
        )
        
        do {
            let _ = try await reference.putDataAsync(imageData)
            let url = try await reference.downloadURL()
            print("[DEBUG] Uploaded \(type) image")
            return url.absoluteString
        } catch {
            print("[DEBUG] Error uploading image - \(error.localizedDescription)")
            return nil
        }
    }
}
