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
            ForEach(Array(locationVM.locationInfo.enumerated()), id: \.element.id) { index, location in
                let comeFromRight = index % 2 == 0
                HStack{
                    Text(location.type)
                        .frame(width: 200, height: 46)
                        .font(.system(size: 10))
                        .background(location.color)
                        .cornerRadius(8)
                    Text(location.info)
                        .font(.system(size: 10))
                     
                }
                .offset(x: locationVM.showLocationInfo ? 0 : comeFromRight ? 350 : -350)
                .animation(Animation.default.delay(Double(index) * 0.3 + 0.01),
                           value: locationVM.showLocationInfo)
                  }
            }
        
            
            //        ForEach(Array(sortedLocationInfo.enumerated()), id: \.offset) { (index, keyValue) in
            //            let randomColor = Color(red: .random(in: 0...1),
            //                                     green: .random(in: 0...1),
            //                                     blue: .random(in: 0...1))
            //            let (key, value) = keyValue
            //
            //
            //
        }
    }


