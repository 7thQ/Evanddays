//
//  loginModel.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//

import Foundation
import CoreLocation  // Import to use CLLocationCoordinate2D

 struct Response: Codable{
//     var parcels:
    var Logins: Logins?
    var message: String? 
    var userdetails: userDetails?
    var userHosted: [Events]?
    var countries: [Events]?
     var parcels: [String: String]?
    var urls: [String]?
    var videoURLs: [URL] {
        urls?.compactMap { URL(string: $0) } ?? []
    }
    
}



// Continent model that conforms to Codable, Identifiable, and Hashable protocols
struct parcel: Codable, Identifiable, Hashable {
    // Unique identifier for each continent
    let id: String
    // Name of the continent
    let name: String
}

//struct URLS: Codable, Hashable {
//    var urls: [String]
//}
