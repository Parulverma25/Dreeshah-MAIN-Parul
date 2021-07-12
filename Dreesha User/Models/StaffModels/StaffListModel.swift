// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let staffListModel = try? newJSONDecoder().decode(StaffListModel.self, from: jsonData)

import Foundation

// MARK: - StaffListModelElement
struct StaffListModelElement: Codable {
    let id, fullName, email, countryCode: String?
    let phoneNumber: String?
    let branchID: SLBranchID?
    let professionalID, createdAt, updatedAt: String?
    let staffPrivilege: StaffPrivilege?
    let staffListModelID: String?
    let designation: Designation?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case fullName = "full_name"
        case email
        case countryCode = "country_code"
        case phoneNumber = "phone_number"
        case branchID = "branch_id"
        case professionalID = "professional_id"
        case createdAt, updatedAt
        case staffPrivilege = "Staff_Privilege"
        case staffListModelID = "id"
        case designation
    }
}

// MARK: - Designation
struct Designation: Codable {
    let id, name, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
    }
}

// MARK: - BranchID
struct SLBranchID: Codable {
    let id, branchNameAr, branchNameEn: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchNameAr = "branch_name_ar"
        case branchNameEn = "branch_name_en"
    }
}
// MARK: - StaffPrivilege
struct StaffPrivilege: Codable {
    let professionalID, id, staffID: String?
    let privilege: [Privilege]?
    let createdAt, updatedAt, staffPrivilegeID: String?

    enum CodingKeys: String, CodingKey {
        case professionalID = "professional_id"
        case id = "_id"
        case staffID = "staff_id"
        case privilege, createdAt, updatedAt
        case staffPrivilegeID = "id"
    }
}

// MARK: - Privilege
struct Privilege: Codable {
    let readPermission, writePermission: Bool?
    let id: String?
    let privilegeID: PrivilegeID?

    enum CodingKeys: String, CodingKey {
        case readPermission = "read_permission"
        case writePermission = "write_permission"
        case id = "_id"
        case privilegeID = "privilege_id"
    }
}

// MARK: - PrivilegeID
struct PrivilegeID: Codable {
    let status, id, name, createdAt: String?
    let updatedAt, privilegeIDID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case name, createdAt, updatedAt
        case privilegeIDID = "id"
    }
}

typealias StaffListModel = [StaffListModelElement]


