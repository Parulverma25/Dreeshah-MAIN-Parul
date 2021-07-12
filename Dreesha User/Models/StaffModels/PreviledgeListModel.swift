//
//  PreviledgeListModel.swift
//  Dreesha User
//
//  Created by promatics on 28/04/21.
//

import Foundation

// MARK: - PreviledegeListModelElement
struct PreviledegeListModelElement: Codable {
    let status: String?
    let id, name, createdAt, updatedAt: String?
    let previledegeListModelID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case name, createdAt, updatedAt
        case previledegeListModelID = "id"
    }
}



typealias PreviledegeListModel = [PreviledegeListModelElement]
