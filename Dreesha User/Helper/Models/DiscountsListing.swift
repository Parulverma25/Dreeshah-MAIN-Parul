// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let discountsListing = try? newJSONDecoder().decode(DiscountsListing.self, from: jsonData)

import Foundation

// MARK: - DiscountsListingElement
struct DiscountsListingElement: Codable {
    let discountApply: DiscountApply?
    let minimumRequirement: MinimumRequirement?
    let usage: Usage?
    let customerEligibility, status: String?
    let isDeleted: Bool?
    let id, discountCoupon, expiryDate, discountValue: String?
    let dateTime, discountType, professionalID, createdAt: String?
    let updatedAt, discountsListingID: String?

    enum CodingKeys: String, CodingKey {
        case discountApply = "discount_apply"
        case minimumRequirement = "minimum_requirement"
        case usage
        case customerEligibility = "customer_eligibility"
        case status, isDeleted
        case id = "_id"
        case discountCoupon = "discount_coupon"
        case expiryDate = "expiry_date"
        case discountValue = "discount_value"
        case dateTime = "date_time"
        case discountType = "discount_type"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case discountsListingID = "id"
    }
}

// MARK: - DiscountApply
struct DiscountApply: Codable {
    let to: String?
    let productID: DisProductID?

    enum CodingKeys: String, CodingKey {
        case to
        case productID = "product_id"
    }
}

// MARK: - ProductID
struct DisProductID: Codable {
    let inventory: DisInventory?
    let weightDetails: DisWeightDetails?
    let productDetails: DisProductDetails?
    let categoryID, professionalID, subCategoryID: String?
    let productMedia: [DisProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id: String?
    let pricing: DisPricing?
    let customsInformation: DisCustomsInformation?
    let tags: String?
    let availableColor: [DisAvailableColor?]
    let productTitle: String?
    let quantity: [DisQuantity?]
    let productDescription: String?
    let availableSize: [DisAvailableSize?]
    let productUniqueID, createdAt, updatedAt, productIDID: String?

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
        case pricing
        case customsInformation = "customs_information"
        case tags
        case availableColor = "available_color"
        case productTitle = "product_title"
        case quantity
        case productDescription = "product_description"
        case availableSize = "available_size"
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
        case productIDID = "id"
    }
}

// MARK: - AvailableColor
struct DisAvailableColor: Codable {
    let id, colorCode, colorName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorCode = "color_code"
        case colorName = "color_name"
    }
}

// MARK: - AvailableSize
struct DisAvailableSize: Codable {
    let id, size, sizeUnit: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
        case sizeUnit = "size_unit"
    }
}

// MARK: - CustomsInformation
struct DisCustomsInformation: Codable {
    let code, region: String?
}

// MARK: - Inventory
struct DisInventory: Codable {
    let sku, inventory, barcode: String?
}

// MARK: - Pricing
struct DisPricing: Codable {
    let comprice, margin, costPerItem, price: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct DisProductDetails: Codable {
    let vendor, productType, collection: String?

    enum CodingKeys: String, CodingKey {
        case vendor
        case productType = "product_type"
        case collection
    }
}

// MARK: - ProductMedia
struct DisProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct DisQuantity: Codable {
    let id, branchName: String?
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
struct DisWeightDetails: Codable {
    let weight, unit: String?
}

// MARK: - MinimumRequirement
struct MinimumRequirement: Codable {
    let requirement: String?
    let value: Int?
}

// MARK: - Usage
struct Usage: Codable {
    let usageType: String?
    let usageValue: Int?

    enum CodingKeys: String, CodingKey {
        case usageType = "usage_type"
        case usageValue = "usage_value"
    }
}

typealias DiscountsListing = [DiscountsListingElement]
