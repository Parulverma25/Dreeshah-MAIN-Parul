// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productsProfessionalListing = try? newJSONDecoder().decode(ProductsProfessionalListing.self, from: jsonData)

import Foundation

// MARK: - ProductsProfessionalListing
struct ProductsProfessionalListing: Codable {
    let code: Int?
    let data: [PRDDatum]?
    let count: Int?
}

// MARK: - Datum
struct PRDDatum: Codable {
    let productMedia: [PRDProductMedia]?
    let id, productTitle, productDescription: String?
    let pricing: PRDPricing?
    let datumID: String?

    enum CodingKeys: String, CodingKey {
        case productMedia = "product_media"
        case id = "_id"
        case productTitle = "product_title"
        case productDescription = "product_description"
        case pricing
        case datumID = "id"
    }
}

// MARK: - Pricing
struct PRDPricing: Codable {
    let price, comprice, costPerItem, margin: Int?
    let profit: Int?
}

// MARK: - ProductMedia
struct PRDProductMedia: Codable {
    let name: String?
}
