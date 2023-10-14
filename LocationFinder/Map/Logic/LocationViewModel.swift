//
//  LocationViewModel.swift
//  LocationFinder
//
//  Created by Nicolae Chivriga on 08/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import Combine
import MapKit

class LocationViewModel:ObservableObject {
    
    @Published public var region: MKCoordinateRegion
    @Published public var refreshID = UUID()
    @Published public var showMap: Bool = false
    @Published public var showTextfield: Bool = false
    @Published public var searchedIP: String = ""
    @Published public var distance: String = ""
    @Published public var showIP: Bool = false
    @Published public var findLocation: Location?
    @Published public var userLocation: Location?
    @Published public var showLocationInfo: Bool = false
    @Published public var isValidIP: Bool = true
    @Published public var locationInfo: [LocationCellModel] = []
    
    @Published public var userIP: String? {
        didSet {
            guard let userIP = self.userIP else { return }
            self.fetchIPInformation(ip: userIP) { location in
                self.userLocation = location
            }
        }
    }
    
    private var validCharSet = CharacterSet(charactersIn: "1234567890.")
    private var subCancellable: AnyCancellable!
    
    //MARK: - Init
    public init() {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 51.507222,
                longitude: -0.1275),
            span: MKCoordinateSpan(
                latitudeDelta: 0.5,
                longitudeDelta: 0.5))
        
        self.fetchUserIP() { userIP in
            self.userIP = userIP
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.showIP = true
                }
            }
        }
        
        // textfield accepts just numbers and dot
        self.subCancellable = self.$searchedIP.sink { val in
            if val.rangeOfCharacter(from: self.validCharSet.inverted) != nil {
                DispatchQueue.main.async {
                    self.searchedIP = String(self.searchedIP.unicodeScalars.filter {
                        self.validCharSet.contains($0)
                    })
                }
            }
        }
    }
    
    deinit {
        self.subCancellable.cancel()
    }
    
    //MARK: - Methods
    
    public func refreshView() {
        self.refreshID = UUID()
    }
    
    private func fetchUserIP(completion: @escaping(String) -> Void) {
        guard let url = URL(string: "https://api.ipify.org") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                if let ipAdress = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        completion(ipAdress)
                    }
                }
            }
        }.resume()
    }
    
    // fetching ip information from servers
    private func fetchIPInformation(ip: String, completion: @escaping(Location) -> Void) {
        if ip != "" {
            guard let url = URL(string: "https://freeipapi.com/api/json/" + ip) else {
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let locationInfo = try decoder.decode(Location.self, from: data)
                        DispatchQueue.main.async {
                            self.findLocation = locationInfo
                            completion(locationInfo)
                        }
                    } catch {
                        print("Error decoding location information:", error)
                    }
                }
            }.resume()
            
        } else {
            return
        }
    }
    
    // verify if ip user is searching is valid
    private func isValidIPAddress(_ ipAddress: String) -> Bool {
        let ipAddressRegex = #"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"#
        
        return NSPredicate(format: "SELF MATCHES %@", ipAddressRegex).evaluate(with: ipAddress)
    }
    // calculate dinstance from user to ip searched
    private func calculateDistance(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D)  {
        let sourceLocation = CLLocation(latitude: source.latitude, longitude: source.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        distance = String(Int(sourceLocation.distance(from: destinationLocation) / 1000)) + " km"
    }
    
    public func dimissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    // actions after user taped search ip
    public func searchIP() {
            withAnimation {
                self.showMap = false
                if self.isValidIPAddress(self.searchedIP) || self.searchedIP.isEmpty && self.isValidIP {
                    switch self.showLocationInfo {
                    case true:
                        self.showLocationInfo = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
                        {
                            self.showTextfield.toggle()
                        }
                    case false :
                        SwiftUI.withAnimation {
                            self.showTextfield.toggle()
                        }
                    }
                }
            }
            //MARK: - search ip logic
        if self.isValidIPAddress(self.searchedIP) {
            self.fetchIPInformation(ip: self.searchedIP,
                                    completion: { location in
                
                guard let userLocation = self.userLocation else { return }
                self.calculateDistance(from: CLLocationCoordinate2D(latitude: userLocation.latitude,
                                                                    longitude: userLocation.longitude),
                                       to: CLLocationCoordinate2D(latitude: location.latitude,
                                                                  longitude: location.longitude))
                
                self.locationInfo = [LocationCellModel(type: Constants.locationDetails.country,
                                                       info: location.countryName,
                                                       color: .blue),
                                     LocationCellModel(type: Constants.locationDetails.city,
                                                       info: location.cityName,
                                                       color: .green),
                                     LocationCellModel(type: Constants.locationDetails.timeZone,
                                                       info: location.timeZone,
                                                       color: .cyan),
                                     LocationCellModel(type: Constants.locationDetails.longitude,
                                                       info: String(location.longitude),
                                                       color: .red),
                                     LocationCellModel(type: Constants.locationDetails.latitude,
                                                       info: String(location.latitude),
                                                       color: .orange),
                                     LocationCellModel(type: Constants.locationDetails.ip,
                                                       info: location.ipAddress,
                                                       color: .yellow),
                                     LocationCellModel(type: Constants.locationDetails.distance,
                                                       info: self.distance,
                                                       color: .black)]
                
                DispatchQueue.main.async {
                    self.showMap = false
                    self.region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.5,
                            longitudeDelta: 0.5))
                    self.refreshView()
                    self.searchedIP = ""
                    self.showLocationInfo = true
                    self.showMap = true
                }
            })
            // ip is not valid
        } else if !self.searchedIP.isEmpty {
            self.searchedIP = ""
            self.isValidIP = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.isValidIP = true
            }
        }
    }
}
