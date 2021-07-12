//
//  ProductDetailsAR.swift
//  Dreesha User
//
//  Created by promatics on 4/23/21.
//

import Foundation

// MARK: - ProductDetails
struct NewProductDetails: Codable {
    var code: Int?
    var details: Details?
}

// MARK: - Details
//struct Details: Codable {
//    var inventory: DetailsInventory?
//    var weightDetails: WeightDetails?
//    var productDetails: ProductDetailsClass?
//    var categoryID: CategoryID?
//    var professionalID: ProfessionalID?
//    var subCategoryID: CategoryID?
//    var productMedia: [ProductMediaAR]?
//    var shipping, variant: String?
//    var visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
//    var totalRating: Int?
//    var id, productUniqueID: String?
//    var quantity: [QuantityAR]?
//    var availableSize: [AvailableSize]?
//    var customsInformation: CustomsInformationAR?
//    var productTitle, tags: String?
//    var availableColor: [AvailableColor]?
//    var productDescription: String?
//    var pricing: PricingAR?
//    var createdAt, updatedAt, detailsID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case inventory
//        case weightDetails = "weight_details"
//        case productDetails = "product_details"
//        case categoryID = "category_id"
//        case professionalID = "professional_id"
//        case subCategoryID = "sub_category_id"
//        case productMedia = "product_media"
//        case shipping, variant
//        case visibleToProfessinal = "visible_to_professinal"
//        case visibleToCustomer = "visible_to_customer"
//        case chargeTax = "charge_tax"
//        case totalRating = "total_rating"
//        case id = "_id"
//        case productUniqueID = "product_unique_id"
//        case quantity
//        case availableSize = "available_size"
//        case customsInformation = "customs_information"
//        case productTitle = "product_title"
//        case tags
//        case availableColor = "available_color"
//        case productDescription = "product_description"
//        case pricing, createdAt, updatedAt
//        case detailsID = "id"
//    }
//}

// MARK: - AvailableColor
//struct AvailableColor: Codable {
//    var id, colorName, colorCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case colorName = "color_name"
//        case colorCode = "color_code"
//    }
//}
//
//// MARK: - AvailableSize
//struct AvailableSize: Codable {
//    var id, size: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case size
//    }
//}
//
//// MARK: - CategoryID
//struct CategoryID: Codable {
//    var status: String?
//    var isDeleted: Bool?
//    var id, name, createdAt, updatedAt: String?
//    var categoryIDID, serviceCategoryID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status, isDeleted
//        case id = "_id"
//        case name, createdAt, updatedAt
//        case categoryIDID = "id"
//        case serviceCategoryID = "service_category_id"
//    }
//}
//
//// MARK: - CustomsInformation
//struct CustomsInformationAR: Codable {
//    var region, code: String?
//}
//
//// MARK: - DetailsInventory
//struct DetailsInventory: Codable {
//    var inventory: InventoryInventory?
//    var sku, barcode: String?
//}
//
//// MARK: - InventoryInventory
//struct InventoryInventory: Codable {
//    var stockKeepingUnit: Int?
//    var barcode, status: String?
//    var isDeleted: Bool?
//    var id, inventoryName, createdAt, updatedAt: String?
//    var inventoryID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case stockKeepingUnit = "stock_keeping_unit"
//        case barcode, status, isDeleted
//        case id = "_id"
//        case inventoryName = "inventory_name"
//        case createdAt, updatedAt
//        case inventoryID = "id"
//    }
//}
//
//// MARK: - Pricing
//struct PricingAR: Codable {
//    var price, comprice, costPerItem, margin: Int?
//    var profit: Int?
//}
//
//// MARK: - ProductDetailsClass
//struct ProductDetailsClass: Codable {
//    var productType: ProductType?
//    var vendor: Vendor?
//    var collection: String?
//
//    enum CodingKeys: String, CodingKey {
//        case productType = "product_type"
//        case vendor, collection
//    }
//}
//
//// MARK: - ProductType
//struct ProductType: Codable {
//    var isDeleted: Bool?
//    var id, productType, createdAt, updatedAt: String?
//    var productTypeID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isDeleted
//        case id = "_id"
//        case productType = "product_type"
//        case createdAt, updatedAt
//        case productTypeID = "id"
//    }
//}
//
//// MARK: - Vendor
//struct Vendor: Codable {
//    var isDeleted: Bool?
//    var id, productTypeID, vendorName, createdAt: String?
//    var updatedAt, vendorID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isDeleted
//        case id = "_id"
//        case productTypeID = "product_type_id"
//        case vendorName = "vendor_name"
//        case createdAt, updatedAt
//        case vendorID = "id"
//    }
//}
//
//// MARK: - ProductMedia
//struct ProductMediaAR: Codable {
//    var name: String?
//}
//
//// MARK: - ProfessionalID
//struct ProfessionalID: Codable {
//    var id, firstName, lastName: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//    }
//}
//
//// MARK: - Quantity
//struct QuantityAR: Codable {
//    var id, branchName: String?
//    var branchQuantity: Int?
//    var branchID: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case branchName = "branch_name"
//        case branchQuantity = "branch_quantity"
//        case branchID = "branch_id"
//    }
//}
//
//// MARK: - WeightDetails
//struct WeightDetails: Codable {
//    var weight, unit: String?
//}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
