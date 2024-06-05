//
//  locationDetailsView.swift
//  Evanddays
//
//  Created by David on 5/29/24.
//

import SwiftUI

struct locationDetailsView: View {
    @Bindable var model: createEvent
    @Bindable var media: addVideoOrPhotos
    @AppStorage("username") var username: String = ""
    var body: some View {
        NavigationStack{
            Form{
                Section(header: Text("Select a Continent")) {
                    Picker("Continents", selection: $model.selectedContinent) {
                        // Loop through the continents and create a Text view for each
                        ForEach(model.continents) { continent in
                            Text(continent.name).tag(continent as parcel?)
                        }
                    }
                    // Section to display the Picker for countries if a continent is selected
                    if model.selectedContinent != nil{
                            Picker("Countries", selection: $model.selectedCountry) {
                                // Loop through the countries and create a Text view for each
                                ForEach(model.countries) { country in
                                    Text(country.name).tag(country as parcel?)
                                }
                            }
                    }
                    
                    if var selectedCountry = model.selectedCountry {
                            Picker("States", selection: $model.selectedState) {
                                // Loop through the countries and create a Text view for each
                                ForEach(model.states) { state in
                                    Text(state.name).tag(state as parcel?)
                                }
                            }
                    }

                }
                Section{
                    Toggle("Use Address", isOn: $model.useAddress)
                    if model.useAddress {
                        TextField("Street Addres", text: $model.streetAddress)
                        TextField("Zip Code", text: $model.zipCode)
                    }
                }.disabled(false)
                Section{
                    Toggle("Use Coordinates", isOn: $model.useCoordinates)
                    if model.useCoordinates {
                        TextField("", text: $model.latitude)
                        TextField("", text: $model.longitude)
                    }
                }
                Section{
                    NavigationLink("confirm Details"){
                        confirmEventDetailsView(model:model, media:media)
                    }
                    .disabled(model.checker)
                }
                Section{
                    Button("send") {
                      
                        Task {
                            model.userName = username
                            
                            await model.sendDetails()
                        }
                    }
                }
            }
            .navigationTitle("Continent Picker")
        }
        .task {
            // Fetch the continents when the view appears
            
            await model.startFetchingParcels(theContinents: true, theCountries: false, theStates: false)
        }
    }
}

#Preview {
    locationDetailsView(model: createEvent(), media: addVideoOrPhotos())
}


