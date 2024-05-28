//
//  mapView.swift
//  Evanddays
//
//  Created by David on 4/28/24.
//

//import Foundation
//import SwiftUI
//@_spi(Experimental) import MapboxMaps
//   
//struct mapView: View {
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
//
//#Preview {
//    mapView()
//}
//
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




//import Foundation
//
//// Define the asynchronous functions
//func fetchData1() async throws -> String {
//    try await Task.sleep(nanoseconds: 1_000_000_000) // Simulate async operation with a 1-second delay
//    return "Data from function 1"
//}
//
//func fetchData2() async throws -> String {
//    try await Task.sleep(nanoseconds: 2_000_000_000) // Simulate async operation with a 2-second delay
//    return "Data from function 2"
//}
//
//// Define the main asynchronous function
//func mainFunction() async {
//    do {
//        async let result1 = fetchData1()
//        async let result2 = fetchData2()
//
//        let combinedResult = try await "\(result1) and \(result2)"
//        print(combinedResult)
//    } catch {
//        print("Error in fetching data: \(error)")
//    }
//}
//
//// Run the main function
//Task {
//    await mainFunction()
//}
//











//
//
//import SwiftUI
//import MapKit
//
//struct mapVi: View {
//    @State private var postion: MapCameraPosition = .userLocation(fallback: .automatic)
//      var body: some View {
//          Map(position: $postion){
//              UserAnnotation()
//          }
//          .onAppear{
//              CLLocationManager().requestWhenInUseAuthorization()
//          }
//          .mapControls {
//              MapUserLocationButton()
//          }
//      }
//  }


#Preview {
    mapVi()
}


//import SwiftUI
//import MapKit
//
//struct mapVi: View {
//    @StateObject private var locationManager = LocationManager()  // Using @StateObject for lifecycle management
//    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
//
//    var body: some View {
//        Map(position: $position) {
//            UserAnnotation()
//        }
//        .onAppear {
//            locationManager.requestLocationAuthorization()  // Trigger location request
//        }
//        .mapControls {
//            MapUserLocationButton()
//        }
//    }
//}
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private var locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//    }
//
//    func requestLocationAuthorization() {
//        locationManager.requestWhenInUseAuthorization()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}
//
//#Preview{
//    mapVi()
//}


import SwiftUI
@_spi(Experimental) import MapboxMaps

@available(iOS 14.0, *)
struct mapVi: View {
    @State var viewport: Viewport = .followPuck(zoom: 13, bearing: .constant(0))

    var body: some View {
        VStack{
            Map(viewport: $viewport) {
                Puck2D(bearing: .heading)
                
            }
                .mapStyle(.standard)
                .ignoresSafeArea()
                
//            LocateMeButton(viewport: $viewport)
                
        }
    }
}
//
//@available(iOS 14.0, *)
//struct LocateMeButton: View {
//    @Binding var viewport: Viewport
//
//    var body: some View {
//        Button {
//            withViewportAnimation(.default(maxDuration: 1)) {
//                if isFocusingUser {
//                    viewport = .followPuck(zoom: 16.5, bearing: .heading, pitch: 60)
//                } else if isFollowingUser {
//                    viewport = .idle
//                } else {
//                    viewport = .followPuck(zoom: 13, bearing: .constant(0))
//                }
//            }
//        } label: {
//            Image(systemName: imageName)
//                .transition(.scale.animation(.easeOut))
//        }
//        .safeContentTransition()
////        .buttonStyle(MapFloatingButtonStyle())
//    }
//
//    private var isFocusingUser: Bool {
//        return viewport.followPuck?.bearing == .constant(0)
//    }
//
//    private var isFollowingUser: Bool {
//        return viewport.followPuck?.bearing == .heading
//    }
//
//    private var imageName: String {
//        if isFocusingUser {
//           return  "location.fill"
//        } else if isFollowingUser {
//           return "location.north.line.fill"
//        }
//        return "location"
//
//    }
//}
//
//@available(iOS 13.0, *)
//private extension View {
//    func safeContentTransition() -> some View {
//        if #available(iOS 17, *) {
//            return self.contentTransition(.symbolEffect(.replace))
//        }
//        return self
//    }
//}

@available(iOS 14.0, *)
struct LocateMeExample_Preview: PreviewProvider {
    static var previews: some View {
        mapVi()
    }
}
