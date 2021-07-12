
import Foundation

// MARK: - CancellOrderListModelElement
struct CancellOrderListModelElement: Codable {
    let id: IDClass
    let products, orderID: [String]
    let orderData: [OrderDatum]
    let professionalData: [ProfessionalDatum]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case products
        case orderID = "order_id"
        case orderData, professionalData
    }
}

// MARK: - IDClass
struct IDClass: Codable {
    let orderID, professionalID: String

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case professionalID = "professional_id"
    }
}

// MARK: - OrderDatum
struct OrderDatum: Codable {
    let id, paymentStatus, orderStatus: String
    let refundStatus: Bool
    let cancelReason: JSONNull?
    let orderHistory: [OrderHistory]
    let userID: String
    let amount: Int
    let transactionID, paymentDate, orderNo, orderDate: String
    let createdAt, updatedAt: String
    let address: [String: String?]

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

// MARK: - OrderHistory
struct OrderHistory: Codable {
    let state, date: String
}

// MARK: - ProfessionalDatum
struct ProfessionalDatum: Codable {
    let id, userType, profileImage: String?
    let verified, emailVerified: Bool?
    let loginAttempts, noOfBranches: Int?
    let certificateAwards: [CertificateAward]?
    let cardDetails: [String]?
    let serviceCategories, serviceSubcategories: [String]?
    let addressDetails: [[String: String?]]?
    let status: String?
    let isDeleted: Bool?
    let firstName, lastName, email, password: String?
    let branchNameEn, branchNameAr, branchTypeID, branchCategoryID: String?
    let branchBrief, phoneNumber: String?
    let contactDetails: ContactDetails?
    let businessDetails: BusinessDetails?
    let serviceDetails: ServiceDetails?
    let blockExpires, createdAt, updatedAt, city: String?
    let country, state: String?
    let professionalAddress: ProfessionalAddress?
    let logo: String?
    let orderItemsData: [OrderItemsDatum]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case verified
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
        case blockExpires, createdAt, updatedAt, city, country, state
        case professionalAddress = "professional_address"
        case logo, orderItemsData
    }
}


// MARK: - OrderItemsDatum
struct OrderItemsDatum: Codable {
    let id, productQuantity, userID, professionalID: String?
    let productID, orderID, colorName, colorCode: String?
    let size: Int?
    let sizeUnit, createdAt, updatedAt: String?
    let productDetails: [ProductDetail]?

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
struct ProductDetail: Codable {
    let id, categoryID, professionalID, subCategoryID: String?
    let productMedia: [ProductMedia]?
    let shipping, variant: String?
    let visibleToProfessinal, visibleToCustomer, chargeTax: Bool?
    let totalRating: Int?
    let tags: String?
    let customsInformation: CustomsInformation?
    let quantity: [Quantity]?
    let availableColor: [AvailableColor]?
    let productTitle, productDescription: String?
    let weightDetails: WeightDetails?
    let productDetails: ProductDetails?
    let availableSize: [AvailableSize]?
    let pricing: Pricing?
    let inventory: Inventory?
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
        case tags
        case customsInformation = "customs_information"
        case quantity
        case availableColor = "available_color"
        case productTitle = "product_title"
        case productDescription = "product_description"
        case weightDetails = "weight_details"
        case productDetails = "product_details"
        case availableSize = "available_size"
        case pricing, inventory
        case productUniqueID = "product_unique_id"
        case createdAt, updatedAt
    }
}



typealias CancellOrderListModel = [CancellOrderListModelElement]
