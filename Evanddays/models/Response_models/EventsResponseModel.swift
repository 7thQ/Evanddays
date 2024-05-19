//
//  EventsResponseModel.swift
//  Evanddays
//
//  Created by David on 5/16/24.
//

import Foundation
import CoreLocation  // Import to use CLLocationCoordinate2D


 struct Events: Codable {
    var  id: String
    var eventName: String
    var ranking: String
    var eventDates: eventDates
    var location: location
//    var features: features
     var features: [String]
    var Coordinate: Coordinate
    

}
 struct eventDates: Codable {
    var start: Date
    var end: Date
}

 struct location: Codable {
  var streetAddress: String
  var city: String
  var state: String
  var zipCode: String
}

// struct features: Codable {
//  var firstFeature : String
//  var secondFeature: String
//  var thirdfeature: String
//}


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
