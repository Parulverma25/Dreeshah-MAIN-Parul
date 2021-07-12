//
//  GetStyles.swift
//  Dreesha User
//
//  Created by promatics on 5/4/21.
//

import Foundation

// MARK: - GetStyles
struct GetStyles: Codable {
    var code: Int?
    var data: [Datumn]?
}

// MARK: - Datum
struct Datumn: Codable {
    var status: Statuss?
    var isDeleted: Bool?
    var id, name, createdAt, updatedAt: String?
    var datumID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case datumID = "id"
    }
}

enum Statuss: String, Codable {
    case active = "active"
}
