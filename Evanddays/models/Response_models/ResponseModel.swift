//
//  loginModel.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//

import Foundation
import CoreLocation  // Import to use CLLocationCoordinate2D

 struct Response: Codable{

    var Logins: Logins?
    var message: String? = ""
    var userdetails: userDetails?
    var userHosted: [Events]?
    var countries: [Events]?
    var urls: [String]?
    var videoURLs: [URL] {
        urls?.compactMap { URL(string: $0) } ?? []
    }
    
}
//struct URLS: Codable, Hashable {
//    var urls: [String]
//}


