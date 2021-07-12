// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let issuedQuotationDetailModel = try? newJSONDecoder().decode(IssuedQuotationDetailModel.self, from: jsonData)

import Foundation

// MARK: - IssuedQuotationDetailModel
struct IssuedQuotationDetailModel: Codable {
    let status, modifyBy: String?
    let rejectReason: JSONNull?
    let isDeleted: Bool?
    let paymentType: String?
    let id, paymentTerms, vat: String?
    let workSchedule: [WorkSchedule]?
    let sellerTerms, scopeOfWork, title: String?
    let workflow: [Workflow]?
    let offerValidity, customerQuotationID, exclusion: String?
    let quantity, price: Int?
    let totalPrice: Int?
    let warrenty, dreeshahTerms, customerID, professionalID: String?
    let image, createdAt, updatedAt, issuedQuotationDetailModelID: String?

    enum CodingKeys: String, CodingKey {
        case status
        case modifyBy = "modify_by"
        case rejectReason = "reject_reason"
        case isDeleted
        case id = "_id"
        case paymentType = "payment_type"
        case paymentTerms = "payment_terms"
        case vat
        case workSchedule = "work_schedule"
        case sellerTerms = "seller_terms"
        case scopeOfWork = "scope_of_work"
        case title, workflow
        case totalPrice = "total_price"
        case offerValidity = "offer_validity"
        case customerQuotationID = "customer_quotation_id"
        case exclusion, quantity, price, warrenty
        case dreeshahTerms = "dreeshah_terms"
        case customerID = "customer_id"
        case professionalID = "professional_id"
        case image, createdAt, updatedAt
        case issuedQuotationDetailModelID = "id"
    }
}

// MARK: - WorkSchedule
struct WorkSchedule: Codable {
    let id, endDate, workScheduleDescription, startDate: String?
    let module: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case endDate = "end_date"
        case workScheduleDescription = "description"
        case startDate = "start_date"
        case module
    }
}

// MARK: - Workflow
struct Workflow: Codable {
    let data: [WFDatum]?
    let id, title: String?

    enum CodingKeys: String, CodingKey {
        case data
        case id = "_id"
        case title
    }
}

// MARK: - Datum
struct WFDatum: Codable {
    let totalPrice, itemName, datumDescription, quantity: String?
    let price, srNo: String?

    enum CodingKeys: String, CodingKey {
        case totalPrice = "total_Price"
        case itemName
        case datumDescription = "description"
        case quantity, price, srNo
    }
}
