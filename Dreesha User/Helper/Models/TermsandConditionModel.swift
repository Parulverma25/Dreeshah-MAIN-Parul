//
//  TermsandConditionModel.swift
//  Dreesha User
//
//  Created by Promatics on 10/04/21.
//

import Foundation

// MARK: - TermsandConditionModel
struct TermsandConditionModel: Codable {
    let code: Int?
    let msg: String?
    let data: TermsDataClass?
}

// MARK: - DataClass
struct TermsDataClass: Codable {
    let id, title, dataDescription, type: String?
    let createdAt, updatedAt, dataID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case dataDescription = "description"
        case type, createdAt, updatedAt
        case dataID = "id"
    }
}
