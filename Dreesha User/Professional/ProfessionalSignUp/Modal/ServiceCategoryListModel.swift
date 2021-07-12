//
//  ServiceCategoryListModel.swift
//  Dreesha User
//
//  Created by promatics on 2/22/1400 AP.
//

import Foundation
// MARK: - ServiceCategoryModelElement
struct ServiceCategoryListModelElement: Codable {
    let status: String?
    let isApprove, isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let serviceCategoryModelID: String?
    let professionalID: String?

    enum CodingKeys: String, CodingKey {
        case status, isApprove, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case serviceCategoryModelID = "id"
        case professionalID = "professional_id"
    }
}


typealias ServiceCategoryListModel = [ServiceCategoryListModelElement]
