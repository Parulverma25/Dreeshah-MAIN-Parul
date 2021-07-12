// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productListModel = try? newJSONDecoder().decode(ProductListModel.self, from: jsonData)

import Foundation

// MARK: - ProductListModelElement
struct ProductListModelElement: Codable {
    let id: String?
    let categoryID: String?
    let professionalID: String?
    let subCategoryID: String?
    let productMedia: [ProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let quantity: [PRDQuantity?]
    let availableSize: [AvailableSize]?
    let customsInformation: CustomsInformation?
    let inventory: Inventory?
    let productTitle, tags: String?
    let weightDetails: PRDWeightDetails?
    let availableColor: [AvailableColor]?
    let productDescription: String?
    let productDetails: ProductDetails?
    let pricing: Pricing?
    let productUniqueID, createdAt, updatedAt: String?
    let isWishListProduct: [IsWishListProduct]?

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
        case isWishListProduct = "is_wish_list_product"
    }
}

// MARK: - AvailableColor
struct AvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct AvailableSize: Codable {
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
struct CustomsInformation: Codable {
    let region, code: String?
}

// MARK: - Inventory
struct Inventory: Codable {
    let inventory, sku: String?
    let barcode: String?
}


// MARK: - IsWishListProduct
struct IsWishListProduct: Codable {
    let id: String?
    let status: Bool?
    let userID: String?
    let productID: String?
    let professionalID: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status
        case userID = "user_id"
        case productID = "product_id"
        case professionalID = "professional_id"
        case createdAt, updatedAt
    }
}


// MARK: - Pricing
struct Pricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct ProductDetails: Codable {
    let productType: String?
    let vendor: String?
    let collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}


// MARK: - ProductMedia
struct ProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct PRDQuantity: Codable {
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
struct PRDWeightDetails: Codable {
    let weight: String?
    let unit: String?
}


typealias ProductListModel = [ProductListModelElement]
