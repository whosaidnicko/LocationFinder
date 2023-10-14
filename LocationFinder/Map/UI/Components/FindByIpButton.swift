//
//  FindByIpButton.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 08/10/2023.
//

import Foundation
import SwiftUI

struct FindByIpButton: View {
    public var action: () -> Void
    var body: some View {
         Text("Find By IP")
            .font(.custom(Constants.fontName.semiBold, size: 20))
            .foregroundColor(.red)
            .frame(width: 130,
                   height: 60,
                   alignment: .center)
            .background(.black)
            .cornerRadius(16)
            .onTapGesture {
                action()
            }

    }
}
