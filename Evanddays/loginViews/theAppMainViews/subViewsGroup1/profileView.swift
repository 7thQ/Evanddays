//
//  test.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//

extension DateFormatter {
    static let customISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // Adjust this format to match your JSON date format
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

//
//
//import SwiftUI
//struct ProfileView: View {
//    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
//    @State private var userdetails: userDetails?
//    @AppStorage("username") var username: String = ""
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                if let details = userdetails {
//                    Text("Username: \(details.userName)")
//                    Text("First Name: \(details.firstName)")
//                    Text("Last Name: \(details.lastName)")
//                    Text("Email: \(details.email)")
//                    Text("Address: \(details.streetAddress), \(details.unit), \(details.city), \(details.state) \(details.zip)")
//                    Text("Date of Birth: \(details.dateOfBirth, style: .date)")
//                    Text("Phone Number: \(details.phoneNumber)")
//                    Button(action: {
//                        UserDefaults.standard.set(false, forKey: "isLoggedIn") // Reset the login flag
//                    }) {
//                        Image(systemName: "gear")
//                            .imageScale(.large)
//                    }
//                } else {
//                    Text("No user details available.")
//                    Button(action: {
//                        UserDefaults.standard.set(false, forKey: "isLoggedIn") // Reset the login flag
//                    }) {
//                        Image(systemName: "gear")
//                            .imageScale(.large)
//                    }
//                }
//            }
//            .padding()
//        }
//        .task {
//            await loadSumDeats()
//        }
//    }
//    func loadSumDeats() async {
//    guard let url = URL(string: "http://192.168.1.22:3000/get-user?username=\(username)") else {
//        print("Invalid URL")
//        return
//    }
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let dataString = String(data: data, encoding: .utf8)
//        print("Received data: \(dataString ?? "nil")")
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .formatted(DateFormatter.customISO8601)
//        let decodedResponse = try decoder.decode(Response.self, from: data)
//        userdetails = decodedResponse.userdetails
//    } catch {
//        print("Invalid response: \(error)")
//    }
//}
//
//}
//
//#Preview {
//    ProfileView()
//}
//
//
import Foundation
import SwiftUI
@_spi(Experimental) import MapboxMaps




//struct capView: View {
//
//    @State private var showDetails = false // State to control sheet presentation
//    var gradient = Gradient(colors: [.yellow])
//    
//    let MiddleOfNorthAmerica = CLLocationCoordinate2D(latitude: 40.81843, longitude: -103.91020)
//    let MiddleofCanda = CLLocationCoordinate2D(latitude: 57.66686, longitude: -105.83409)
//    let MiddleOfCountrys = CLLocationCoordinate2D(latitude: 40.81843, longitude: -103.91020)
//    let Middleofstates = CLLocationCoordinate2D(latitude: 37.17919, longitude: -119.73603)
//    let MiddleofCountys = CLLocationCoordinate2D(latitude: 38.83297, longitude: -121.95558)
//    let MiddleOfCitiesOrTowns = CLLocationCoordinate2D(latitude: 38.55647, longitude: -121.54011)
//    let MiddleOfNeighboorhoods = CLLocationCoordinate2D(latitude: 38.58284, longitude: -121.54232)
//    let userparcel = CLLocationCoordinate2D(latitude: 38.58012, longitude: -121.54498)
//
//    let UserCurrentLocation = CLLocationCoordinate2D(latitude: 38.58012, longitude: -121.54498)
//    @State private var zoomLevel: Double = 16 // Initial zoom level
//
//    var body: some View {
//        ZStack {
//            Map(initialViewport: .camera(center: UserCurrentLocation, zoom: zoomLevel, bearing: 0, pitch: 0)) {
//                // Check the current zoom level before displaying the annotation
//                if zoomLevel > 15 && zoomLevel <= 22 {
//                    
//                    MapViewAnnotation(coordinate: userparcel) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                                Text("hello")
////                                ParcelMapAnnotationVideoView()
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//                    // Zoom level is between 16 and 22
//                    // Add your specific view or action here
//                }
//                else if zoomLevel > 12 && zoomLevel <= 16 {
//                    
//                    MapViewAnnotation(coordinate: MiddleOfNeighboorhoods) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                            
//
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//
//
//
//                    // Zoom level is between 12 and 16
//                    // Add your specific view or action here
//                }
//                else if zoomLevel > 9 && zoomLevel <= 12 {
//                    
//                    MapViewAnnotation(coordinate: MiddleOfCitiesOrTowns) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                               
//
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//
//
//
//                    // Zoom level is between 9 and 12
//                    // Add your specific view or action here
//                }
//                else if zoomLevel > 7 && zoomLevel <= 9 {
//                    
//                    MapViewAnnotation(coordinate: MiddleofCountys) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                            
//
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//
//
//
//                    // Zoom level is between 7 and 9
//                    // Add your specific view or action here
//                }
//                else if zoomLevel > 4 && zoomLevel <= 7 {
//                    
//                    MapViewAnnotation(coordinate:  Middleofstates) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                               
//
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//
//
//
//                    // Zoom level is between 3 and 7
//                    // Add your specific view or action here
//                }
//                else if zoomLevel > 3 && zoomLevel <= 4 {
//                    
//                    MapViewAnnotation(coordinate: MiddleOfCountrys) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                               
//
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//
//
//
//                    // Zoom level is between 3 and 7
//                    // Add your specific view or action here
//                }
//                else if zoomLevel >= 0 && zoomLevel <= 2.9 {
//                    
//                    MapViewAnnotation(coordinate: MiddleOfNorthAmerica) {
//                        Button(action: {
//                            showDetails.toggle() // Show the sheet when the annotation is tapped
//                        }) {
//                            VStack {
//                          
//                            }
//                        }
//                    }
//                    .allowOverlap(false)
//                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//                    // Zoom level is between 0 and 2.9
//                    // Add your specific view or action here
//                }
//            }
//            .onCameraChanged { cameraState in
//                // Update the zoom level state based on the camera's current zoom
//                zoomLevel = cameraState.cameraState.zoom
//            }
//            .mapStyle(MapStyle(uri: StyleURI(rawValue: "mapbox://styles/davidgomez01/clt7l7yp300i001ptfrriex5u")!))
//            .debugOptions([.camera, .padding, .collision])
//            .ignoresSafeArea()
////            SearchMapBar()
//        }
//        .sheet(isPresented: $showDetails) {
////            PlaceContentView()
//        }
//    }
//}




struct capView: View {
    @State private var PInfo = parcelInfo()
    @State private var showDetails = false // State to control sheet presentation
    @State private var UserCurrentLocation = CLLocationCoordinate2D(latitude: 46.491508, longitude: -121.197243)
    @State private var zoomLevel: Double = 16 // Initial zoom level
    @State private var userHosted: [Events]?
    @State private var countries: [Events]?
    @State private var loadedZoomRange: ZoomRange = .none
    // Enum to define distinct zoom ranges that trigger different data loads
    enum ZoomRange {
        case events, countries, none
    }


    var body: some View {
        ZStack {
   
            Map(initialViewport: .camera(center: UserCurrentLocation, zoom: zoomLevel, bearing: 0, pitch: 0)) {
                // Check the current zoom level before displaying the annotation
                if zoomLevel > 15 && zoomLevel <= 22 {
                   
                    ForEvery(userHosted ?? [], id: \.id) { oneEvent in
                        MapViewAnnotation(coordinate: oneEvent.Coordinate.clLocation) {
                           Button(action: {
                               
                               PInfo.ID = oneEvent.id
                               PInfo.parcelName = oneEvent.eventName
                               
                             showDetails.toggle() // Show the sheet when the annotation is tapped
                           }) {
                       VStack {
                        Image(systemName: "tree")
                            .foregroundColor(.white)
                            .padding(.all, 5)
                            .background(
                                Circle()
                                    .strokeBorder(.black, lineWidth: 0.5)
                                    .background(Circle().fill(Color(.systemGreen)))
                            )
                           Text("\(oneEvent.ranking)")
                           Text("\(oneEvent.eventName)")
                           ForEach(oneEvent.features, id: \.self) { feature in
                               Text(feature)
                           }
                        //                                ParcelMapAnnotationVideoView()
                                                    }
                                                }
                                            }
                                            .allowOverlap(false)
                                            .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])

                    }// end of forEvery
                }
                else if zoomLevel > 3 && zoomLevel <= 4 {

                    ForEvery(countries ?? [], id: \.id) { oneEvent in
                        MapViewAnnotation(coordinate: oneEvent.Coordinate.clLocation) {
                           Button(action: {
                               PInfo.ID = oneEvent.id
                               PInfo.parcelName = oneEvent.eventName
                             showDetails.toggle() // Show the sheet when the annotation is tapped
                           }) {
                       VStack {
                        Image(systemName: "tree")
                            .foregroundColor(.white)
                            .padding(.all, 5)
                            .background(
                                Circle()
                                    .strokeBorder(.black, lineWidth: 0.5)
                                    .background(Circle().fill(Color(.systemGreen)))
                            )
                           Text("\(oneEvent.ranking)")
                           Text("\(oneEvent.eventName)")
                           ForEach(oneEvent.features, id: \.self) { feature in
                               Text(feature)
                           }
                                                    }
                                                }
                                            }
                                            .allowOverlap(false)
                                            .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])

                    }// end of forEvery
                }
            }
            .onCameraChanged { cameraState in
                UserCurrentLocation = cameraState.cameraState.center
                // Update the zoom level whenever the camera changes
                zoomLevel = cameraState.cameraState.zoom
                // Determine the current zoom range based on the new zoom level
                let currentRange = determineZoomRange(for: zoomLevel)

                // Check if the new zoom range is different from the last loaded range
                if currentRange != loadedZoomRange {
                    // If the zoom range has changed, execute the corresponding data loading task
                    switch currentRange {
                    case .countries:
                        // If the zoom level now falls within the countries range,
                        // asynchronously load country data
                        Task {
                            await loadcountries()
                        }
                    case .events:
                        // If the zoom level now falls within the events range,
                        // asynchronously load event data
                        Task {
                            await loaduserHosted()
                        }
                    case .none:
                        // If the zoom level does not match any predefined range,
                        // no data needs to be loaded
                        break
                    }
                    // Update the loadedZoomRange to reflect the current range after data loading
                    loadedZoomRange = currentRange
                }
            }

            .mapStyle(MapStyle(uri: StyleURI(rawValue: "mapbox://styles/davidgomez01/clt7l7yp300i001ptfrriex5u")!))
            .debugOptions([.camera, .padding, .collision])
            .ignoresSafeArea()
//            SearchMapBar()
            
            Events_Memories_Widgets()
        }//end of Zstack
//
        .sheet(isPresented: $showDetails) {
            
            mainView(PInfo: PInfo)
            
            
            //      layer
        }

    }
    
    func loaduserHosted() async {
        print("check p1:\(Thread.isMainThread)")
        print("check p1:\(Thread.current)")
        // Safeguard to ensure the URL is valid.
        guard let url = URL(string: "http://:3000/get-events?userEvents=all") else {
            print("Invalid URL")
            return
        }
        do {
            print("check p2:\(Thread.isMainThread)")
            print("check p2:\(Thread.current)")
            // Perform the network request asynchronously.
            let (data, _) = try await URLSession.shared.data(from: url)
            // For debugging: Convert the received data to a string and print it.
            let dataString = String(data: data, encoding: .utf8)
            print("Received data: \(dataString ?? "nil")")
            // Decode the received JSON data into the Response struct.
//                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customISO8601)
            let decodedResponse = try decoder.decode(Response.self, from: data)
            // Update the coordinatesModel state with the fetched coordinates.
            print(decodedResponse.userHosted ?? [])
            print(decodedResponse)
            

            userHosted = decodedResponse.userHosted


        } catch {
            // If an error occurs during the network request or decoding, print the error.
            print("Invalid response: \(error)")
        }
    }
    func loadcountries() async {
        // Safeguard to ensure the URL is valid.
        guard let url = URL(string: "http://192.168.1.21:3000/get-countrys?displayCountrys=all") else {
            print("Invalid URL")
            return
        }
        do {
            // Perform the network request asynchronously.
            let (data, _) = try await URLSession.shared.data(from: url)
            // For debugging: Convert the received data to a string and print it.
            let dataString = String(data: data, encoding: .utf8)
            print("Received data: \(dataString ?? "nil")")
            // Decode the received JSON data into the Response struct.
//                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.customISO8601)
            let decodedResponse = try decoder.decode(Response.self, from: data)
            // Update the coordinatesModel state with the fetched coordinates.
            print(decodedResponse.countries ?? [])

            countries = decodedResponse.countries


        } catch {
            // If an error occurs during the network request or decoding, print the error.
            print("Invalid response: \(error)")
        }
    }
    private func determineZoomRange(for zoomLevel: Double) -> ZoomRange {
        // Determine which zoom range the current zoom level falls into
        // This function checks the zoom level and returns the corresponding ZoomRange enum value
        if zoomLevel > 15 && zoomLevel <= 22 {
            return .events
        } else if zoomLevel > 3 && zoomLevel <= 4 {
            return .countries
        } else {
            return .none
        }
    }
    

}



#Preview{
    capView()
}
