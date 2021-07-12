//
//  ServiceListARModel.swift
//  Dreesha User
//
//  Created by promatics on 4/26/21.
//

import Foundation

// MARK: - ServiceList
struct ServiceListAR: Codable {
    var code: Int?
    var data: [Datumss]?
    var totalCounts: Int?

    enum CodingKeys: String, CodingKey {
        case code, data
        case totalCounts = "total_counts"
    }
}

// MARK: - Datum
struct Datumss: Codable {
    var areaCovered,country: [String]?
    var status, id, duration : String?
    var serviceDescription, serviceName: String?
    var price: Double?
    var serviceImage, datumID: String?

    enum CodingKeys: String, CodingKey {
        case areaCovered = "area_covered"
        case status
        case id = "_id"
        case duration, country
        case serviceDescription = "service_description"
        case serviceName = "service_name"
        case price
        case serviceImage = "service_image"
        case datumID = "id"
    }
}

// MARK: - AreaCovered
struct AreaCovered: Codable {
    var city: String?
}
