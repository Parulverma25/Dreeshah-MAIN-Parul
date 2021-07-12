// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productsDetailModel = try? newJSONDecoder().decode(ProductsDetailModel.self, from: jsonData)

import Foundation

// MARK: - ProductsDetailModel
struct ProductsDetailModel: Codable {
    let code: Int?
    let details: Details?
}

// MARK: - Details
struct Details: Codable {
    let inventory: DetailsInventory?
    let weightDetails: WeightDetails?
    let productDetails: PDProductDetails?
    let categoryID: CategoryID?
    let professionalID: ProfessionalID?
    let subCategoryID: CategoryID?
    let productMedia: [PDProductMedia?]
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id, productUniqueID: String?
    let quantity: [Quantity?]
    let availableSize: [PDAvailableSize?]
    let customsInformation: PDCustomsInformation?
    let productTitle, tags: String?
    let availableColor: [PDAvailableColor?]
    let productDescription: String?
    let pricing: PDPricing?
    let createdAt, updatedAt, detailsID: String?

    enum CodingKeys: String, CodingKey {
        case inventory
        case weightDetails = "weight_details"
        case productDetails = "product_details"
        case categoryID = "category_id"
        case professionalID = "professional_id"
        case subCategoryID = "sub_category_id"
        case productMedia = "product_media"
        case shipping, variant
        case visibleToProfessinal = "visible_to_professinal"
        case visibleToCustomer = "visible_to_customer"
        case chargeTax = "charge_tax"
        case totalRating = "total_rating"
        case id = "_id"
        case productUniqueID = "product_unique_id"
        case quantity
        case availableSize = "available_size"
        case customsInformation = "customs_information"
        case productTitle = "product_title"
        case tags
        case availableColor = "available_color"
        case productDescription = "product_description"
        case pricing, createdAt, updatedAt
        case detailsID = "id"
    }
}

// MARK: - AvailableColor
struct PDAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct PDAvailableSize: Codable {
    let id, size: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
    }
}

// MARK: - CategoryID
struct CategoryID: Codable {
    let status: String?
    let isDeleted: Bool?
    let id, name, createdAt, updatedAt: String?
    let categoryIDID: String?
    let serviceCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
        case id = "_id"
        case name, createdAt, updatedAt
        case categoryIDID = "id"
        case serviceCategoryID = "service_category_id"
    }
}

// MARK: - CustomsInformation
struct PDCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - DetailsInventory
struct DetailsInventory: Codable {
    let inventory: InventoryInventory
    let sku, barcode: String?
}

// MARK: - InventoryInventory
struct InventoryInventory: Codable {
    let stockKeepingUnit: Int?
    let barcode, status: String?
    let isDeleted: Bool?
    let id, inventoryName, createdAt, updatedAt: String?
    let inventoryID: String?

    enum CodingKeys: String, CodingKey {
        case stockKeepingUnit = "stock_keeping_unit"
        case barcode, status, isDeleted
        case id = "_id"
        case inventoryName = "inventory_name"
        case createdAt, updatedAt
        case inventoryID = "id"
    }
}

// MARK: - Pricing
struct PDPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct PDProductDetails: Codable {
    let productType: ProductType?
    let vendor: Vendor?
    let collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}

// MARK: - ProductType
struct ProductType: Codable {
    let isDeleted: Bool?
    let id, productType, createdAt, updatedAt: String?
    let productTypeID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case productType = "product_type"
        case createdAt, updatedAt
        case productTypeID = "id"
    }
}

// MARK: - Vendor
struct Vendor: Codable {
    let isDeleted: Bool?
    let id, productTypeID, vendorName, createdAt: String?
    let updatedAt, vendorID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case productTypeID = "product_type_id"
        case vendorName = "vendor_name"
        case createdAt, updatedAt
        case vendorID = "id"
    }
}

// MARK: - ProductMedia
struct PDProductMedia: Codable {
    let name: String?
}

// MARK: - ProfessionalID
struct ProfessionalID: Codable {
    let profileImage, id, firstName, lastName: String?
     let branchTypeID: String?
     let contactDetails: ProfessionalIDContactDetails?
     let branches: [ProBranch]?
     let professionalIDID: String?

     enum CodingKeys: String, CodingKey {
         case profileImage = "profile_image"
         case id = "_id"
         case firstName = "first_name"
         case lastName = "last_name"
         case branchTypeID = "branch_type_id"
         case contactDetails = "contact_details"
         case branches
         case professionalIDID = "id"
     }
}

// MARK: - Quantity
struct Quantity: Codable {
    let id, branchName: String?
    let branchQuantity: Int?
    let branchID: PDBranchID?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchName = "branch_name"
        case branchQuantity = "branch_quantity"
        case branchID = "branch_id"
    }
}

// MARK: - BranchID
struct PDBranchID: Codable {
    let branchCertificates: [BranchCertificate?]
    let branchProfile: String?
    let addressDetails: [PDAddressDetail?]
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, email: String?
    let password, branchNameEn, branchNameAr, branchTypeID: String?
    let branchCategoryID, branchBrief: String?
    let businessDetails: BusinessDetails?
    let contactDetails: ContactDetails?
    let serviceDetails: ServiceDetails?
    let userID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case branchCertificates = "branch_certificates"
        case branchProfile = "branch_profile"
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
        case userID = "user_id"
        case createdAt, updatedAt
    }
}

// MARK: - AddressDetail
struct PDAddressDetail: Codable {
    let pincode, houseNo, area, landmark: String?
    let state, city: String?

    enum CodingKeys: String, CodingKey {
        case pincode
        case houseNo = "house_no"
        case area, landmark, state, city
    }
}

// MARK: - BranchCertificate
struct BranchCertificate: Codable {
    let image, date: String?
}

// MARK: - BusinessDetails
struct PDBusinessDetails: Codable {
    let branchYear: String?
    let issuedInCountries, issuedInCities: [String?]
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

// MARK: - ContactDetails
struct PDContactDetails: Codable {
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
struct PDServiceDetails: Codable {
    let servicesProducts, serviceCountry, serviceCity: [String?]
    let serviceCost: String?

    enum CodingKeys: String, CodingKey {
        case servicesProducts = "services_products"
        case serviceCountry = "service_country"
        case serviceCity = "service_city"
        case serviceCost = "service_cost"
    }
}

// MARK: - WeightDetails
struct WeightDetails: Codable {
    let weight, unit: String?
}
