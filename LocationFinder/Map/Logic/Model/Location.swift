//
//  UserLocation.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 07/10/2023.
//

struct Location: Decodable, Encodable {
    let ipVersion: Int
    let ipAddress: String
    let countryName: String
    let countryCode: String
    let cityName: String
    let timeZone: String
    let latitude: Double
    let longitude: Double
    let regionName: String
    let zipCode: String
}


