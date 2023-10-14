//
//  LocationCellModel.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 13/10/2023.
//

import Foundation
import SwiftUI

struct LocationCellModel: Identifiable{
    var id: UUID = UUID()
    var type: String
    var info: String
    var color: Color
}
