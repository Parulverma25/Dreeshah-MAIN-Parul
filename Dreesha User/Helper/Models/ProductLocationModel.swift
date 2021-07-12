// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productLocationModel = try? newJSONDecoder().decode(ProductLocationModel.self, from: jsonData)

import Foundation

// MARK: - ProductLocationModel
struct ProductLocationModel: Codable {
    let code: Int?
    let message: String?
    let result: [LocResult]?
}

// MARK: - Result
struct LocResult: Codable {
    let id, branchNameEn, branchNameAr: String?
    let branchAddress: LocBranchAddress?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case branchNameEn = "branch_name_en"
        case branchNameAr = "branch_name_ar"
        case branchAddress = "branch_address"
    }
}

// MARK: - BranchAddress
struct LocBranchAddress: Codable {
    let country, state, phoneNumber, countryPhCode: String?
    let addressLine1, addressLine2, addrFirstName, addrLastName: String?
    let city: String?
    let pincode: Int?
    let landmark: String?

    enum CodingKeys: String, CodingKey {
        case country, state
        case phoneNumber = "phone_number"
        case countryPhCode = "country_ph_code"
        case addressLine1 = "address_line_1"
        case addressLine2 = "address_line_2"
        case addrFirstName = "addr_first_name"
        case addrLastName = "addr_last_name"
        case city, pincode, landmark
    }
}
