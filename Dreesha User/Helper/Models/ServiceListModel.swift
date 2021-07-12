//
//  ServiceListModel.swift
//  Dreesha User
//
//  Created by Apple on 08/04/21.
//

import Foundation


struct ServiceListModel: Codable {
    let code: Int?
    let msg: String?
    let data: [ListData]?
}

struct ListData: Codable {
    let status: String?
    let isDeleted: Bool?
    let _id, name: String?
    let service_category_id: ServiceCategoryData?
    let createdAt, updatedAt, id: String?
}

struct ServiceCategoryData: Codable {
    let status: String?
    let isDeleted: Bool?
    let name, createdAt, updatedAt, id: String?
}
