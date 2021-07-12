// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let quotationDetailsModel = try? newJSONDecoder().decode(QuotationDetailsModel.self, from: jsonData)

import Foundation

// MARK: - QuotationDetailsModel
struct QuotationDetailsModel: Codable {
    let code: Int?
    let details: QuotDetails?
}

// MARK: - Details
struct QuotDetails: Codable {
    let status: String?
    let isDeleted: Bool?
    let id: String?
    let professionalServiceID: QuotProfessionalServiceID?
    let professionalID, name, email, phoneNumber: String?
    let quotationRef, date, time, salesRepresentative: String?
    let serviceName, location, quantity, expectedDate: String?
    let estimatedBudget, detailsDescription, quotationNo, subject: String?
    let customerID, createdAt, updatedAt, detailsID: String?

    enum CodingKeys: String, CodingKey {
        case status, isDeleted
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
        case detailsDescription = "description"
        case quotationNo = "quotation_no"
        case subject
        case customerID = "customer_id"
        case createdAt, updatedAt
        case detailsID = "id"
    }
}

// MARK: - ProfessionalServiceID
struct QuotProfessionalServiceID: Codable {
    let otherImages: [QuotOtherImage?]
    let id, serviceImage, professionalServiceIDID: String?

    enum CodingKeys: String, CodingKey {
        case otherImages = "other_images"
        case id = "_id"
        case serviceImage = "service_image"
        case professionalServiceIDID = "id"
    }
}

// MARK: - OtherImage
struct QuotOtherImage: Codable {
    let name: String?
}
