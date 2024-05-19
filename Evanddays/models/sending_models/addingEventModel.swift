//
//  addingEventModel.swift
//  Evanddays
//
//  Created by David on 5/14/24.
//

import Foundation


@Observable
class createEvent: Codable {
    enum CodingKeys: String, CodingKey {

        case _eventName = "eventName"
        case _latitude = "latitude"
        case _longitude = "longitude"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _state = "state"
        case _zipCode = "zipCode"
        case _start = "start"
        case _end = "end"
        case _features = "features"
    }
    var eventName: String = ""
    var start: Date = .now
    var end: Date = .now
    var streetAddress: String = ""
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var features: [Feature] = []
    var useAddress = false
    var useCoordinates = false 
    var setEnd = false
    var emptyAddressFields = "Cant be emtpy"
    var emptyCoordinatesFields = "Cant be emtpy"
    

        
    var checker: Bool {
        // Check if the features array is either empty or contains any feature with fewer than 2 characters.
        if features.isEmpty || features.contains(where: { $0.text.count < 2 }) {
            // Return true to indicate the form is not complete or has invalid data.
            return true
        }

   
        if useAddress && useCoordinates {
            if longitude.isEmpty || latitude.isEmpty || streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty  {
                return true
            }else {
                return false
            }
        }
        if useAddress {
                if streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty {
                    return true
                }else {
                    return false}
        }
        if useCoordinates {
            if longitude.isEmpty || latitude.isEmpty {
                return true
            }else {
                return false
            }
        }

            return true
        }

    // Function to add a new feature to the list.
    func addFeature() {
        // Check if there are fewer than 3 features.
        if features.count < 3 {
            // Append a new feature with empty text to the features array.
            features.append(Feature(""))
        }
    }

    // Function to delete a feature safely.
    func deleteFeature(at offsets: IndexSet) {
        // Remove the feature at the specified index set from the features array
        features.remove(atOffsets: offsets)
    }

}

struct Feature: Codable {
    // Unique identifier for each feature, necessary for stable identification in ForEach.
    var id: UUID = UUID()
    
    // Text of the feature, bound to the TextField in the UI.
    var text: String
    
    // Initialize a feature with a given text.
    init(_ text: String) {
        self.text = text
    }
}



//if useAddress {
//    if streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty {
//        return false
//    }
//    return true
//}
//if useCoordinates {
//    if longitude.isEmpty || latitude.isEmpty {
//        return false
//    }
//    return true
//}
//
//import Foundation
//
//class Event: Codable {
//
//    var eventName: String
//
//    var eventDates: EventDates
//    var location: Location
//    var features: Features
//    var coordinate: Coordinate
//
//    enum CodingKeys: String, CodingKey {
//
//        case eventName
//
//        case eventDates
//        case location
//        case features
//        case coordinate
//    }
//
//    init(
//         eventName: String = "Happy place",
//
//         eventDates: EventDates = EventDates(),
//         location: Location = Location(),
//         features: Features = Features(),
//         coordinate: Coordinate = Coordinate()) {
//
//        self.eventName = eventName
//
//        self.eventDates = eventDates
//        self.location = location
//        self.features = features
//        self.coordinate = coordinate
//    }
//
//    class EventDates: Codable {
//        var start: String
//        var end: String
//
//        enum CodingKeys: String, CodingKey {
//            case start
//            case end
//        }
//
//        init(start: String = "2024-09-20T00:00:00.000Z", end: String = "2024-09-21T23:59:59.999Z") {
//            self.start = start
//            self.end = end
//        }
//    }
//
//    class Location: Codable {
//        var address: String
//        var city: String
//        var state: String
//        var zipCode: String
//
//        enum CodingKeys: String, CodingKey {
//            case address
//            case city
//            case state
//            case zipCode
//        }
//
//        init(address: String = "715 Glide Ave", city: String = "San Francisco", state: String = "CA", zipCode: String = "94134") {
//            self.address = address
//            self.city = city
//            self.state = state
//            self.zipCode = zipCode
//        }
//    }
//
//    class Features: Codable {
//        var firstFeature: String
//        var secondFeature: String
//        var thirdFeature: String
//
//        enum CodingKeys: String, CodingKey {
//            case firstFeature
//            case secondFeature
//            case thirdFeature
//        }
//
//        init(firstFeature: String = "partys", secondFeature: String = "partys", thirdFeature: String = "partys") {
//            self.firstFeature = firstFeature
//            self.secondFeature = secondFeature
//            self.thirdFeature = thirdFeature
//        }
//    }
//
//    class Coordinate: Codable {
//        var latitude: String
//        var longitude: String
//
//        enum CodingKeys: String, CodingKey {
//            case latitude
//            case longitude
//        }
//
//        init(latitude: String = "36.491508", longitude: String = "-121.197243") {
//            self.latitude = latitude
//            self.longitude = longitude
//        }
//    }
//}
