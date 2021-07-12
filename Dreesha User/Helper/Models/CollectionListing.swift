// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let collectionListing = try? newJSONDecoder().decode(CollectionListing.self, from: jsonData)

import Foundation

// MARK: - CollectionListing
struct CollectionListing: Codable {
    let code: Int?
    let data: [ClDatum?]
}

// MARK: - Datum
struct ClDatum: Codable {
    let isDeleted: Bool?
    let id, collectionName, userID, createdAt: String?
    let updatedAt, datumID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case collectionName = "collection_name"
        case userID = "user_id"
        case createdAt, updatedAt
        case datumID = "id"
    }
}
