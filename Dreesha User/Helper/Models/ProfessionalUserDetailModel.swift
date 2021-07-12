//
//  ProfessionalUserDetailModel.swift
//  Dreesha User
//
//  Created by Apple on 05/04/21.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginModel = try? newJSONDecoder().decode(ProfessionalUserDetailModel.self, from: jsonData)

import Foundation

// MARK: - ProfessionalUserDetailModel
struct ProfessionalUserDetailModel: Codable {
    let code: Int?
    let data: ProfessionalData?
    let userServices: [UserService]?
    
    enum CodingKeys: String, CodingKey {
            case code, data
            case userServices = "user_services"
        }

}

// MARK: - DataClass
struct ProfessionalData: Codable {
    
    let userType: String?
    let profileImage: String?
    let logoImage: String?
    
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards: [CertificateAward]?
    let addressDetails: [AddressDetail]?
    let serviceCategories, serviceSubcategories: [BranchCategoryID]
    let cardDetails: [String]?
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let serviceDetails: ServiceDetails?
    let branchTypeID, firstName: String?
    let contactDetails: ContactDetails?
    let branchNameAr, lastName, password, branchNameEn: String?
    let branchBrief, branchCategoryID, email: String?
    let businessDetails: BusinessDetails?
    let otp: Int?
    let professionalAddress: AddressDetail?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case profileImage = "profile_image"
        case logoImage = "logo"
        case verified
        case emailVerified = "email_verified"
        case noOfBranches = "no_of_branches"
        case certificateAwards = "certificate_awards"
        case addressDetails = "address_details"
        case serviceCategories = "service_categories"
        case serviceSubcategories = "service_subcategories"
        case cardDetails = "card_details"
        case status, isDeleted
        case id = "_id"
        case serviceDetails = "service_details"
        case branchTypeID = "branch_type_id"
        case firstName = "first_name"
        case contactDetails = "contact_details"
        case branchNameAr = "branch_name_ar"
        case lastName = "last_name"
        case password
        case branchNameEn = "branch_name_en"
        case branchBrief = "branch_brief"
        case branchCategoryID = "branch_category_id"
        case email
        case businessDetails = "business_details"
        case professionalAddress = "professional_address"
        case otp, createdAt, updatedAt
    }

}


// MARK: - BranchCategoryID
struct BranchCategoryID: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name: String?
    let brandTypeID: String?
    let createdAt, updatedAt, branchCategoryIDID: String?
    let isApprove: Bool?
    let professionalID, serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case brandTypeID = "brand_type_id"
        case createdAt, updatedAt
        case branchCategoryIDID = "id"
        case isApprove
        case professionalID = "professional_id"
        case serviceCategoryID = "service_category_id"
    }
}

// MARK: - AddressDetail
struct AddressDetail: Codable {
   
    let country, state, phoneNumber, countryPhCode: String?
    let addressLine1, addressLine2, addrFirstName, addrLastName: String?
    let city: String?
    let pincode: Int?
    let landmark: String?

    enum CodingKeys: String, CodingKey {
        case country, state
        case phoneNumber = "phone_number"
        case countryPhCode = "country_ph_code"
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case addrFirstName = "addr_first_name"
        case addrLastName = "addr_last_name"
        case city, pincode, landmark
    }

}

// MARK: - BusinessDetails
struct BusinessDetails: Codable {

        let issuedInCities: [String]?
        let noOfEmp: String?
        let issuedInCountries: [String]?
        let licenceNumber,branchLicence: String?
        let  branchYear : Int?

        enum CodingKeys: String, CodingKey {
            case issuedInCities = "issued_in_cities"
            case noOfEmp = "no_of_emp"
            case issuedInCountries = "issued_in_countries"
            case licenceNumber = "licence_number"
            case branchYear = "branch_year"
            case branchLicence = "branch_licence"
        }
}

// MARK: - CertificateAward
struct CertificateAward: Codable {
    let image, date: String?
}

// MARK: - ContactDetails
struct ContactDetails: Codable {
    let businessCountryCode, instaAcc, mobileNumber, youtubeChannel: String?
        let coOrdinatorArabic, countryCode, coOrdinatorEng, businessMobileNumber: String?
        let branchWebsite, branchEmail: String?

        enum CodingKeys: String, CodingKey {
            case businessCountryCode = "business_country_code"
            case instaAcc = "insta_acc"
            case mobileNumber = "mobile_number"
            case youtubeChannel = "youtube_channel"
            case coOrdinatorArabic = "co_ordinator_arabic"
            case countryCode = "country_code"
            case coOrdinatorEng = "co_ordinator_eng"
            case businessMobileNumber = "business_mobile_number"
            case branchWebsite = "branch_website"
            case branchEmail = "branch_email"
        }
}

// MARK: - ServiceDetails
struct ServiceDetails: Codable {
    
    let servicesProducts, serviceCountry, serviceCity: [String]?
        let serviceCost: String?

        enum CodingKeys: String, CodingKey {
            case servicesProducts = "services_products"
            case serviceCountry = "service_country"
            case serviceCity = "service_city"
            case serviceCost = "service_cost"
        }
}




// MARK: - UserService
struct UserService: Codable {
    let id, userID, userType: String?
    let serviceID: ServiceID?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "user_id"
        case userType = "user_type"
        case serviceID = "service_id"
        case createdAt, updatedAt
    }
}


// MARK: - ServiceID
struct ServiceID: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, serviceCategoryID, createdAt: String?
    let updatedAt, serviceIDID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case serviceCategoryID = "service_category_id"
        case createdAt, updatedAt
        case serviceIDID = "id"
    }
}
