//
//  locationDetailsModel.swift
//  Evanddays
//
//  Created by David on 6/1/24.
//

import Foundation

//@Observable
//class locationDetailsModel {
//    var selectedContinent: parcel? {
//        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
//        didSet { Task {  await startFetchingParcels(Query: selectedContinent?.name ?? "empty") } }
//    }
//    
//    var selectedCountry: parcel? {
//        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
//        didSet { Task {  await startFetchingParcels(Query: selectedCountry?.name ?? "empty") } }
//    }
//    // State variable to hold the list of decoded continents
//    var parcels: [parcel] = []
//    
//    
//    
//    func startFetchingParcels(Query: String) async {
//        // Ensure the URL is valid
//        guard let url = URL(string: "http://10.1.10.126:3000/get-parcels?getParcel=\(Query)") else {
//            print("Invalid URL")
//            return
//        }
//        do {
//            // Perform the network request asynchronously
//            let (data, _) = try await URLSession.shared.data(from: url)
//            // For debugging: Convert the received data to a string and print it
//            let dataString = String(data: data, encoding: .utf8)
//            print("Received data: \(dataString ?? "nil")")
//            
//            // Decode the received JSON data into the Response struct
//            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
//            // Check if the decoded response contains continents
//            if let continentsDict = decodedResponse.parcels {
//                // Transform the continents dictionary into an array of Continent objects
//                let decodedContinents = continentsDict.map { parcel(id: $0.value, name: $0.key) }
//                // Update the state variable 'continents' on the main thread
//                DispatchQueue.main.async {
//                    self.parcels = decodedContinents
//                }
//            }
//        } catch {
//            // Print any error that occurs during the network request or decoding
//            print("Failure: \(error.localizedDescription)")
//        }
//    }
//    
//}

import Foundation

@Observable
class locationDetailsModel {
    var selectedContinent: parcel? {
        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
        didSet {
            if let selectedContinent = selectedContinent {
//                selectedLayerHierarchy.append(selectedContinent.name)
                if selectedLayerHierarchy.count < 2  {
                    selectedLayerHierarchy.append(selectedContinent.name)
                } else {
                    selectedLayerHierarchy[1] = selectedContinent.name
                    selectedLayerHierarchy.removeSubrange(2..<selectedLayerHierarchy.count)
                }
                // Reset selectedCountry and selectedState
                selectedCountry = nil
                selectedState = nil

                Task { await startFetchingParcels( theContinents: false, theCountries: true,theStates: false) }
            }
           
        }
        
    }
    
    var selectedCountry: parcel? {
        
        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
        didSet {
            if let selectedCountry = selectedCountry {
                if selectedLayerHierarchy.count < 3 {
                    selectedLayerHierarchy.append(selectedCountry.name)
                }else {
                    selectedLayerHierarchy[2] = selectedCountry.name
                    selectedLayerHierarchy.removeSubrange(3..<selectedLayerHierarchy.count)
                }
                selectedState = nil
                Task { await startFetchingParcels(theContinents: false, theCountries: false,theStates: true) }
            }
        }
    }
    var selectedState: parcel? {
        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
        didSet {
            if let selectedState = selectedState {
                if selectedLayerHierarchy.count < 4 {
                    selectedLayerHierarchy.append(selectedState.name)
                } else {
                    selectedLayerHierarchy[3] = selectedState.name
                    selectedLayerHierarchy.removeSubrange(4..<selectedLayerHierarchy.count)
                }
                Task { await startFetchingParcels(theContinents: false, theCountries: false, theStates: false) }
            }
        }
    }
    
    // State variables to hold the list of decoded parcels
    var continents: [parcel] = []
//    var theContinents: Bool = false
    var countries: [parcel] = []
    var states: [parcel] = []
    var selectedLayerHierarchy: [String] = ["all"]
    
    func startFetchingParcels(theContinents: Bool, theCountries: Bool, theStates:Bool) async {
        // Ensure the URL is valid
        guard let url = URL(string: "http://192.168.1.21:3000/get-parcels?getParcel=\(selectedLayerHierarchy)") else {
            print("Invalid URL")
            return
        }
        do {
            
            // Perform the network request asynchronously
            let (data, _) = try await URLSession.shared.data(from: url)
            // For debugging: Convert the received data to a string and print it
            let dataString = String(data: data, encoding: .utf8)
            print("Received data: \(dataString ?? "nil")")
            
            // Decode the received JSON data into the Response struct
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            // Check if the decoded response contains parcels
            if let parcelsDict = decodedResponse.parcels {
                // Transform the parcels dictionary into an array of parcel objects
                let decodedParcels = parcelsDict.map { parcel(id: $0.value, name: $0.key) }
                // Update the state variable 'parcels' or 'countries' on the main thread
                DispatchQueue.main.async {
                    if theContinents {
                        self.continents = decodedParcels
                    } else if theCountries{
                        self.countries = decodedParcels
                    } else if theStates {
                        self.states = decodedParcels
                    }
                }
            }
        } catch {
            // Print any error that occurs during the network request or decoding
            print("Failure: \(error.localizedDescription)")
        }
    }
}
