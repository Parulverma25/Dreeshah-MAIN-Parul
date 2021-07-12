//
//  ServiceDetailsARModel.swift
//  Dreesha User
//
//  Created by promatics on 4/26/21.
//

import Foundation
// MARK: - ServiceDetailsAR
struct ServiceDetailsAR: Codable {
    var code: Int?
    var result: Results?
    var message: String?
}

// MARK: - Result
struct Results: Codable {
    let areaCovered, country: [String]?
    let serviceCategory, serviceSubCategory: [ServiceCategory]?
    let relatedImages, otherImages: [Image]?
    let serviceVisibleCustomer, serviceVisibleProfessional: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, serviceName, serviceDescription, serviceImage: String?
    let serviceProject: [ServiceProject]?
    let price: Int?
    let duration: String?
    let professionalID: ProfessionalID?
    let createdAt, updatedAt, resultID: String?

    enum CodingKeys: String, CodingKey {
        case areaCovered = "area_covered"
        case country
        case serviceCategory = "service_category"
        case serviceSubCategory = "service_sub_category"
        case relatedImages = "related_images"
        case otherImages = "other_images"
        case serviceVisibleCustomer = "service_visible_customer"
        case serviceVisibleProfessional = "service_visible_professional"
        case status, isDeleted
        case id = "_id"
        case serviceName = "service_name"
        case serviceDescription = "service_description"
        case serviceImage = "service_image"
        case serviceProject = "service_project"
        case price, duration
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case resultID = "id"
    }
}

// MARK: - AreaCovered
struct AreaCovereds: Codable {
    var city: String?
}

// MARK: - OtherImage
struct OtherImage: Codable {
    var name: String?
}

// MARK: - ProfessionalID
struct ProfessionalIDs: Codable {
    var profileImage, id: String?

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case id = "_id"
    }
}

// MARK: - ServiceCategory
struct ServiceCategory: Codable {
    var status: String?
    var isDeleted: Bool?
    var id, name, createdAt, updatedAt: String?
    var serviceCategoryID, serviceCategoryServiceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case serviceCategoryID = "id"
        case serviceCategoryServiceCategoryID = "service_category_id"
    }
}

// MARK: - ServiceProject
struct ServiceProject: Codable {
    var id: String?
    var projectID: ProjectID?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case projectID = "project_id"
    }
}

// MARK: - ProjectID
struct ProjectID: Codable {
    let projectCategory: [String]?
    let projectSubCategory: [String]?
    let projectKeyword, projectImages: [Project]?
    let projectPublishProduct, projectPublishProfessional, projectPublishServices: Bool?
    let projectCountry, projectCity: [String]?
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let projectYear: Int?
    let projectStyle, projectAddress: String?
    let projectCost: Int?
    let projectName, projectWebsite, professionalID, createdAt: String?
    let updatedAt, projectIDID: String?

    enum CodingKeys: String, CodingKey {
        case projectCategory = "project_category"
        case projectSubCategory = "project_sub_category"
        case projectKeyword = "project_keyword"
        case projectImages = "project_images"
        case projectPublishProduct = "project_publish_product"
        case projectPublishProfessional = "project_publish_professional"
        case projectPublishServices = "project_publish_services"
        case projectCountry = "project_country"
        case projectCity = "project_city"
        case status, isDeleted
        case id = "_id"
        case projectYear = "project_year"
        case projectStyle = "project_style"
        case projectAddress = "project_address"
        case projectCost = "project_cost"
        case projectName = "project_name"
        case projectWebsite = "project_website"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case projectIDID = "id"
    }
}
