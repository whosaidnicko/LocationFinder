//
//  CustomTextfield.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 08/10/2023.
//

import Foundation
import SwiftUI

struct CustomTextfield: View {
    
    @Binding public var userIP: String
    @State private var text: String = ""
    @ObservedObject public var locationVM: LocationViewModel
    @FocusState private var keyboard
    
    var body: some View {
        TextField("", text: self.$userIP)
            .padding()
            .padding(.horizontal)
            .keyboardType(.decimalPad)
            .focused(self.$keyboard)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: self.locationVM.isValidIP ? 60 : 0)
                    .padding()
                    .padding(.horizontal, self.locationVM.isValidIP ? 0 : 500)
                    .foregroundColor(self.locationVM.isValidIP ? .yellow : .red)
                    .rotation3DEffect(.degrees(self.locationVM.isValidIP ? 0 : 120), axis: (x: 100, y: 100, z: 0))
                    .background(
                        Text("Searched IP is not valid")
                            .font(.custom(Constants.fontName.semiBold, size: 22))
                            .foregroundColor(.red)
                    )
                    .animation(Animation.easeOut(duration: 1.3), value: self.locationVM.isValidIP)
            )
            .disabled(!self.locationVM.isValidIP)
            .onChange(of: self.locationVM.showTextfield) { isTextfieldShowed in
                self.keyboard = isTextfieldShowed
            }
            .onChange(of: self.locationVM.isValidIP) { ipValid in
                if ipValid {
                    // take in count animation time
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.keyboard = ipValid
                    }
                }  else {
                    self.keyboard = ipValid
                }
            }
    }
}
