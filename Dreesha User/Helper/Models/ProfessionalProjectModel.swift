//
//  ProfessionalProjectModel.swift
//  Dreesha User
//
//  Created by Promatics on 19/04/21.
//

import Foundation

//MARK: - ProfessionalStyleDetail

// MARK: - ProfessionaStyleModelElement
struct ProfessionaStyleModelElement: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let professionaStyleModelID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case professionaStyleModelID = "id"
    }
}


typealias ProfessionaStyleModel = [ProfessionaStyleModelElement]


//MARK:- ProffesionalCategoryModel
struct ProfessionalCategoryModelElement: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let subCategories: [ProfessionalCategoryModelElement]?
    let professionalCategoryModelID: String?
    let serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case subCategories = "sub_categories"
        case professionalCategoryModelID = "id"
        case serviceCategoryID = "service_category_id"
    }
}



typealias ProfessionalCategoryModel = [ProfessionalCategoryModelElement]

//MARK:- ProfessionalBranchList
struct ProfessionalBranchModelElement: Codable {
    let addressDetails: [AddressDetail]?
    let id, branchNameEn, branchNameAr: String?

    enum CodingKeys: String, CodingKey {
        case addressDetails = "address_details"
        case id = "_id"
        case branchNameEn = "branch_name_en"
        case branchNameAr = "branch_name_ar"
    }
}

typealias ProfessionalBranchModel = [ProfessionalBranchModelElement]
