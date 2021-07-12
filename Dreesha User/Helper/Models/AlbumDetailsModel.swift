// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let albumDetailsModel = try? newJSONDecoder().decode(AlbumDetailsModel.self, from: jsonData)

import Foundation
import UIKit

// MARK: - AlbumDetailsModel
struct AlbumDetailsModel: Codable {
    let code: Int?
    let message: String?
    var result: DetailResult
}

// MARK: - Result
struct DetailResult: Codable {
    var albumImages: [DetailAlbumImage]
    let id, userID: String?
    let subCategoryID: AlbumSubCategoryID?
    let albumName, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case albumImages = "album_images"
        case id = "_id"
        case userID = "user_id"
        case subCategoryID = "sub_category_id"
        case albumName = "album_name"
        case createdAt, updatedAt
    }
}

// MARK: - AlbumImage
struct  DetailAlbumImage: Codable {
    let image, id, mediaType: String
    var thumbnail :UIImage?
    enum CodingKeys: String, CodingKey {
        case image
        case id = "_id"
        case mediaType = "media_type"
    }
}

// MARK: - SubCategoryID
struct AlbumSubCategoryID: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, serviceCategoryID, createdAt: String?
    let updatedAt, subCategoryIDID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case serviceCategoryID = "service_category_id"
        case createdAt, updatedAt
        case subCategoryIDID = "id"
    }
}
