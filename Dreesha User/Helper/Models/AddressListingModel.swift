//
//  AddressListingModel.swift
//  Dreesha User
//
//  Created by Promatics on 06/04/21.
//

import Foundation

// MARK: - AddressListingModel
struct AddressListingModel: Codable {
    let userType: String?
    let verified, emailVerified: Bool?
    let noOfBranches: Int?
    let certificateAwards: [ADCertificateAward?]
    let addressDetails: [AddressDetails?]
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

// MARK: - CertificateAward
struct ADCertificateAward: Codable {
    let image, date: String?
}

// MARK: - AddressDetail
struct AddressDetails: Codable {
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
