//
//  ProjectListingModel.swift
//  Dreesha User
//
//  Created by promatics on 26/04/21.
//

import Foundation

// MARK: - ProjectListingModelElement
struct ProjectListingModelElement: Codable {
    let projectKeyword, projectImages: [ProjectImageElement]?
    let projectPublishProduct, projectPublishProfessional, projectPublishServices: Bool?
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let projectYear: Int?
    let projectStyle: ProjectStyleClass?
    let projectAddress, projectWebsite: String?
    let projectCost: Int?
    let projectName: String?
    let projectCategory: [ProjectStyleClass]?
    let professionalID, createdAt, updatedAt, projectListingModelID: String?

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
        case projectListingModelID = "id"
    }
}

// MARK: - ProjectStyleClass
struct ProjectStyleClass: Codable {
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



// MARK: - ProjectImageElement
struct ProjectImageElement: Codable {
    let name: String?
}

typealias ProjectListingModel = [ProjectListingModelElement]
