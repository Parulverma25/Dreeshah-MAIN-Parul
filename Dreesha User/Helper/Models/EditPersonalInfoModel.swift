//
//  EditPersonalInfoModel.swift
//  Dreesha User
//
//  Created by Promatics on 02/04/21.
//

import Foundation

// MARK: - EditPersonalInfoModel
struct EditPersonalInfoModel: Codable {
    let userType: String
    let verified, emailVerified: Bool
    let noOfBranches: Int
    let certificateAwards, addressDetails, cardDetails: [String]
    let status: String
    let isDeleted: Bool
    let id, firstName, lastName, country: String
    let email, password: String
    let otp: Int
    let phoneNumber, verification, createdAt, updatedAt: String
    let profileImage: String

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
        case country, email, password, otp
        case phoneNumber = "phone_number"
        case verification, createdAt, updatedAt
        case profileImage = "profile_image"
    }
}
