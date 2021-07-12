import Foundation

// MARK: - BranchListModelElement
struct BranchListModelElement: Codable{
    let branchImage: [BranchImage]?
    let branchProfile: String?
    let addressDetails: [AddressDetail]?
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, email: String?
    let branchNameEn, branchNameAr: String?
    let branchTypeID, branchCategoryID: BranchID?
    let branchBrief: String?
    let businessDetails: BusinessDetails?
    let contactDetails: ContactDetails?
    let serviceDetails: ServiceDetails?
    let userID, createdAt, updatedAt, password: String?
    
    enum CodingKeys: String, CodingKey {
        case branchImage = "branch_image"
        case branchProfile = "branch_profile"
        case addressDetails = "address_details"
        case status, isDeleted
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case branchNameEn = "branch_name_en"
        case branchNameAr = "branch_name_ar"
        case branchTypeID = "branch_type_id"
        case branchCategoryID = "branch_category_id"
        case branchBrief = "branch_brief"
        case businessDetails = "business_details"
        case contactDetails = "contact_details"
        case serviceDetails = "service_details"
        case userID = "user_id"
        case createdAt, updatedAt, password
    }
    
    
}
    
    // MARK: - BranchID
    struct BranchID: Codable {
        let status: String?
        let isDeleted: Bool?
        let id, name, brandTypeID, createdAt: String?
        let updatedAt, branchIDID: String?
        
        enum CodingKeys: String, CodingKey {
            case status, isDeleted
            case id = "_id"
            case name
            case brandTypeID = "brand_type_id"
            case createdAt, updatedAt
            case branchIDID = "id"
        }
    }

// MARK: - BranchImage
struct BranchImage: Codable {
    let image, date: String?
}

    
    
    typealias BranchListModel = [BranchListModelElement]

