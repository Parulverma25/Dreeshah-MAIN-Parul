// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let issuedQuotationDetailModel = try? newJSONDecoder().decode(IssuedQuotationDetailModel.self, from: jsonData)

import Foundation

// MARK: - IssuedQuotationDetailModel
struct DefaultaddressModel: Codable {
    let code: Int?
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let addressDetails: [DefaultAddressDetail]?
    let id, resultID: String?

    enum CodingKeys: String, CodingKey {
        case addressDetails = "address_details"
        case id = "_id"
        case resultID = "id"
    }
}

// MARK: - AddressDetail
struct DefaultAddressDetail: Codable {
    let firstName, lastName, addressLine1, addressLine2: String?
    let city, state, zipCode, phoneNumber: String?
    let landmark, addressType, country, countryPhCode: String?
    let isDefault, id: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city, state
        case zipCode = "zip_code"
        case phoneNumber = "phone_number"
        case landmark
        case addressType = "address_type"
        case country
        case countryPhCode = "country_ph_code"
        case isDefault = "is_default"
        case id = "_id"
    }
}
