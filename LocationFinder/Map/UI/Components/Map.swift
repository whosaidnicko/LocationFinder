//
//  Map.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 13/10/2023.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @ObservedObject public var viewModel: LocationViewModel
    
    var body: some View {
        Map(coordinateRegion: self.$viewModel.region)
            .edgesIgnoringSafeArea(.vertical)
            .opacity(self.viewModel.showMap ? 1 : 0)
            .offset(x: self.viewModel.showMap ? 0 : -1000)
            .animation(Animation.easeInOut.delay(1.9), value: self.viewModel.showLocationInfo)
            .onTapGesture {
                withAnimation {
                    self.viewModel.showLocationInfo.toggle()
                }
            }
    }
}
