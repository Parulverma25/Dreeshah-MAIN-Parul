// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let myCartModel = try? newJSONDecoder().decode(MyCartModel.self, from: jsonData)

import Foundation

// MARK: - MyCartModelElement
struct MyCartModelElement: Codable {
    let id: String?
    let products: [String]?
    let professionalData: CartProfessionalData?
    let charges: Charges?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case products
        case professionalData = "ProfessionalData"
        case charges
    }
}

// MARK: - Charges
struct Charges: Codable {
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

// MARK: - ProfessionalData
struct CartProfessionalData: Codable {
    let id, userType, firstName, lastName: String?
    let email: String?
    let productData: [ProductDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userType = "user_type"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case productData = "ProductData"
    }
}

// MARK: - ProductDatum
struct ProductDatum: Codable {
    let id, professionalID: String?
    let productMedia: [CartProductMedia]?
    let quantity: [CartQuantity]?
    let inventory: CartInventory?
    let productTitle: String?
    let pricing: CartPricing?
    let productUniqueID: String?
    let cartData: CartData?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case professionalID = "professional_id"
        case productMedia = "product_media"
        case quantity, inventory
        case productTitle = "product_title"
        case pricing
        case productUniqueID = "product_unique_id"
        case cartData
    }
}

// MARK: - CartData
struct CartData: Codable {
    let id: String?
    let quantity: Int?
    let professionalID: String?
    let size: Int?
    let productID, colorCode, colorName, sizeUnit: String?
    let cartID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case quantity
        case professionalID = "professional_id"
        case size
        case productID = "product_id"
        case colorCode = "color_code"
        case colorName = "color_name"
        case sizeUnit = "size_unit"
        case cartID = "cart_id"
        case createdAt, updatedAt
    }
}

// MARK: - Inventory
struct CartInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct CartPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductMedia
struct CartProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct CartQuantity: Codable {
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

typealias MyCartModel = [MyCartModelElement]
