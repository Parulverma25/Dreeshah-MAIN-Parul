// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let proffQuoutationListingModel = try? newJSONDecoder().decode(ProffQuoutationListingModel.self, from: jsonData)

import Foundation

// MARK: - ProffQuoutationListingModelElement
struct ProffQuoutationListingModelElement: Codable {
    let status,rejectReason: String?
    let isDeleted: Bool?
    let id: String?
    let professionalServiceID: ProfessionalServiceID?
    let professionalID: String?
    let name: String?
    let email: String?
    let phoneNumber, quotationRef: String?
    let date: String?
    let salesRepresentative: String?
    let serviceName: String?
    let location: String?
    let quantity, expectedDate, estimatedBudget, proffQuoutationListingModelDescription: String?
    let quotationNo: String?
    let subject: String?
    let customerID: String?
    let createdAt, updatedAt, proffQuoutationListingModelID: String?
    let time: String?

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
        case date
        case salesRepresentative = "sales_representative"
        case serviceName = "service_name"
        case location, quantity
        case expectedDate = "expected_date"
        case estimatedBudget = "estimated_budget"
        case proffQuoutationListingModelDescription = "description"
        case quotationNo = "quotation_no"
        case subject
        case customerID = "customer_id"
        case createdAt, updatedAt
        case proffQuoutationListingModelID = "id"
        case time
    }
}




// MARK: - ProfessionalServiceID
struct ProfessionalServiceID: Codable {
    let otherImages: [ProffOtherImage?]
    let id: String?
    let serviceImage: String?
    let professionalServiceIDID: String?

    enum CodingKeys: String, CodingKey {
        case otherImages = "other_images"
        case id = "_id"
        case serviceImage = "service_image"
        case professionalServiceIDID = "id"
    }
}



// MARK: - OtherImage
struct ProffOtherImage: Codable {
    let name: String?
}




typealias ProffQuoutationListingModel = [ProffQuoutationListingModelElement]
