
import Foundation

// MARK: - OrderManagementProfModelElement
struct OrderManagementProfModelElement: Codable {
    let id: ODID?
    let products, orderID: [String]?
    let orderData: [ODOrderDatum]?
    let userDetails: [UserDetail]?
    let professionalData: [ODProfessionalDatum]?
    let charges: ODCharges?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case products
        case orderID = "order_id"
        case orderData, userDetails, professionalData, charges
    }
}

// MARK: - Charges
struct ODCharges: Codable {
    let id: String?
    let taxPercentage, shippingCharges: Int?
    let createdAt, updatedAt, chargesID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case taxPercentage = "tax_percentage"
        case shippingCharges = "shipping_charges"
        case createdAt, updatedAt
        case chargesID = "id"
    }
}

// MARK: - ID
struct ODID: Codable {
    let orderID, professionalID: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case professionalID = "professional_id"
    }
}

// MARK: - OrderDatum
struct ODOrderDatum: Codable {
    let id, paymentStatus, orderStatus: String?
    let refundStatus: Bool?
    let cancelReason: String?
    let orderHistory: [ODOrderHistory]?
    let userID: String?
    let amount: Int?
    let transactionID, paymentDate, orderNo, orderDate: String?
    let createdAt, updatedAt: String?
    let address: ODAddress?

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

// MARK: - Address
struct ODAddress: Codable {
    let firstName, lastName, addressLine1, addressLine2: String?
    let city, state, zipCode, phoneNumber: String?
    let landmark: String?
    let country, orderID: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city, state
        case zipCode = "zip_code"
        case phoneNumber = "phone_number"
        case landmark, country
        case orderID = "order_id"
    }
}

// MARK: - OrderHistory
struct ODOrderHistory: Codable {
    let state, date: String?
}

// MARK: - ProfessionalDatum
struct ODProfessionalDatum: Codable {
    let id, userType, profileImage, logo: String?
    let verified, emailVerified: Bool?
    let loginAttempts, noOfBranches: Int?
    let certificateAwards: [ODSCertificateAward]?
    let cardDetails: [String]?
    let serviceCategories, serviceSubcategories: [String]?
    let addressDetails: [String]?
    let status: String?
    let isDeleted: Bool?
    let firstName, lastName, email, password: String?
    let branchNameEn, branchNameAr, branchTypeID, branchCategoryID: String?
    let branchBrief, phoneNumber: String?
    let contactDetails: ODContactDetails?
    let businessDetails: ODBusinessDetails?
    let serviceDetails: ODServiceDetails?
    let professionalAddress: ODProfessionalAddress?
    let blockExpires, createdAt, updatedAt, city: String?
    let country, state: String?
    let orderItemsData: [ODOrderItemsDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case logo, verified
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
        case professionalAddress = "professional_address"
        case blockExpires, createdAt, updatedAt, city, country, state, orderItemsData
    }
}

// MARK: - CertificateAward
struct ODSCertificateAward: Codable {
    let image, date: String?
}


// MARK: - BusinessDetails
struct ODBusinessDetails: Codable {
    let issuedInCountries: [String]?
    let branchLicence, noOfEmp: String?
    let branchYear: Int?
    let issuedInCities: [String]?
    let licenceNumber: String?

    enum CodingKeys: String, CodingKey {
        case issuedInCountries = "issued_in_countries"
        case branchLicence = "branch_licence"
        case noOfEmp = "no_of_emp"
        case branchYear = "branch_year"
        case issuedInCities = "issued_in_cities"
        case licenceNumber = "licence_number"
    }
}



// MARK: - ContactDetails
struct ODContactDetails: Codable {
    let branchEmail, countryCode, businessCountryCode, branchWebsite: String?
    let youtubeChannel, mobileNumber, businessMobileNumber, coOrdinatorEng: String?
    let coOrdinatorArabic, instaAcc: String?

    enum CodingKeys: String, CodingKey {
        case branchEmail = "branch_email"
        case countryCode = "country_code"
        case businessCountryCode = "business_country_code"
        case branchWebsite = "branch_website"
        case youtubeChannel = "youtube_channel"
        case mobileNumber = "mobile_number"
        case businessMobileNumber = "business_mobile_number"
        case coOrdinatorEng = "co_ordinator_eng"
        case coOrdinatorArabic = "co_ordinator_arabic"
        case instaAcc = "insta_acc"
    }
}

// MARK: - OrderItemsDatum
struct ODOrderItemsDatum: Codable {
    let id, productQuantity, userID, professionalID: String?
    let productID, orderID, colorName, colorCode: String?
    let size: Int?
    let sizeUnit, createdAt, updatedAt: String?
    let productDetails: [ODProductDetail]?

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
struct ODProductDetail: Codable {
    let id, categoryID, professionalID, subCategoryID: String?
    let productMedia: [ODProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let weightDetails: ODWeightDetails?
    let productTitle: String?
    let availableColor: [ODAvailableColor]?
    let customsInformation: ODCustomsInformation?
    let productDetails: ODProductDetails?
    let pricing: ODPricing?
    let inventory: ODInventory?
    let tags, productDescription: String?
    let availableSize: [ODAvailableSize]?
    let quantity: [ODQuantity]?
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
        case weightDetails = "weight_details"
        case productTitle = "product_title"
        case availableColor = "available_color"
        case customsInformation = "customs_information"
        case productDetails = "product_details"
        case pricing, inventory, tags
        case productDescription = "product_description"
        case availableSize = "available_size"
        case quantity
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
    }
}

// MARK: - AvailableColor
struct ODAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct ODAvailableSize: Codable {
    let id, size: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
    }
}

// MARK: - CustomsInformation
struct ODCustomsInformation: Codable {
    let code, region: String?
}

// MARK: - Inventory
struct ODInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct ODPricing: Codable {
    let comprice, profit, costPerItem, margin: Int?
    let price: Int?
}

// MARK: - ProductDetails
struct ODProductDetails: Codable {
    let vendor, productType, collection: String?

    enum CodingKeys: String, CodingKey {
        case vendor
        case productType = "product_type"
        case collection
    }
}

// MARK: - ProductMedia
struct ODProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct ODQuantity: Codable {
    let id, branchID: String?
    let branchQuantity: Int?
    let branchName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchID = "branch_id"
        case branchQuantity = "branch_quantity"
        case branchName = "branch_name"
    }
}

// MARK: - WeightDetails
struct ODWeightDetails: Codable {
    let weight, unit: String?
}

// MARK: - ProfessionalAddress
struct ODProfessionalAddress: Codable {
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
struct ODServiceDetails: Codable {
    let serviceCountry, serviceCity: [String]?
    let serviceCost: String?

    enum CodingKeys: String, CodingKey {
        case serviceCountry = "service_country"
        case serviceCity = "service_city"
        case serviceCost = "service_cost"
    }
}

// MARK: - UserDetail
struct UserDetail: Codable {
    let id, userType, profileImage: String?
    let logo: String?
    let verified, emailVerified: Bool?
    let loginAttempts, noOfBranches: Int?
    let certificateAwards : [ODSCertificateAward]?
    let cardDetails, serviceCategories, serviceSubcategories: [String]?
    let addressDetails: [ODAddressDetail]?
    let status: String?
    let isDeleted: Bool?
    let firstName, lastName, country, city: String?
    let state, email, password: String?
    let otp: Int?
    let phoneNumber, verification, blockExpires, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case logo, verified
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
        case country, city, state, email, password, otp
        case phoneNumber = "phone_number"
        case verification, blockExpires, createdAt, updatedAt
    }
}

// MARK: - AddressDetail
struct ODAddressDetail: Codable {
    let firstName, lastName, addressLine1, addressLine2: String?
    let city, state, zipCode, phoneNumber: String?
    let landmark, addressType, country, countryPhCode: String?
    let isDefault, id: String?

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

typealias OrderManagementProfModel = [OrderManagementProfModelElement]
