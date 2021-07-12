// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getAllServicesModel = try? newJSONDecoder().decode(GetAllServicesModel.self, from: jsonData)

import Foundation

// MARK: - GetAllServicesModelElement
struct GetAllServicesModelElement: Codable {
    let areaCovered, country: [String]?
    let serviceCategory, serviceSubCategory: [ServiceCategory]?
    let relatedImages, otherImages: [Image]?
    let serviceVisibleCustomer, serviceVisibleProfessional: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, serviceName, serviceDescription, serviceImage: String?
    let price: Int?
    let duration: String?
    let professionalID: ProfessionalID?
    let serviceProject: [HMServiceProject]?
    let createdAt, updatedAt, getAllServicesModelID: String?

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
        case price, duration
        case professionalID = "professional_id"
        case serviceProject = "service_project"
        case createdAt, updatedAt
        case getAllServicesModelID = "id"
    }
}

// MARK: - ServiceProject
struct HMServiceProject: Codable {
    let id : String?
    let projectID : ProjectID?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case projectID = "project_id"
    }
}

// MARK: - Image
struct Image: Codable {
    let imageName, imageDescription: String?

    enum CodingKeys: String, CodingKey {
        case imageName = "image_name"
        case imageDescription = "description"
    }
}



// MARK: - BranchContactDetails
struct BranchContactDetails: Codable {
    let coOrdinatorEng, coOrdinatorArabic, branchEmail, branchWebsite: String?
    let countryCode, businessCountryCode, mobileNumber, businessMobileNumber: String?
    let instaAcc, youtubeChannel: String?

    enum CodingKeys: String, CodingKey {
        case coOrdinatorEng = "co_ordinator_eng"
        case coOrdinatorArabic = "co_ordinator_arabic"
        case branchEmail = "branch_email"
        case branchWebsite = "branch_website"
        case countryCode = "country_code"
        case businessCountryCode = "business_country_code"
        case mobileNumber = "mobile_number"
        case businessMobileNumber = "business_mobile_number"
        case instaAcc = "insta_acc"
        case youtubeChannel = "youtube_channel"
    }
}


// MARK: - ProfessionalIDContactDetails
struct ProfessionalIDContactDetails: Codable {
    let mobileNumber, businessMobileNumber: String?

    enum CodingKeys: String, CodingKey {
        case mobileNumber = "mobile_number"
        case businessMobileNumber = "business_mobile_number"
    }
}




typealias GetAllServicesModel = [GetAllServicesModelElement]
