//
//  BranchTypeModel.swift
//  Dreesha User
//
//  Created by Apple on 07/04/21.
//

import Foundation


struct BranchTypeModel: Codable {
    let code: Int?
    let msg: String?
    let data: [BranchDataValue]?
}


struct BranchDataValue: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let datumID: String?
    
    enum CodingKeys: String, CodingKey {
           case status, isDeleted
           case datumID = "_id"
           case name, createdAt, updatedAt
           case id = "id"
       }
}
