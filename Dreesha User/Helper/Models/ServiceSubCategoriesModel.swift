// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let serviceSubCategoriesModel = try? newJSONDecoder().decode(ServiceSubCategoriesModel.self, from: jsonData)

import Foundation

// MARK: - ServiceSubCategoriesModel
struct ServiceSubCategoriesModel: Codable {
    let code: Int?
    let msg: String?
    let data: [SubDatum]?
}

// MARK: - Datum
class SubDatum: Codable {
    let status: SubStatus?
    let isDeleted: Bool?
    let id, name: String?
    let serviceCategoryID: SubDatum?
    let createdAt, updatedAt, datumID: String?
    let isApprove: Bool?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case serviceCategoryID = "service_category_id"
        case createdAt, updatedAt
        case datumID = "id"
        case isApprove
    }

    init(status: SubStatus, isDeleted: Bool, id: String, name: String, serviceCategoryID: SubDatum?, createdAt: String, updatedAt: String, datumID: String, isApprove: Bool?) {
        self.status = status
        self.isDeleted = isDeleted
        self.id = id
        self.name = name
        self.serviceCategoryID = serviceCategoryID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.datumID = datumID
        self.isApprove = isApprove
    }
}

enum SubStatus: String, Codable {
    case active = "active"
    case inactive = "inactive"
}
