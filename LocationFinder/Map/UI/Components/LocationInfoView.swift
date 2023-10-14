//
//  LocationInfoView.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 11/10/2023.
//

import Foundation
import SwiftUI
import MapKit

struct LocationInfoView: View {
    
    @ObservedObject public var locationVM: LocationViewModel 
    @State private var showLocation: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            ForEach(Array(self.locationVM.locationInfo.enumerated()), id: \.element.id) { index, location in
                let comeFromRight = index % 2 == 0
                
                LocationCell(type: location.type,
                             info: location.info,
                             color: location.color)
//                .rotationEffect(.degrees(self.locationVM.showLocationInfo ? 0 : 360))
                .scaleEffect(self.locationVM.showLocationInfo ? 1 : 0)
                .offset(x: self.locationVM.showLocationInfo ? 0 : comeFromRight ? 650 : -650)
                .animation(Animation.default.delay(Double(index) * 0.3 + 0.01),
                           value: self.locationVM.showLocationInfo)
                  }
            }
        }
    }


