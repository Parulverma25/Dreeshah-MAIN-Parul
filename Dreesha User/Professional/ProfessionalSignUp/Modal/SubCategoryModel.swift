//
//  SubCategoryModel.swift
//  Dreesha User
//
//  Created by promatics on 2/22/1400 AP.
//

import Foundation

// MARK: - SubCategoryModelElement
struct SubCategoryModelElement: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, serviceCategoryID, createdAt: String?
    let updatedAt, subCategoryModelID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case serviceCategoryID = "service_category_id"
        case createdAt, updatedAt
        case subCategoryModelID = "id"
    }
}

typealias SubCategoryModel = [SubCategoryModelElement]

// MARK: - ProjectBySubCategoryModelElement
struct ProjectBySubCategoryModelElement: Codable {
    let projectKeyword, projectImages: [Project]?
    let projectPublishProduct, projectPublishProfessional, projectPublishServices: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, projectName, projectAddress: String?
    let projectCategory: [String]?
    let projectStyle: String?
    let projectYear, projectCost: Int?
    let projectWebsite, professionalID, createdAt, updatedAt: String?
    let projectBySubCategoryModelID: String?

    enum CodingKeys: String, CodingKey {
        case projectKeyword = "project_keyword"
        case projectImages = "project_images"
        case projectPublishProduct = "project_publish_product"
        case projectPublishProfessional = "project_publish_professional"
        case projectPublishServices = "project_publish_services"
        case status, isDeleted
        case id = "_id"
        case projectName = "project_name"
        case projectAddress = "project_address"
        case projectCategory = "project_category"
        case projectStyle = "project_style"
        case projectYear = "project_year"
        case projectCost = "project_cost"
        case projectWebsite = "project_website"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case projectBySubCategoryModelID = "id"
    }
}

// MARK: - Project
struct Project: Codable {
    let name: String?
}

typealias ProjectBySubCategoryModel = [ProjectBySubCategoryModelElement]
