//
//  DesignationListModel.swift
//  Dreesha User
//
//  Created by promatics on 2/20/1400 AP.
//

import Foundation
// MARK: - DesignationListModelElement
struct DesignationListModelElement: Codable {
    let id, name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
    }
}

typealias DesignationListModel = [DesignationListModelElement]
