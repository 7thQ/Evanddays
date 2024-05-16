//
//  mapView.swift
//  Evanddays
//
//  Created by David on 4/28/24.
//
import Foundation
import SwiftUI
@_spi(Experimental) import MapboxMaps




      
//struct mapView: View {
//
//    
//    var body: some View {
//        let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
//        Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0)){
//            ForEvery(parks.coordinates, id: \.latitude) { coord in
//                MapViewAnnotation(coordinate: coord) {
//                    Image(systemName: "tree")
//                        .foregroundColor(.white)
//                        .padding(.all, 5)
//                        .background(
//                            Circle()
//                                .strokeBorder(.black, lineWidth: 0.5)
//                                .background(Circle().fill(Color(.systemGreen)))
//                        )
//                } // end  of map anatations
//                .allowOverlap(true)
//            }// end of forEvery
//        }//end of map View port
//        .ignoresSafeArea()
//    }//end of body
//    
//    
//}//end of struct
//
//
//private let parks = MultiPoint([
//    CLLocationCoordinate2D(latitude: 38.089600, longitude: -111.149910),
//    CLLocationCoordinate2D(latitude: 36.491508, longitude: -121.197243),
//    CLLocationCoordinate2D(latitude: 40.343182, longitude: -105.688103),
//    CLLocationCoordinate2D(latitude: 38.000000, longitude: -82.000000),
//    CLLocationCoordinate2D(latitude: 38.865097, longitude: -91.504852),
//    CLLocationCoordinate2D(latitude: 39.198364, longitude: -119.930984),
//    CLLocationCoordinate2D(latitude: 32.779720, longitude: -106.171669),
//    CLLocationCoordinate2D(latitude: 43.582767, longitude: -110.821999),
//    CLLocationCoordinate2D(latitude: 35.141689, longitude: -115.510399),
//])
//
//


//struct mapView: View {
//    @State var coordinatesSets: [Coordinate]?
//    @State private var showDetails = false // State to control sheet presentation
//    
//    var body: some View {
//        let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
//        Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0)){
//// ForEach is used to loop over the coordinatesSets array. If coordinatesSets is nil, an empty array is used as a fallback.
////for every item in the coordinatesSet array use the latitude property as a way to identifiy a new item and its propertys, then pass in the item and dispaly play it using text elements and do it again until all items have been displayed 1 item = [latitude, longitude]
//            ForEvery(coordinatesSets ?? [], id: \.latitude) { coords in
//                MapViewAnnotation(coordinate: coords.clLocation) {
//                   Button(action: {
//                     showDetails.toggle() // Show the sheet when the annotation is tapped
//                   }) {
//               VStack {
//                Image(systemName: "tree")
//                    .foregroundColor(.white)
//                    .padding(.all, 5)
//                    .background(
//                        Circle()
//                            .strokeBorder(.black, lineWidth: 0.5)
//                            .background(Circle().fill(Color(.systemGreen)))
//                    )
//                                                Text("hello")
//                //                                ParcelMapAnnotationVideoView()
//                                            }
//                                        }
//                                    }
//                                    .allowOverlap(false)
//                                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])
//
//            }// end of forEvery
//                    // The task modifier handles asynchronous operations within the view lifecycle.
//                    // This is triggered when the view appears.
//  
//        }
//        .task {
//            await loadCoordinates()
//            
//        }//end of map View port
//        .ignoresSafeArea()
//        .sheet(isPresented: $showDetails) {
//       ////            PlaceContentView()
//               }
//    }//end of body
//        func loadCoordinates() async {
//            // Safeguard to ensure the URL is valid.
//            guard let url = URL(string: "http://192.168.1.22:3000/get-coordinates?events=all") else {
//                print("Invalid URL")
//                return
//            }
//            do {
//                // Perform the network request asynchronously.
//                let (data, _) = try await URLSession.shared.data(from: url)
//                // For debugging: Convert the received data to a string and print it.
//                let dataString = String(data: data, encoding: .utf8)
//                print("Received data: \(dataString ?? "nil")")
//                // Decode the received JSON data into the Response struct.
//                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
//                // Update the coordinatesModel state with the fetched coordinates.
//                print(decodedResponse.coordinates ?? [])
//    
//                coordinatesSets = decodedResponse.coordinates
//    
//    
//            } catch {
//                // If an error occurs during the network request or decoding, print the error.
//                print("Invalid response: \(error)")
//            }
//        }
//
//}//end of struct
//10.1.10.126
//192.168.1.22
//
struct mapView: View {
//    @State private var state: Bool = zoomLevel >= 0 && zoomLevel <= 2.9
    @State private var userHosted: [Events]?
    @State private var showDetails = false // State to control sheet presentation
    
    var body: some View {
        let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
        Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0)){
// ForEach is used to loop over the coordinatesSets array. If coordinatesSets is nil, an empty array is used as a fallback.
//for every item in the coordinatesSet array use the latitude property as a way to identifiy a new item and its propertys, then pass in the item and dispaly play it using text elements and do it again until all items have been displayed 1 item = [latitude, longitude]
            ForEvery(userHosted ?? [], id: \.id) { oneEvent in
                MapViewAnnotation(coordinate: oneEvent.Coordinate.clLocation) {
                   Button(action: {
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
                   Text("\(oneEvent.features.firstFeature)")
                   Text("\(oneEvent.features.secondFeature)")
                   Text("\(oneEvent.features.thirdfeature)")
                                                
                //                                ParcelMapAnnotationVideoView()
                                            }
                                        }
                                    }
                                    .allowOverlap(false)
                                    .variableAnchors([ViewAnnotationAnchorConfig(anchor: .center)])

            }// end of forEvery
                    // The task modifier handles asynchronous operations within the view lifecycle.
                    // This is triggered when the view appears.
  
        }
        .task {
            await loaduserHosted()
            
        }//end of map View port
        .ignoresSafeArea()
        .sheet(isPresented: $showDetails) {
             mainView(PInfo: parcelInfo())
               }
    }//end of body
        func loaduserHosted() async {
            // Safeguard to ensure the URL is valid.
            guard let url = URL(string: "http://:3000/get-events?userEvents=all") else {
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
                print(decodedResponse.userHosted ?? [])
    
                userHosted = decodedResponse.userHosted
    
    
            } catch {
                // If an error occurs during the network request or decoding, print the error.
                print("Invalid response: \(error)")
            }
        }

}//end of struct



//
//import SwiftUI
//     // As SwiftUI support is experimental it needs to be imported with @_spi(Experimental)
//     // The API may change in future releases.
//     @_spi(Experimental) import MapboxMaps
//     
//     struct mapView: View {
//         var body: some View {
//             let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
//             Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0))
//                 .ignoresSafeArea()
//         }
//     }
//     


























// Preview provider for SwiftUI previews in Xcode
#Preview {
    mapView()
}



