//
//  ProjectDetailModel.swift
//  Dreesha User
//
//  Created by promatics on 26/04/21.
//

import Foundation

// MARK: - ProjectDetailModel
struct ProjectDetailModel: Codable {
    let projectKeyword, projectImages: [ProjectImageElement]?
    let projectPublishProduct, projectPublishProfessional, projectPublishServices: Bool?
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let projectYear: Int?
    let projectStyle: ProjectCategoryClass?
    let projectAddress, projectWebsite: String?
    let projectCost: Int?
    let projectName: String?
    let projectCategory: [ProjectCategoryClass]?
    let professionalID, createdAt, updatedAt, projectDetailModelID: String?

    enum CodingKeys: String, CodingKey {
        case projectKeyword = "project_keyword"
        case projectImages = "project_images"
        case projectPublishProduct = "project_publish_product"
        case projectPublishProfessional = "project_publish_professional"
        case projectPublishServices = "project_publish_services"
        case status, isDeleted
        case id = "_id"
        case projectYear = "project_year"
        case projectStyle = "project_style"
        case projectAddress = "project_address"
        case projectWebsite = "project_website"
        case projectCost = "project_cost"
        case projectName = "project_name"
        case projectCategory = "project_category"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case projectDetailModelID = "id"
    }
}

// MARK: - ProjectCategoryClass
struct ProjectCategoryClass: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, serviceCategoryID, createdAt: String?
    let updatedAt, projectID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case serviceCategoryID = "service_category_id"
        case createdAt, updatedAt
        case projectID = "id"
    }
}


