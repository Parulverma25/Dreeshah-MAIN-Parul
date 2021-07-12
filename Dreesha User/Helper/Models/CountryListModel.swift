//
//  CountryListModel.swift
//  Dreesha User
//
//  Created by Promatics on 01/04/21.
//

import Foundation

// MARK: - GetCountryModel
struct GetCountryModel: Codable {
    let code: Int?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let isoCode, name, phonecode, flag: String?
    let currency, latitude, longitude: String?
    let timezones: [Timezone]?
}

// MARK: - Timezone
struct Timezone: Codable {
    let zoneName: String?
    let gmtOffset: Int?
    let gmtOffsetName, abbreviation, tzName: String?
}
