// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let inventoryModel = try? newJSONDecoder().decode(InventoryModel.self, from: jsonData)

import Foundation

// MARK: - InventoryModel
struct InventoryModel: Codable {
    let code: Int?
    let result: [INResult]?
}

// MARK: - Result
struct INResult: Codable {
    let stockKeepingUnit: Int?
    let barcode, status: String?
    let isDeleted: Bool?
    let id, inventoryName, createdAt, updatedAt: String?
    let resultID: String?

    enum CodingKeys: String, CodingKey {
        case stockKeepingUnit = "stock_keeping_unit"
        case barcode, status, isDeleted
        case id = "_id"
        case inventoryName = "inventory_name"
        case createdAt, updatedAt
        case resultID = "id"
    }
}
