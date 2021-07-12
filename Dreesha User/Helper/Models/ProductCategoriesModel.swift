// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productCategoriesModel = try? newJSONDecoder().decode(ProductCategoriesModel.self, from: jsonData)

import Foundation

// MARK: - ProductCategoriesModel
struct ProductCategoriesModel: Codable {
    let code: Int?
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let status: PRStatus?
    let isApprove, isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let categoryID: String?
    let professionalID: String?

    enum CodingKeys: String, CodingKey {
        case status, isApprove, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case categoryID = "id"
        case professionalID = "professional_id"
    }
}

enum PRStatus: String, Codable {
    case active = "active"
}
