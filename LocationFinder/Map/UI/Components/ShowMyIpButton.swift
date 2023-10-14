//
//  ShowMyIpButton.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 08/10/2023.
//

import Foundation
import SwiftUI

struct ShowMyIpButton: View {
    @Binding public var buttonTitle: String
    var action: () -> Void
    var body: some View {
        Text(self.buttonTitle)
            .font(.custom(Constants.fontName.semiBold, size: 20))
                .foregroundColor(.yellow)
                .frame(width: 130,
                       height: 60,
                       alignment: .center)
                .background(.black)
                .cornerRadius(16)
                .onTapGesture {
                    self.action()
                }
    }
}
