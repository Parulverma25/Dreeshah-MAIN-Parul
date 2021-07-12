//
//  GetUserDetailsModel.swift
//  Dreesha User
//
//  Created by Promatics on 02/04/21.
//
import Foundation

// MARK: - GetUserDetailsModel
struct GetUserDetailsModel: Codable {
    let userType: String?
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards: [String?]
    let addressDetails: [AddressDetail1]?
    let cardDetails: [String?]
    let status: String?
    let isDeleted: Bool?
    let id, firstName, lastName, country: String?
    let state, email, password: String?
    let otp: Int?
    let phoneNumber, verification, createdAt, updatedAt: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case userType = "user_type"
        case verified
        case emailVerified = "email_verified"
        case noOfBranches = "no_of_branches"
        case certificateAwards = "certificate_awards"
        case addressDetails = "address_details"
        case cardDetails = "card_details"
        case status, isDeleted
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case country, state, email, password, otp
        case phoneNumber = "phone_number"
        case verification, createdAt, updatedAt
        case profileImage = "profile_image"
    }
}

// MARK: - AddressDetail
struct AddressDetail1: Codable {
    let firstName, lastName, addressLine1, addressLine2: String?
    let city, state, zipCode, phoneNumber: String?
    let streetNumber, streetName, area, buildingNumber: String?
    let buildingName, country: String?
    let isDefault: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case city, state
        case zipCode = "zip_code"
        case phoneNumber = "phone_number"
        case streetNumber = "street_number"
        case streetName = "street_name"
        case area
        case buildingNumber = "building_number"
        case buildingName = "building_name"
        case country
        case isDefault = "is_default"
        case id = "_id"
    }
}
