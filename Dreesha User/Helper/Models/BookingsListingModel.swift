// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bookingsListingModel = try? newJSONDecoder().decode(BookingsListingModel.self, from: jsonData)

import Foundation

// MARK: - BookingsListingModel
struct BookingsListingModel: Codable {
    let code: Int?
    let message: String?
    let result: [BookingsResult?]
    let totalBookings: Int?

    enum CodingKeys: String, CodingKey {
        case code, message, result
        case totalBookings = "total_bookings"
    }
}

// MARK: - Result
struct BookingsResult: Codable {
    let status, id: String?
    let requestID: Int?
    let serviceID: BookingsServiceID?
    let name, subject, location, requestDetails: String?
    let userID : ID?
    let time, date, createdAt: String?
    let updatedAt, resultID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case requestID = "request_id"
        case serviceID = "service_id"
        case name, subject, location
        case requestDetails = "request_details"
        case time, date
        case userID = "user_id"
        case createdAt, updatedAt
        case resultID = "id"
    }
}


// MARK: - ID
struct ID: Codable {
    let profileImage: String?
    let id: String?
    let firstName: String?
    let lastName: String?
    let contactDetails: ContactDetails?

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case contactDetails = "contact_details"
    }
}

// MARK: - ServiceID
struct BookingsServiceID: Codable {
    let areaCovered: [BookingsAreaCovered?]
    let relatedImages, otherImages: [BookingsImage?]
    let serviceVisibleCustomer, serviceVisibleProfessional: Bool?
    let status: String?
    let isDeleted: Bool?
    let id, duration, country, serviceDescription: String?
    let serviceSubCategory, serviceName: String?
    let price: Double?
    let serviceCategory: String?
    let serviceProject: [BookingsServiceProject?]
    let professionalID: BookingsProfessionalID?
    let serviceImage, createdAt, updatedAt, serviceIDID: String?

    enum CodingKeys: String, CodingKey {
        case areaCovered = "area_covered"
        case relatedImages = "related_images"
        case otherImages = "other_images"
        case serviceVisibleCustomer = "service_visible_customer"
        case serviceVisibleProfessional = "service_visible_professional"
        case status, isDeleted
        case id = "_id"
        case duration, country
        case serviceDescription = "service_description"
        case serviceSubCategory = "service_sub_category"
        case serviceName = "service_name"
        case price
        case serviceCategory = "service_category"
        case serviceProject = "service_project"
        case professionalID = "professional_id"
        case serviceImage = "service_image"
        case createdAt, updatedAt
        case serviceIDID = "id"
    }
}

// MARK: - AreaCovered
struct BookingsAreaCovered: Codable {
    let city: String?
}

// MARK: - Image
struct BookingsImage: Codable {
    let name: String?
}



// MARK: - ProfessionalID
struct BookingsProfessionalID: Codable {
    let profileImage, id, firstName, lastName: String?
    let contactDetails: BookingsContactDetails?

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case id = "_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case contactDetails = "contact_details"
    }
}

// MARK: - ContactDetails
struct BookingsContactDetails: Codable {
    let mobileNumber, businessMobileNumber: String?

    enum CodingKeys: String, CodingKey {
        case mobileNumber = "mobile_number"
        case businessMobileNumber = "business_mobile_number"
    }
}

// MARK: - ServiceProject
struct BookingsServiceProject: Codable {
    let id, projectID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case projectID = "project_id"
    }
}
