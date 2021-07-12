// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vendorModel = try? newJSONDecoder().decode(VendorModel.self, from: jsonData)

import Foundation

// MARK: - VendorModel
struct VendorModel: Codable {
    let code: Int?
    let message: String?
    let result: [VNResult]?
}

// MARK: - Result
struct VNResult: Codable {
    let isDeleted: Bool?
    let id, productTypeID, vendorName, createdAt: String?
    let updatedAt, resultID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case productTypeID = "product_type_id"
        case vendorName = "vendor_name"
        case createdAt, updatedAt
        case resultID = "id"
    }
}
