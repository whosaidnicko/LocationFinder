//
//  ContentView.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 07/10/2023.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel: LocationViewModel = LocationViewModel()
    
    private var showOrHideText: Binding<String> {
        return self.viewModel.showIP ? Binding.constant("Hide My IP") : Binding.constant("Show My IP")
    }
    
    var body: some View {
        ZStack{
            MapView(viewModel: viewModel)
            
            VStack {
                CustomTextfield(userIP: self.$viewModel.searchedIP, locationVM: self.viewModel)
                .offset(x: self.viewModel.showTextfield ? 0 : -500)
                .animation(Animation.easeOut, value: self.viewModel.showTextfield)
            }
            
            VStack{
                self.userIPView
                
                Spacer()
                
                HStack{
                    ShowMyIpButton(
                        buttonTitle: showOrHideText ) {
                            withAnimation {
                                self.viewModel.showIP.toggle()
                            }
                        }
                    
                    Spacer()
                    
                    FindByIpButton {
                        self.viewModel.searchIP()
                    }
                }
                .padding(.horizontal)
            }
            //MARK: - Location View
            LocationInfoView(locationVM: viewModel)
        }
    }
    
    private var userIPView: some View {
        Text(viewModel.userIP ?? "Please connect to internet.")
            .font(.custom(Constants.fontName.semiBold, size: 20))
            .frame(width: 200)
            .background(.green)
            .cornerRadius(8)
            .offset(y: viewModel.showIP  ? 50 : -500)
    }
}
