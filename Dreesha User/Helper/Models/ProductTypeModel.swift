// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productTypeModel = try? newJSONDecoder().decode(ProductTypeModel.self, from: jsonData)

import Foundation

// MARK: - ProductTypeModel
struct ProductTypeModel: Codable {
    let code: Int?
    let productTypes: [TPProductType]?

    enum CodingKeys: String, CodingKey {
        case code
        case productTypes = "product_types"
    }
}

// MARK: - ProductType
struct TPProductType: Codable {
    let isDeleted: Bool?
    let id, productType, createdAt, updatedAt: String?
    let productTypeID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case productType = "product_type"
        case createdAt, updatedAt
        case productTypeID = "id"
    }
}
