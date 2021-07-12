//
//  ClctnProductModel.swift
//  Dreesha User
//
//  Created by Promatics on 18/06/21.
//

import Foundation

// MARK: - ClctnProductModelElement
struct ClctnProductModelElement: Codable {
    
    let isDeleted: Bool?
    let id: String?
    let productID: CLProductID?
    let collectionID, createdAt, updatedAt, collectionsProductLisitingModelID: String?

    enum CodingKeys: String, CodingKey {
        case isDeleted
        case id = "_id"
        case productID = "product_id"
        case collectionID = "collection_id"
        case createdAt, updatedAt
        case collectionsProductLisitingModelID = "id"
    }
}

// MARK: - ProductID
struct CLProductID: Codable {
    let inventory: CLInventory?
    let weightDetails: CLWeightDetails?
    let productDetails: CLProductDetails?
    let categoryID, professionalID, subCategoryID: String?
    let productMedia: [CLProductMedia?]
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id: String?
    let customsInformation: CLCustomsInformation?
    let availableColor: [CLAvailableColor?]
    let tags, productTitle: String?
    let availableSize: [CLAvailableSize?]
    let quantity: [CLQuantity?]
    let productDescription: String?
    let pricing: CLPricing?
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
        case customsInformation = "customs_information"
        case availableColor = "available_color"
        case tags
        case productTitle = "product_title"
        case availableSize = "available_size"
        case quantity
        case productDescription = "product_description"
        case pricing
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
        case productIDID = "id"
    }
}

// MARK: - AvailableColor
struct CLAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct CLAvailableSize: Codable {
    let id, size, sizeUnit: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
        case sizeUnit = "size_unit"
    }
}

// MARK: - CustomsInformation
struct CLCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - Inventory
struct CLInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct CLPricing: Codable {
    let price, comprice, margin, profit: Int?
    let costPerItem: Int?
}

// MARK: - ProductDetails
struct CLProductDetails: Codable {
    let collection: String?
    let vendor, productType: String?

    enum CodingKeys: String, CodingKey {
        case collection, vendor
        case productType = "product_type"
    }
}

// MARK: - ProductMedia
struct CLProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct CLQuantity: Codable {
    let id: String?
    let branchID: String?
    let branchName: String?
    let branchQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchID = "branch_id"
        case branchName = "branch_name"
        case branchQuantity = "branch_quantity"
    }
}


// MARK: - WeightDetails
struct CLWeightDetails: Codable {
    let unit, weight: String?
}


typealias ClctnProductModel = [ClctnProductModelElement]
