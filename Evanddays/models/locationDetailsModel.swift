//
//  locationDetailsModel.swift
//  Evanddays
//
//  Created by David on 6/1/24.
//

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
                    ID.append(selectedContinent.id)
                } else {
                    selectedLayerHierarchy[1] = selectedContinent.name
                    selectedLayerHierarchy.removeSubrange(2..<selectedLayerHierarchy.count)
                }
                // Reset selectedCountry and selectedState
                selectedCountry = nil
                selectedState = nil
                selectedCounty = nil
                selectedCitiesandTownsorFeature = nil

                Task { await startFetchingParcels( theContinents: false, theCountries: true,theStates: false, theCounties: false, theCitiesandTownsorFeature: false) }
            }
           
        }
        
    }
    
    var selectedCountry: parcel? {
        
        // When selectedItem is set, loadMedia is called asynchronously to process the selected media item.
        didSet {
            if let selectedCountry = selectedCountry {
                ID = selectedCountry.id
                if selectedLayerHierarchy.count < 3 {
                    selectedLayerHierarchy.append(selectedCountry.name)
                    
                }else {
                    selectedLayerHierarchy[2] = selectedCountry.name
                    selectedLayerHierarchy.removeSubrange(3..<selectedLayerHierarchy.count)
                }
                selectedState = nil
                selectedCounty = nil
                selectedCitiesandTownsorFeature = nil
                Task { await startFetchingParcels(theContinents: false, theCountries: false,theStates: true, theCounties: false, theCitiesandTownsorFeature: false) }
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
                selectedCounty = nil
                selectedCitiesandTownsorFeature = nil
                Task { await startFetchingParcels(theContinents: false, theCountries: false, theStates: false, theCounties: true, theCitiesandTownsorFeature: false) }
            }
        }
    }
    ///////////////////
    ///////////////////
    ///////////////////
    
    var selectedCounty: parcel? {
        didSet{
            if let selectedCounty = selectedCounty {
                if selectedLayerHierarchy.count < 5 {
                    selectedLayerHierarchy.append(selectedCounty.name)
                }else{
                    selectedLayerHierarchy[4] = selectedCounty.name
                    selectedLayerHierarchy.removeSubrange(5..<selectedLayerHierarchy.count)
                }
                
                selectedCitiesandTownsorFeature = nil
                Task { await startFetchingParcels(theContinents: false, theCountries: false, theStates: false, theCounties: false, theCitiesandTownsorFeature: true) }
            }
        }
    }
    var selectedCitiesandTownsorFeature: parcel? {
        didSet {
            if let selectedCitiesandTownsorFeature = selectedCitiesandTownsorFeature {
                if selectedLayerHierarchy.count < 6 {
                    selectedLayerHierarchy.append(selectedCitiesandTownsorFeature.name)
                }else {
                    selectedLayerHierarchy[5] = selectedCitiesandTownsorFeature.name
                    selectedLayerHierarchy.removeSubrange(6..<selectedLayerHierarchy.count)
                }
                Task { await startFetchingParcels(theContinents: false, theCountries: false, theStates: false, theCounties: false, theCitiesandTownsorFeature: false) }
            }
        }
    }
    
    
    // State variables to hold the list of decoded parcels
    var continents: [parcel] = []
//    var theContinents: Bool = false
    var countries: [parcel] = []
    var states: [parcel] = []
    var counties: [parcel] = []
    var CitiesandTownsorFeature: [parcel] = []
    var selectedLayerHierarchy: [String] = ["all"]
    var ID: String = ""
    
    func startFetchingParcels(theContinents: Bool, theCountries: Bool, theStates:Bool, theCounties: Bool, theCitiesandTownsorFeature: Bool) async {
        // Ensure the URL is valid
        guard let url = URL(string: "http://:3000/get-parcels?getParcel=\(selectedLayerHierarchy)") else {
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
                    }else if theCounties {
                        self.counties = decodedParcels
                    }else if theCitiesandTownsorFeature {
                        self.CitiesandTownsorFeature = decodedParcels
                    }
                }
            }
        } catch {
            // Print any error that occurs during the network request or decoding
            print("Failure: \(error.localizedDescription)")
        }
    }
}
