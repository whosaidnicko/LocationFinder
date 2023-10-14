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
    
    public var action: () -> Void
    
    var body: some View {
        
        TextField("IP", text: self.$userIP)
            .padding()
            .padding(.horizontal)
            .keyboardType(.decimalPad)
            .focused(self.$keyboard)
            .background(
            RoundedRectangle(cornerRadius: 16)
                .frame(height: 60)
                .padding()
                .foregroundColor(.yellow)
            )
            .onSubmit {
                self.action()
            }
            .onChange(of: self.locationVM.showTextfield) { isTextfieldShowed in
                self.keyboard = isTextfieldShowed
            }
    }
}
