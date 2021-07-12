//
//  ServiceCategoryModel.swift
//  Dreesha User
//
//  Created by promatics on 4/29/21.
//

import Foundation

// MARK: - PopUpServiceCategory
struct PopUpServiceCategory: Codable {
    var code: Int?
    var data: [Datu]?
}

// MARK: - Datum
struct Datu: Codable {
    var status: String?
    var isDeleted: Bool?
    var id, name, createdAt, updatedAt: String?
    var subCategories: [Datu]?
    var datumID: String?
    var serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case subCategories = "sub_categories"
        case datumID = "id"
        case serviceCategoryID = "service_category_id"
    }
}


