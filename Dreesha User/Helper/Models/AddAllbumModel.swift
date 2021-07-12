//
//  AddAllbumModel.swift
//  Dreesha User
//
//  Created by Promatics on 12/04/21.
//

import Foundation

// MARK: - AddAlbumModel
struct AddAlbumModel: Codable {
    let code: Int?
    let result: Result2
    let message: String?
}

// MARK: - Result
struct Result2: Codable {
    let albumImages: [String?]
    let id, userID, subCategoryID, albumName: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case albumImages = "album_images"
        case id = "_id"
        case userID = "user_id"
        case subCategoryID = "sub_category_id"
        case albumName = "album_name"
        case createdAt, updatedAt
    }
}
