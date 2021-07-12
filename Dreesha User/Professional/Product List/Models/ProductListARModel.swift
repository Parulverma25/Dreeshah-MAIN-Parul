//
//  ProductListARModel.swift
//  Dreesha User
//
//  Created by promatics on 4/22/21.
//

import Foundation

// MARK: - GetAllProducts
struct GetAllProducts: Codable {
    var code: Int?
    var data: [Datums]?
}

// MARK: - Datum
struct Datums: Codable {
    var productMedia: [ProductMedia]?
    var id, productTitle, productDescription: String?
    var pricing: Pricing?
    var datumID: String?

    enum CodingKeys: String, CodingKey {
        case productMedia = "product_media"
        case id = "_id"
        case productTitle = "product_title"
        case productDescription = "product_description"
        case pricing
        case datumID = "id"
    }
}

//// MARK: - Pricing
//struct Pricing: Codable {
//    var price, comprice, costPerItem, margin: Int?
//    var profit: Int?
//}
//
//// MARK: - ProductMedia
//struct ProductMedia: Codable {
//    var name: String?
//}
