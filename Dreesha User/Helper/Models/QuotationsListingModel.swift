// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quotationsListingModel = try? newJSONDecoder().decode(QuotationsListingModel.self, from: jsonData)

import Foundation

// MARK: - QuotationsListingModelElement
struct QuotationsListingModelElement: Codable {
    let status , rejectReason: String?
    let isDeleted: Bool?
    let id: String?
    let professionalServiceID: QtProfessionalServiceID?
    let professionalID, name, email, phoneNumber: String?
    let quotationRef, date, time, salesRepresentative: String?
    let serviceName, location, quantity, expectedDate: String?
    let estimatedBudget, quotationsListingModelDescription, quotationNo, subject: String?
    let customerID, createdAt, updatedAt, quotationsListingModelID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case rejectReason = "reject_reason"
        case isDeleted
        case id = "_id"
        case professionalServiceID = "professional_service_id"
        case professionalID = "professional_id"
        case name, email
        case phoneNumber = "phone_number"
        case quotationRef = "quotation_ref"
        case date, time
        case salesRepresentative = "sales_representative"
        case serviceName = "service_name"
        case location, quantity
        case expectedDate = "expected_date"
        case estimatedBudget = "estimated_budget"
        case quotationsListingModelDescription = "description"
        case quotationNo = "quotation_no"
        case subject
        case customerID = "customer_id"
        case createdAt, updatedAt
        case quotationsListingModelID = "id"
    }
}

// MARK: - ProfessionalServiceID
struct QtProfessionalServiceID: Codable {
    let otherImages: [QtOtherImage?]
    let id, serviceImage, professionalServiceIDID: String?

    enum CodingKeys: String, CodingKey {
        case otherImages = "other_images"
        case id = "_id"
        case serviceImage = "service_image"
        case professionalServiceIDID = "id"
    }
}

// MARK: - OtherImage
struct QtOtherImage: Codable {
    let name: String?
}

typealias QuotationsListingModel = [QuotationsListingModelElement]
