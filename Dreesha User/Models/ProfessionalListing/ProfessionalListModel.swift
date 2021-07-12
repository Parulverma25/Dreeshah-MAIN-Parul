
import Foundation

// MARK: - ProfessionalListModelElement
struct ProfessionalListModelElement: Codable {
    let userType: UserType?
    let profileImage: String?
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards: [ProCertificateAward?]
    let cardDetails: [String?]
    let serviceCategories, serviceSubcategories: [ServiceSubcategoryElement?]
    let addressDetails: [ProfessionalAddress?]
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, email: String?
    let password, branchNameEn, branchNameAr: String?
    let branchTypeID: String?
    let branchCategoryID: String?
    let branchBrief, phoneNumber: String?
    let contactDetails: ProContactDetails?
    let businessDetails: ProBusinessDetails?
    let serviceDetails: ProServiceDetails?
    let professionalAddress: ProfessionalAddress?
    let createdAt, updatedAt: String?
    let branches: [ProBranch]?
    let services: [ProService]?
    let professionalListModelID: String?
    let city, country, state: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case profileImage = "profile_image"
        case verified
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
        case phoneNumber = "phone_number"
        case contactDetails = "contact_details"
        case businessDetails = "business_details"
        case serviceDetails = "service_details"
        case professionalAddress = "professional_address"
        case createdAt, updatedAt, branches, services
        case professionalListModelID = "id"
        case city, country, state
    }
}

// MARK: - ProfessionalAddress
struct ProfessionalAddress: Codable {
    let country, state, phoneNumber: String?
    let countryPhCode: String?
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



// MARK: - Branch
struct ProBranch: Codable {
    let branchCertificates: [ProCertificateAward?]
    let branchProfile: String?
    let addressDetails: [ProAddressDetail?]
    let serviceCategories, serviceSubcategories: [String?]
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, userID: String?
    let email, password, branchNameEn, branchNameAr: String?
    let branchTypeID: String?
    let branchCategoryID: String?
    let branchBrief: String?
    let contactDetails: ProContactDetails?
    let businessDetails: ProBusinessDetails?
    let serviceDetails: ProServiceDetails?
    let createdAt, updatedAt: String?
    let branchAddress: ProfessionalAddress?

    enum CodingKeys: String, CodingKey {
        case branchCertificates = "branch_certificates"
        case branchProfile = "branch_profile"
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

// MARK: - AddressDetail
struct ProAddressDetail: Codable {
}

// MARK: - CertificateAward
struct ProCertificateAward: Codable {
    let image, date: String?
}

// MARK: - BusinessDetails
struct ProBusinessDetails: Codable {
    let branchYear: Int?
    let issuedInCountries: [String?]
    let issuedInCities: [String?]
    let branchLicence: String?
    let licenceNumber: String?
    let noOfEmp: String?

    enum CodingKeys: String, CodingKey {
        case branchYear = "branch_year"
        case issuedInCountries = "issued_in_countries"
        case issuedInCities = "issued_in_cities"
        case branchLicence = "branch_licence"
        case licenceNumber = "licence_number"
        case noOfEmp = "no_of_emp"
    }
}



// MARK: - ContactDetails
struct ProContactDetails: Codable {
    let coOrdinatorEng, coOrdinatorArabic, branchEmail: String?
    let branchWebsite: String?
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
struct ProServiceDetails: Codable {
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

enum Status: String, Codable {
    case active = "active"
}

// MARK: - ServiceSubcategoryElement
struct ServiceSubcategoryElement: Codable {
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
struct ProService: Codable {
    let areaCovered, country: [String?]
    let serviceBranches, tags: [String?]
    let serviceCategory: [String?]
    let serviceSubCategory: [String?]
    let relatedImages, otherImages: [ProImage?]
    let serviceVisibleCustomer, serviceVisibleProfessional: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, serviceName, serviceDescription, serviceImage: String?
    let serviceProject: [ProServiceProject?]
    let price: Int?
    let duration, professionalID, createdAt, updatedAt: String?
    let serviceID: String?

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
struct ProImage: Codable {
    let imageName, imageDescription: String?

    enum CodingKeys: String, CodingKey {
        case imageName = "image_name"
        case imageDescription = "description"
    }
}

// MARK: - ServiceProject
struct ProServiceProject: Codable {
    let id, projectID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case projectID = "project_id"
    }
}

enum UserType: String, Codable {
    case professional = "professional"
}

typealias ProfessionalListModel = [ProfessionalListModelElement?]
