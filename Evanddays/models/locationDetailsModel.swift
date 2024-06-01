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
        didSet { Task {  await startFetchingParcels(Query: selectedContinent?.name ?? "empty") } }
    }
    // State variable to hold the list of decoded continents
    var parcels: [parcel] = []
    
    
    
    func startFetchingParcels(Query: String) async {
        // Ensure the URL is valid
        guard let url = URL(string: "http://10.1.10.126:3000/get-parcels?getParcel=\(Query)") else {
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
            // Check if the decoded response contains continents
            if let continentsDict = decodedResponse.parcels {
                // Transform the continents dictionary into an array of Continent objects
                let decodedContinents = continentsDict.map { parcel(id: $0.value, name: $0.key) }
                // Update the state variable 'continents' on the main thread
                DispatchQueue.main.async {
                    self.parcels = decodedContinents
                }
            }
        } catch {
            // Print any error that occurs during the network request or decoding
            print("Failure: \(error.localizedDescription)")
        }
    }
    
}
