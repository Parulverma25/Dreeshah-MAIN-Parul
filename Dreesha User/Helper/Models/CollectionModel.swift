// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collectionModel = try? newJSONDecoder().decode(CollectionModel.self, from: jsonData)

import Foundation

// MARK: - CollectionModel
struct CollectionModel: Codable {
    let code: Int?
    let collections: [Collection]?
}

// MARK: - Collection
struct Collection: Codable {
    let isDeleted: Bool?
    let id, name, userID, createdAt: String?
    let updatedAt, collectionID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case name
        case userID = "user_id"
        case createdAt, updatedAt
        case collectionID = "id"
    }
}
