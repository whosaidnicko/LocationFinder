//
//  LocationCell.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 14/10/2023.
//

import Foundation
import SwiftUI

struct LocationCell: View {
    @State public var type: String
    @State public var info: String
    @State public var color: Color
    
    var body: some View {
        HStack{
            HStack{
                Text(self.type)
                    .font(.custom(Constants.fontName.pixRegular, size: 14))
                
                Spacer()
                
                Text(self.info)
                    .font(.system(size: 14))
                    .rotation3DEffect(.degrees(30), axis: (x: 30, y: 30, z: 7))
            }
            .padding(.horizontal)
        }
        .frame(height: 46)
        .background(self.color)
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
    }
}
