// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let professionalProjectsModel = try? newJSONDecoder().decode(ProfessionalProjectsModel.self, from: jsonData)

import Foundation

// MARK: - ProfessionalProjectsModelElement
struct ProfessionalProjectsModelElement: Codable {
    let projectCategory, projectSubCategory: [ProjectStyleElement]?
    let projectKeyword, projectImages: [ProjectImage]?
    let projectPublishProduct, projectPublishProfessional, projectPublishServices: Bool?
    let projectCountry, projectCity: [String]?
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let projectYear: Int?
    let projectStyle: ProjectStyleElement?
    let projectAddress: String?
    let projectCost: Int?
    let projectName, projectWebsite, professionalID, createdAt: String?
    let updatedAt, professionalProjectsModelID: String?

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
        case professionalProjectsModelID = "id"
    }
}

// MARK: - ProjectStyleElement
struct ProjectStyleElement: Codable {
    let status: String?
    let isApprove: Bool?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let projectID: String?
    let serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isApprove, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case projectID = "id"
        case serviceCategoryID = "service_category_id"
    }
}

// MARK: - ProjectImageElement
struct ProjectImage: Codable {
    let name: String?
}

typealias ProfessionalProjectsModel = [ProfessionalProjectsModelElement]
