// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let branchCategoryModel = try? newJSONDecoder().decode(BranchCategoryModel.self, from: jsonData)

import Foundation

// MARK: - BranchCategoryModel
struct BranchCategoryModel: Codable {
    let code: Int?
    let msg: String?
    let data: [BranchCategoryValue]?
}

// MARK: - BranchCategoryValue
class BranchCategoryValue: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name: String?
    //let brandTypeID: BranchCategoryValue?
    let createdAt, updatedAt, datumID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        //case brandTypeID = "brand_type_id"
        case createdAt, updatedAt
        case datumID = "id"
    }

}
