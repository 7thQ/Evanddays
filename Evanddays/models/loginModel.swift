//
//  loginModel.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//

import Foundation
import CoreLocation  // Import to use CLLocationCoordinate2D


@Observable
class whoLoggedIn: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _userName = "userName"
        case _password = "password"
        
    }
    
    var userName: String = ""
    var password: String = ""
    
    
    

}
@Observable
class parcelInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _ID = "ID"
        case _parcelName = "parcelName"
  
        
    }
    
    var ID: String = ""
    var parcelName = ""
   

}



struct Response:Codable{

    var Logins: Logins?
    var message: String?
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


struct Logins: Codable {
    var userName: String
    var password:String
}

struct Events: Codable {
    var  id: String
    var eventName: String
    var ranking: String
    var eventDates: eventDates
    var location: location
    var features: features
    var Coordinate: Coordinate
    

}
struct eventDates: Codable {
    var start: Date
    var end: Date
}
struct location: Codable {
  var address: String
  var city: String
  var state: String
  var zipCode: String
}
struct features: Codable {
  var firstFeature : String
  var secondFeature: String
  var thirdfeature: String
}


struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        let longitudeString = try container.decode(String.self, forKey: .longitude)
        
        // Convert the string directly to Double
        guard let lat = Double(latitudeString),
              let lon = Double(longitudeString) else {
            throw DecodingError.dataCorruptedError(forKey: .latitude, in: container, debugDescription: "Unable to convert string to Double")
        }

        self.latitude = lat
        self.longitude = lon
    }

    // Computed property to convert Double latitude and longitude to CLLocationCoordinate2D
    var clLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}


//// Define a struct named Coordinate that conforms to the Codable protocol for encoding and decoding.
//struct Coordinate: Codable {
//    // Declare properties to hold the latitude and longitude as Decimal types for high precision.
//    var latitude: Decimal
//    var longitude: Decimal
//
//    // Define coding keys that map the JSON keys to the properties of the struct.
//    enum CodingKeys: String, CodingKey {
//        case latitude, longitude
//    }
//
//    // Custom initializer from the Decoder instance to handle the decoding of Coordinate objects from JSON.
//    init(from decoder: Decoder) throws {
//        // Create a decoding container using the defined CodingKeys enum. This container will use the keys to fetch values from JSON.
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        // Decode the latitude and longitude values from the container as strings.
//        let latitudeString = try container.decode(String.self, forKey: .latitude)
//        let longitudeString = try container.decode(String.self, forKey: .longitude)
//
//        // Convert the decoded string values to Decimal. If conversion fails, it throws a decoding error.
//        // This ensures that the values are valid Decimals, maintaining the high precision necessary for coordinates.
//        guard let lat = Decimal(string: latitudeString),
//              let lon = Decimal(string: longitudeString) else {
//            throw DecodingError.dataCorruptedError(forKey: .latitude, in: container, debugDescription: "Decimal number not valid")
//        }
//
//        // Assign the converted Decimal values to the properties.
//        self.latitude = lat
//        self.longitude = lon
//    }
//}
//


struct userDetails: Codable, Hashable {
    var firstName: String
    var lastName: String
    var userName: String
    var password: String
    var email: String
    var streetAddress: String
    var unit: String
    var city:String
    var state:String
    var zip:String
    var dateOfBirth: Date  
    var phoneNumber: String
}

