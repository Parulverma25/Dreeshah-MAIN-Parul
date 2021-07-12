// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myWishListModel = try? newJSONDecoder().decode(MyWishListModel.self, from: jsonData)

import Foundation

// MARK: - MyWishListModel
struct MyWishListModel: Codable {
    let code: Int?
    let msg: String?
    let data: [MyWishDatum?]
}

// MARK: - Datum
struct MyWishDatum: Codable {
    let status: Bool?
    let id, userID: String?
    let productID: MyWishProductID?
    let professionalID, createdAt, updatedAt, datumID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case userID = "user_id"
        case productID = "product_id"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case datumID = "id"
    }
}

// MARK: - ProductID
struct MyWishProductID: Codable {
    let inventory: MyWishInventory?
    let weightDetails: MyWishWeightDetails?
    let productDetails: MyWishProductDetails?
    let categoryID, professionalID, subCategoryID: String?
    let productMedia: [MyWishProductMedia?]
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id: String?
    let quantity: [MyWishQuantity?]
    let availableSize: [MyWishAvailableSize?]
    let customsInformation: MyWishCustomsInformation?
    let productTitle, tags: String?
    let availableColor: [MyWishAvailableColor?]
    let productDescription: String?
    let pricing: MyWishPricing?
    let createdAt, updatedAt, productIDID: String?

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
        case quantity
        case availableSize = "available_size"
        case customsInformation = "customs_information"
        case productTitle = "product_title"
        case tags
        case availableColor = "available_color"
        case productDescription = "product_description"
        case pricing, createdAt, updatedAt
        case productIDID = "id"
    }
}

// MARK: - AvailableColor
struct MyWishAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct MyWishAvailableSize: Codable {
    let id, size: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
    }
}

// MARK: - CustomsInformation
struct MyWishCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - Inventory
struct MyWishInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct MyWishPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct MyWishProductDetails: Codable {
    let productType, vendor, collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}

// MARK: - ProductMedia
struct MyWishProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct MyWishQuantity: Codable {
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
struct MyWishWeightDetails: Codable {
    let weight, unit: String?
}
