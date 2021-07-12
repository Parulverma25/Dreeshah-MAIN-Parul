// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let particularBranchDetailsModel = try? newJSONDecoder().decode(ParticularBranchDetailsModel.self, from: jsonData)

import Foundation

// MARK: - ParticularBranchDetailsModel
struct ParticularBranchDetailsModel: Codable {
    let branchCertificates: [BRBranchCertificate]?
    let branchProfile: String?
    let branchLogo: String?
    let addressDetails: [BranchAddress]?
    let serviceCategories, serviceSubcategories: [BRBranchCategoryID]?
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, userID: String?
    let email, password, branchNameEn, branchNameAr: String?
    let branchTypeID, branchCategoryID: BRBranchCategoryID?
    let branchBrief: String?
    let contactDetails: BRContactDetails?
    let businessDetails: BRBusinessDetails?
    let serviceDetails: BRServiceDetails?
    let createdAt, updatedAt: String?
    let branchAddress: BranchAddress?

    enum CodingKeys: String, CodingKey {
        case branchCertificates = "branch_certificates"
        case branchProfile = "branch_profile"
        case branchLogo = "logo"
        case addressDetails = "address_details"
        case serviceCategories = "service_categories"
        case serviceSubcategories = "service_subcategories"
        case status, isDeleted
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case userID = "user_id"
        case email, password
        case branchNameEn = "branch_name_en"
        case branchNameAr = "branch_name_ar"
        case branchTypeID = "branch_type_id"
        case branchCategoryID = "branch_category_id"
        case branchBrief = "branch_brief"
        case contactDetails = "contact_details"
        case businessDetails = "business_details"
        case serviceDetails = "service_details"
        case createdAt, updatedAt
        case branchAddress = "branch_address"
    }
}

// MARK: - BranchAddress
struct BranchAddress: Codable {
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

// MARK: - BranchCategoryID
struct BRBranchCategoryID: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name: String?
    let brandTypeID: String?
    let createdAt, updatedAt, branchCategoryIDID: String?
    let isApprove: Bool?
    let serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name
        case brandTypeID = "brand_type_id"
        case createdAt, updatedAt
        case branchCategoryIDID = "id"
        case isApprove
        case serviceCategoryID = "service_category_id"
    }
}

// MARK: - BranchCertificate
struct BRBranchCertificate: Codable {
    let image, date: String?
}

// MARK: - BusinessDetails
struct BRBusinessDetails: Codable {
    let branchYear : Int?
    let branchLicence: String?
    let issuedInCountries, issuedInCities: [String]?
    let licenceNumber, noOfEmp: String?

    enum CodingKeys: String, CodingKey {
        case branchYear = "branch_year"
        case branchLicence = "branch_licence"
        case issuedInCountries = "issued_in_countries"
        case issuedInCities = "issued_in_cities"
        case licenceNumber = "licence_number"
        case noOfEmp = "no_of_emp"
    }
}

// MARK: - ContactDetails
struct BRContactDetails: Codable {
    let mobileNumber, coOrdinatorArabic, branchWebsite, youtubeChannel: String?
    let countryCode, branchEmail, businessMobileNumber, instaAcc: String?
    let coOrdinatorEng, businessCountryCode: String?

    enum CodingKeys: String, CodingKey {
        case mobileNumber = "mobile_number"
        case coOrdinatorArabic = "co_ordinator_arabic"
        case branchWebsite = "branch_website"
        case youtubeChannel = "youtube_channel"
        case countryCode = "country_code"
        case branchEmail = "branch_email"
        case businessMobileNumber = "business_mobile_number"
        case instaAcc = "insta_acc"
        case coOrdinatorEng = "co_ordinator_eng"
        case businessCountryCode = "business_country_code"
    }
}

// MARK: - ServiceDetails
struct BRServiceDetails: Codable {
    let serviceCountry, serviceCity: [String]?
    let serviceCost: String?

    enum CodingKeys: String, CodingKey {
        case serviceCountry = "service_country"
        case serviceCity = "service_city"
        case serviceCost = "service_cost"
    }
}
