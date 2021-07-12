//
//  GetCityModel.swift
//  Dreesha User
//
//  Created by Promatics on 01/04/21.
//

import Foundation

// MARK: - GetCityModel
struct GetCityModel: Codable {
    let code: Int?
    let data: [Datum1]?
}

// MARK: - Datum
struct Datum1: Codable {
    let name, isoCode: String?
    let countryCode: String?
    let latitude, longitude: String?
}

