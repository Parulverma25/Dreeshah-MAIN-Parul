
import Foundation

// MARK: - InProgressOrderListModel
struct DelieveredOrderListModel: Codable {
    let code: Int?
    let result: [DelieveredOrderResult?]
}

// MARK: - Result
struct DelieveredOrderResult: Codable {
    let productQuantity, orderStatus: String?
    let cancelReason: String?
    let id, userID: String?
    let productID: DelieveredOrderProductID?
    let orderID, createdAt, updatedAt, resultID: String?

    enum CodingKeys: String, CodingKey {
        case productQuantity = "product_quantity"
        case orderStatus = "order_status"
        case cancelReason = "cancel_reason"
        case id = "_id"
        case userID = "user_id"
        case productID = "product_id"
        case orderID = "order_id"
        case createdAt, updatedAt
        case resultID = "id"
    }
}

// MARK: - ProductID
struct DelieveredOrderProductID: Codable {
    let inventory: DelieverdOrderInventory?
    let weightDetails: DelieverdOrderWeightDetails?
    let productDetails: DelieverdOrderProductDetails?
    let categoryID, professionalID, subCategoryID: String?
    let productMedia: [DelieverdOrderProductMedia?]
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id: String?
    let quantity: [DelieverdOrderQuantity?]
    let availableSize: [DelieverdOrderAvailableSize?]
    let customsInformation: DelieverdOrderCustomsInformation?
    let productTitle, tags: String?
    let availableColor: [DelieverdOrderAvailableColor?]
    let productDescription: String?
    let pricing: DelieverdOrderPricing?
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
struct DelieverdOrderAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct DelieverdOrderAvailableSize: Codable {
    let id, size: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
    }
}

// MARK: - CustomsInformation
struct DelieverdOrderCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - Inventory
struct DelieverdOrderInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct DelieverdOrderPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductDetails
struct DelieverdOrderProductDetails: Codable {
    let productType, vendor, collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}

// MARK: - ProductMedia
struct DelieverdOrderProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct DelieverdOrderQuantity: Codable {
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
struct DelieverdOrderWeightDetails: Codable {
    let weight, unit: String?
}
