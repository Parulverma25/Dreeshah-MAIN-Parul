// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collectionListsModel = try? newJSONDecoder().decode(CollectionListsModel.self, from: jsonData)

import Foundation

// MARK: - CollectionListsModelElement
struct CollectionListsModelElement: Codable {
    let isDeleted: Bool?
    let id, collectionName, userID, createdAt: String?
    let updatedAt: String?
    let productsCount: Int?
    let collectionListsModelID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case collectionName = "collection_name"
        case userID = "user_id"
        case createdAt, updatedAt
        case productsCount = "products_count"
        case collectionListsModelID = "id"
    }
}

typealias CollectionListsModel = [CollectionListsModelElement]
