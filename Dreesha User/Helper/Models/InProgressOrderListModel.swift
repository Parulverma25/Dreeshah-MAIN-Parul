// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let inProgressOrderListModel = try? newJSONDecoder().decode(InProgressOrderListModel.self, from: jsonData)

import Foundation

// MARK: - InProgressOrderListModelElement
struct InProgressOrderListModelElement: Codable {
    let id: IPIDClass?
    let products, orderID: [String]?
    let orderData: [IPOrderDatum]?
    let professionalData: [IPProfessionalDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case products
        case orderID = "order_id"
        case orderData, professionalData
    }
}

// MARK: - IDClass
struct IPIDClass: Codable {
    let orderID: String?
    let professionalID: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case professionalID = "professional_id"
    }
}


// MARK: - OrderDatum
struct IPOrderDatum: Codable {
    let id, paymentStatus, orderStatus: String?
    let refundStatus: Bool?
    let cancelReason: String?
    let orderHistory: [IPOrderHistory]?
    let userID: String?
    let amount: Int?
    let transactionID, paymentDate, orderNo, orderDate: String?
    let createdAt, updatedAt: String?
    let address: [String: String?]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case paymentStatus = "payment_status"
        case orderStatus = "order_status"
        case refundStatus = "refund_status"
        case cancelReason = "cancel_reason"
        case orderHistory = "order_history"
        case userID = "user_id"
        case amount
        case transactionID = "transaction_id"
        case paymentDate = "payment_date"
        case orderNo = "order_no"
        case orderDate = "order_date"
        case createdAt, updatedAt, address
    }
}

// MARK: - OrderHistory
struct IPOrderHistory: Codable {
    let state, date: String?
}


// MARK: - ProfessionalDatum
struct IPProfessionalDatum: Codable {
    let id: String?
    let userType, profileImage: String?
    let verified, emailVerified: Bool?
    let loginAttempts, noOfBranches: Int?
    let certificateAwards: [CertificateAward]?
    let cardDetails: [String]?
    let serviceCategories: [String]?
    let serviceSubcategories: [String]?
    let addressDetails: [[String: String?]]?
    let status: String?
    let isDeleted: Bool?
    let firstName, lastName, email, password: String?
    let branchNameEn, branchNameAr, branchTypeID, branchCategoryID: String?
    let branchBrief, phoneNumber: String?
    let contactDetails: IPContactDetails?
    let businessDetails: IPBusinessDetails?
    let serviceDetails: IPServiceDetails?
    let blockExpires, createdAt, updatedAt, city: String?
    let country, state: String?
    let professionalAddress: IPProfessionalAddress?
    let logo: String?
    let orderItemsData: [IPOrderItemsDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case verified
        case emailVerified = "email_verified"
        case loginAttempts
        case noOfBranches = "no_of_branches"
        case certificateAwards = "certificate_awards"
        case cardDetails = "card_details"
        case serviceCategories = "service_categories"
        case serviceSubcategories = "service_subcategories"
        case addressDetails = "address_details"
        case status, isDeleted
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
        case blockExpires, createdAt, updatedAt, city, country, state
        case professionalAddress = "professional_address"
        case logo, orderItemsData
    }
}

// MARK: - BusinessDetails
struct IPBusinessDetails: Codable {
    let issuedInCountries: [String]?
    let noOfEmp: String?
    let branchYear: Int?
    let licenceNumber, branchLicence: String?
    let issuedInCities: [String]?

    enum CodingKeys: String, CodingKey {
        case issuedInCountries = "issued_in_countries"
        case noOfEmp = "no_of_emp"
        case branchYear = "branch_year"
        case licenceNumber = "licence_number"
        case branchLicence = "branch_licence"
        case issuedInCities = "issued_in_cities"
    }
}


// MARK: - ContactDetails
struct IPContactDetails: Codable {
    let businessCountryCode, coOrdinatorArabic, mobileNumber, coOrdinatorEng: String?
    let branchEmail, branchWebsite, countryCode, instaAcc: String?
    let businessMobileNumber, youtubeChannel: String?

    enum CodingKeys: String, CodingKey {
        case businessCountryCode = "business_country_code"
        case coOrdinatorArabic = "co_ordinator_arabic"
        case mobileNumber = "mobile_number"
        case coOrdinatorEng = "co_ordinator_eng"
        case branchEmail = "branch_email"
        case branchWebsite = "branch_website"
        case countryCode = "country_code"
        case instaAcc = "insta_acc"
        case businessMobileNumber = "business_mobile_number"
        case youtubeChannel = "youtube_channel"
    }
}

// MARK: - OrderItemsDatum
struct IPOrderItemsDatum: Codable {
    let id, productQuantity: String?
    let userID: String?
    let professionalID: String?
    let productID, orderID, colorName, colorCode: String?
    let size: Int?
    let sizeUnit, createdAt, updatedAt: String?
    let productDetails: [IPProductDetail]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case productQuantity = "product_quantity"
        case userID = "user_id"
        case professionalID = "professional_id"
        case productID = "product_id"
        case orderID = "order_id"
        case colorName = "color_name"
        case colorCode = "color_code"
        case size
        case sizeUnit = "size_unit"
        case createdAt, updatedAt, productDetails
    }
}

// MARK: - ProductDetail
struct IPProductDetail: Codable {
    let id: String?
    let categoryID: String?
    let professionalID: String?
    let subCategoryID: String?
    let productMedia: [IPProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let quantity: [IPQuantity]?
    let availableSize: [IPAvailableSize]?
    let customsInformation: IPCustomsInformation?
    let inventory: InventoryClass?
    let productTitle, tags: String?
    let weightDetails: IPWeightDetails?
    let availableColor: [IPAvailableColor]?
    let productDescription: String?
    let productDetails: IPProductDetails?
    let pricing: IPPricing?
    let productUniqueID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categoryID = "category_id"
        case professionalID = "professional_id"
        case subCategoryID = "sub_category_id"
        case productMedia = "product_media"
        case shipping, variant
        case visibleToProfessinal = "visible_to_professinal"
        case visibleToCustomer = "visible_to_customer"
        case chargeTax = "charge_tax"
        case totalRating = "total_rating"
        case quantity
        case availableSize = "available_size"
        case customsInformation = "customs_information"
        case inventory
        case productTitle = "product_title"
        case tags
        case weightDetails = "weight_details"
        case availableColor = "available_color"
        case productDescription = "product_description"
        case productDetails = "product_details"
        case pricing
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
    }
}

// MARK: - AvailableColor
struct IPAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct IPAvailableSize: Codable {
    let id: String?
    let size: String?
    let sizeUnit: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
        case sizeUnit = "size_unit"
    }
}




// MARK: - CustomsInformation
struct IPCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - InventoryClass
struct InventoryClass: Codable {
    let inventory: String?
    let sku, barcode: String?
}


// MARK: - Pricing
struct IPPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct IPProductDetails: Codable {
    let productType: String?
    let vendor: String?
    let collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}


// MARK: - ProductMedia
struct IPProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct IPQuantity: Codable {
    let id: String?
    let branchName: String?
    let branchQuantity: Int?
    let branchID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchName = "branch_name"
        case branchQuantity = "branch_quantity"
        case branchID = "branch_id"
    }
}




// MARK: - WeightDetails
struct IPWeightDetails: Codable {
    let weight: String?
    let unit: String?
}


// MARK: - ProfessionalAddress
struct IPProfessionalAddress: Codable {
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

// MARK: - ServiceDetails
struct IPServiceDetails: Codable {
    let serviceCountry, serviceCity: [String]?
    let serviceCost: String?

    enum CodingKeys: String, CodingKey {
        case serviceCountry = "service_country"
        case serviceCity = "service_city"
        case serviceCost = "service_cost"
    }
}



typealias InProgressOrderListModel = [InProgressOrderListModelElement]
