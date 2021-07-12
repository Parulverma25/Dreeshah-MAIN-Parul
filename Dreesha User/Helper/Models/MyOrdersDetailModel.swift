
import Foundation

// MARK: - MyOrdersDetailModel
struct MyOrdersDetailModel: Codable {
    let code: Int?
    let result: ORResult?
}

// MARK: - Result
struct ORResult: Codable {
    let orderStatus: String?
    let productQuantity: String?
    let refundStatus: Bool?
    let cancelReason: String?
    let id: String?
    let userID: ORUserID?
    let productID: ORProductID?
    let orderID: OrderID?
    let colorName, colorCode: String?
    let size: Int?
    let sizeUnit, orderNo, orderDate, createdAt: String?
    let updatedAt, resultID: String?

    enum CodingKeys: String, CodingKey {
        case productQuantity = "product_quantity"
        case orderStatus = "order_status"
        case refundStatus = "refund_status"
        case cancelReason = "cancel_reason"
        case id = "_id"
        case userID = "user_id"
        case productID = "product_id"
        case orderID = "order_id"
        case colorName = "color_name"
        case colorCode = "color_code"
        case size
        case sizeUnit = "size_unit"
        case orderNo = "order_no"
        case orderDate = "order_date"
        case createdAt, updatedAt
        case resultID = "id"
    }
}

// MARK: - OrderID
struct OrderID: Codable {
    let paymentStatus, id, userID: String?
    let amount: Int?
    let transactionID, paymentDate, createdAt, updatedAt: String?
    let address: [String : String?]?
    let orderIDID: String?

    enum CodingKeys: String, CodingKey {
        case paymentStatus = "payment_status"
        case id = "_id"
        case userID = "user_id"
        case amount
        case transactionID = "transaction_id"
        case paymentDate = "payment_date"
        case createdAt, updatedAt, address
        case orderIDID = "id"
    }
}

// MARK: - ProductID
struct ORProductID: Codable {
    let inventory: ORInventory?
    let weightDetails: ORWeightDetails?
    let productDetails: ORProductDetails?
    let categoryID, professionalID, subCategoryID: String?
    let productMedia: [ORProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let id, tags: String?
    let availableSize: [ORAvailableSize]?
    let availableColor: [ORAvailableColor]?
    let customsInformation: ORCustomsInformation?
    let productTitle: String?
    let pricing: ORPricing?
    let productDescription: String?
    let quantity: [ORQuantity]?
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
        case tags
        case availableSize = "available_size"
        case availableColor = "available_color"
        case customsInformation = "customs_information"
        case productTitle = "product_title"
        case pricing
        case productDescription = "product_description"
        case quantity
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
        case productIDID = "id"
    }
}

// MARK: - AvailableColor
struct ORAvailableColor: Codable {
    let id, colorName, colorCode: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case colorName = "color_name"
        case colorCode = "color_code"
    }
}

// MARK: - AvailableSize
struct ORAvailableSize: Codable {
    let id, size, sizeUnit: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
        case sizeUnit = "size_unit"
    }
}

// MARK: - CustomsInformation
struct ORCustomsInformation: Codable {
    let region, code: String?
}

// MARK: - Inventory
struct ORInventory: Codable {
    let inventory, sku, barcode: String?
}

// MARK: - Pricing
struct ORPricing: Codable {
    let costPerItem, margin, profit, price: Int?
    let comprice: Int?
}

// MARK: - ProductDetails
struct ORProductDetails: Codable {
    let productType, vendor, collection: String?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case vendor, collection
    }
}

// MARK: - ProductMedia
struct ORProductMedia: Codable {
    let name: String?
}

// MARK: - Quantity
struct ORQuantity: Codable {
    let id, branchID, branchName: String?
    let branchQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchID = "branch_id"
        case branchName = "branch_name"
        case branchQuantity = "branch_quantity"
    }
}

// MARK: - WeightDetails
struct ORWeightDetails: Codable {
    let weight, unit: String?
}

// MARK: - UserID
struct ORUserID: Codable {
    let userType, profileImage: String?
    let logo: String?
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards : [CertificateAward]?
    let cardDetails, serviceCategories, serviceSubcategories: [String]?
    let addressDetails: [[String: String?]]?
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, country: String?
    let state, email, password: String?
    let otp: Int?
    let phoneNumber, verification, createdAt, updatedAt: String?
    let userIDID: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case profileImage = "profile_image"
        case logo, verified
        case emailVerified = "email_verified"
        case noOfBranches = "no_of_branches"
        case certificateAwards = "certificate_awards"
        case cardDetails = "card_details"
        case serviceCategories = "service_categories"
        case serviceSubcategories = "service_subcategories"
        case addressDetails = "address_details"
        case status, isDeleted
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case country, state, email, password, otp
        case phoneNumber = "phone_number"
        case verification, createdAt, updatedAt
        case userIDID = "id"
    }
}
