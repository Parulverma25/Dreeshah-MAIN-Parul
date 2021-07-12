import Foundation

// MARK: - ProfWPaginationModelElement
struct ProfWPaginationModelElement: Codable {
    let userType: String?
    let profileImage, logo: String?
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards: [ProfWCertificateAward]?
    let cardDetails: [String]?
    let serviceCategories, serviceSubcategories: [ProfWServiceSubcategoryElement]?
    let addressDetails: [ProfWPaginationModelAddressDetail]?
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, email: String?
    let password, branchNameEn, branchNameAr: String?
    let branchTypeID: String?
    let branchCategoryID: BranchCategoryID?
    let branchBrief: String?
    let businessDetails: ProfWBusinessDetails?
    let contactDetails: ProfWPaginationModelContactDetails?
    let serviceDetails: ProfWServiceDetails?
    let otp: Int?
    let createdAt, updatedAt: String?
    let professionalAddress: Address?
    let branches: [Branch]?
    let services: [Service]?
    let profWPaginationModelID: String?
    let phoneNumber, city, country, state: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case profileImage = "profile_image"
        case logo, verified
        case emailVerified = "email_verified"
        case noOfBranches = "no_of_branches"
        case certificateAwards = "certificate_awards"
        case cardDetails = "card_details"
        case serviceCategories = "service_categories"
        case serviceSubcategories = "service_subcategories"
        case addressDetails = "address_details"
        case status, isDeleted
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, password
        case branchNameEn = "branch_name_en"
        case branchNameAr = "branch_name_ar"
        case branchTypeID = "branch_type_id"
        case branchCategoryID = "branch_category_id"
        case branchBrief = "branch_brief"
        case businessDetails = "business_details"
        case contactDetails = "contact_details"
        case serviceDetails = "service_details"
        case otp, createdAt, updatedAt
        case professionalAddress = "professional_address"
        case branches, services
        case profWPaginationModelID = "id"
        case phoneNumber = "phone_number"
        case city, country, state
    }
}

// MARK: - ProfWPaginationModelAddressDetail
struct ProfWPaginationModelAddressDetail: Codable {
    let firstName, lastName, addressLine1, addressLine2: String?
    let city: String?
    let state, zipCode, phoneNumber, landmark: String?
    let addressType: String?
    let country: String?
    let countryPhCode, isDefault, id: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city, state
        case zipCode = "zip_code"
        case phoneNumber = "phone_number"
        case landmark
        case addressType = "address_type"
        case country
        case countryPhCode = "country_ph_code"
        case isDefault = "is_default"
        case id = "_id"
    }
}


// MARK: - Branch
struct Branch: Codable {
    let branchCertificates: [ProfWCertificateAward]?
    let branchProfile, logo: String?
    let addressDetails: [BranchAddressDetail]?
    let serviceCategories: [String]?
    let serviceSubcategories: [String]?
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName: String?
    let userID: String?
    let email, password, branchNameEn, branchNameAr: String?
    let branchTypeID: String?
    let branchCategoryID: BranchCategoryID?
    let branchBrief: String?
    let contactDetails: ProfWBranchContactDetails?
    let businessDetails: ProfWBusinessDetails?
    let serviceDetails: ProfWServiceDetails?
    let branchAddress: Address?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case branchCertificates = "branch_certificates"
        case branchProfile = "branch_profile"
        case logo
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
        case branchAddress = "branch_address"
        case createdAt, updatedAt
    }
}

// MARK: - BranchAddressDetail
struct BranchAddressDetail: Codable {
}

// MARK: - Address
struct Address: Codable {
    let country, state, phoneNumber, countryPhCode: String?
    let addressLine1, addressLine2, addrFirstName, addrLastName: String?
    let city: String?
    let pincode: Int?
    let landmark: String?
    let isDefault, id: String?

    enum CodingKeys: String, CodingKey {
        case country, state
        case phoneNumber = "phone_number"
        case countryPhCode = "country_ph_code"
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case addrFirstName = "addr_first_name"
        case addrLastName = "addr_last_name"
        case city, pincode, landmark
        case isDefault = "is_default"
        case id = "_id"
    }
}

// MARK: - CertificateAward
struct ProfWCertificateAward: Codable {
    let image, date: String?
}

// MARK: - BusinessDetails
struct ProfWBusinessDetails: Codable {
    let branchYear: Int?
    let issuedInCountries: [String]?
    let issuedInCities: [String]?
    let branchLicence, licenceNumber, noOfEmp: String?

    enum CodingKeys: String, CodingKey {
        case branchYear = "branch_year"
        case issuedInCountries = "issued_in_countries"
        case issuedInCities = "issued_in_cities"
        case branchLicence = "branch_licence"
        case licenceNumber = "licence_number"
        case noOfEmp = "no_of_emp"
    }
}

// MARK: - BranchContactDetails
struct ProfWBranchContactDetails: Codable {
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

// MARK: - ServiceDetails
struct ProfWServiceDetails: Codable {
    let serviceCountry, serviceCity: [String]?
    let serviceCost: String?
    let servicesProducts: [String]?

    enum CodingKeys: String, CodingKey {
        case serviceCountry = "service_country"
        case serviceCity = "service_city"
        case serviceCost = "service_cost"
        case servicesProducts = "services_products"
    }
}


// MARK: - ProfWPaginationModelContactDetails
struct ProfWPaginationModelContactDetails: Codable {
    let coOrdinatorEng, coOrdinatorArabic, branchEmail: String?
    let branchWebsite: String?
    let countryCode, businessCountryCode: String?
    let mobileNumber, businessMobileNumber: String?
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


// MARK: - ServiceSubcategoryElement
struct ProfWServiceSubcategoryElement: Codable {
    let status: String?
    let isApprove: Bool?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let serviceCategoryID: String?
    let professionalID: String?
    let serviceCategoryServiceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isApprove, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case serviceCategoryID = "id"
        case professionalID = "professional_id"
        case serviceCategoryServiceCategoryID = "service_category_id"
    }
}

// MARK: - Service
struct Service: Codable {
    let areaCovered, country: [String]?
    let serviceBranches: [String]?
    let tags: [String]?
    let serviceCategory: [String]?
    let serviceSubCategory: [String]?
    let relatedImages, otherImages: [ProfImage]?
    let serviceVisibleCustomer, serviceVisibleProfessional: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, serviceName, serviceDescription, serviceImage: String?
    let serviceProject: [ServiceProject]?
    let price: Int?
    let duration: String?
    let professionalID: ID?
    let createdAt, updatedAt, serviceID: String?

    enum CodingKeys: String, CodingKey {
        case areaCovered = "area_covered"
        case country
        case serviceBranches = "service_branches"
        case tags
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
        case serviceID = "id"
    }
}

// MARK: - Image
struct ProfImage: Codable {
    let imageName, imageDescription: String?

    enum CodingKeys: String, CodingKey {
        case imageName = "image_name"
        case imageDescription = "description"
    }
}


// MARK: - ServiceProject
struct ProfWServiceProject: Codable {
    let id, projectID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case projectID = "project_id"
    }
}

typealias ProfWPaginationModel = [ProfWPaginationModelElement]
