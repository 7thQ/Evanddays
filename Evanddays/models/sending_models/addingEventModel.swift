//
//  addingEventModel.swift
//  Evanddays
//
//  Created by David on 5/14/24.
//

import Foundation
import PhotosUI
import SwiftUI



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
//    var emptyAddressFields = "Cant be emtpy"
//    var emptyCoordinatesFields = "Cant be emtpy"
    

        
    var checker: Bool {return false}
//        // Check if the features array is either empty or contains any feature with fewer than 2 characters.
//        if features.isEmpty || features.contains(where: { $0.text.count < 2 }) {
//            // Return true to indicate the form is not complete or has invalid data.
//            return true
//        }
//
//   
//        if useAddress && useCoordinates {
//            if longitude.isEmpty || latitude.isEmpty || streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty  {
//                return true
//            }else {
//                return false
//            }
//        }
//        if useAddress {
//                if streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty {
//                    return true
//                }else {
//                    return false}
//        }
//        if useCoordinates {
//            if longitude.isEmpty || latitude.isEmpty {
//                return true
//            }else {
//                return false
//            }
//        }
//
//            return true
//        }

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
    
    func sendDetails() async {
        // Create an instance of EventDetails with features as an array of strings
        let eventDetails = EventDetails(
            eventName: eventName,
            latitude: latitude,
            longitude: longitude,
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode,
            start: start,
            end: end,
            features: features.map { $0.text } // Map features to an array of strings
        )
        
        // Encode EventDetails instead of createEvent
        guard let encoded = try? JSONEncoder().encode(eventDetails) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "http://:3000/add-event")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let dataString = String(data: data, encoding: .utf8)
            print("Received data: \(dataString ?? "nil")")

            // Decode EventDetails instead of createEvent
            let decodedOrder = try JSONDecoder().decode(EventDetails.self, from: data)
            print("\(decodedOrder)")

        } catch {
            print("Check out failed: \(error.localizedDescription)")
        }
    }


}
// New struct to match the desired backend data format
struct EventDetails: Codable {
    var eventName: String
    var latitude: String
    var longitude: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var start: Date
    var end: Date
    var features: [String] // Changed to an array of strings
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



@Observable
class addVideoOrPhotos: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _mediaData = "mediaData"
        case _mediaType = "mediaType"
        case _mediaURL = "mediaURL"
    }
    
    
    var selectedItem: PhotosPickerItem? {
         // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
         didSet { Task { try await loadMedia() } }
     }
     var mediaData: Data? = nil // Stores the raw data of the selected media (image or video).
     var mediaType: UTType? = nil // Stores the type of the selected media (e.g., image or video).
     var mediaURL: URL? = nil // Stores the file URL of the selected video if applicable.

     // Asynchronously loads the selected media item and determines its type.
     func loadMedia() async throws {
         guard let item = selectedItem else { return }
         if let data = try await item.loadTransferable(type: Data.self) {
             mediaData = data
             if let _ = UIImage(data: data) {
                 // If the data can be converted to a UIImage, it's an image.
                 mediaType = .image
                 mediaURL = nil
             } else {
                 // Otherwise, assume it's a video and save it to a temporary file.
                 mediaType = .movie
                 mediaURL = saveVideoToTemporaryFile(data: data)
             }
         }
     }
     
     // Saves the video data to a temporary file and returns the file URL.
     private func saveVideoToTemporaryFile(data: Data) -> URL? {
         let tempDirectory = FileManager.default.temporaryDirectory
         let tempFileURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
         
         do {
             // Attempts to write the video data to the temporary file.
             try data.write(to: tempFileURL)
             return tempFileURL
         } catch {
             // Logs an error message if writing the file fails and returns nil.
             print("Failed to save video to temporary file: \(error)")
             return nil
         }
     }
    func uploadMediaData() async {
        // Ensure the media data and media type are available
        guard let mediaData = self.mediaData, let mediaType = self.mediaType else {
            print("No media data or type found")
            return
        }

        // Set the server URL
        let url = URL(string: "http://192.168.1.21:3000/add-video")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        // Generate a unique filename using a UUID
        let filename = "\(UUID().uuidString).\(mediaType == .movie ? "mov" : "jpg")"

        // Create the multipart form data
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mediaType.preferredMIMEType ?? "application/octet-stream")\r\n\r\n".data(using: .utf8)!)
        body.append(mediaData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        print("Sending data: \(body.count) bytes")
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.upload(for: request, from: body)
            
            // Check the response status code
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                let dataString = String(data: data, encoding: .utf8)
                print("Received data: \(dataString ?? "nil")")
            } else {
                print("Server error: \(response)")
            }
        } catch {
            print("Upload failed with error: \(error.localizedDescription)")
        }
    }
    
    
}


