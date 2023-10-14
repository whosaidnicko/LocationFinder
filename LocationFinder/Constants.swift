//
//  Constants.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 08/10/2023.
//

import Foundation
import SwiftUI

struct Constants {
    static let fontName: FontName = FontName()
    static let locationDetails: LocationDetails = LocationDetails()
}


struct FontName {
     public var regular: String = "PixelifySans-Regular"
     public var semiBold: String = "PixelifySans-SemiBold"
     public var pixRegular: String = "PixelifySans-SemiBold"
}

struct LocationDetails {
    public var country: String = "Country"
    public var city: String = "City"
    public var timeZone: String = "Time Zone"
    public var latitude: String = "Latitude"
    public var longitude: String = "Longitude"
    public var ip: String = "IP"
    public var distance: String = "Distance from your IP"
}

