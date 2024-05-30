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
                Section{
                    Toggle("Use Address", isOn: $model.useAddress)
                    if model.useAddress {
                        TextField("", text: $model.streetAddress)
                        TextField("", text: $model.city)
                        TextField("", text: $model.state)
                        TextField("", text: $model.zipCode)
                        TextField("continent", text: $model.continent)
                        TextField("country", text: $model.country)
                    }
                }.disabled(true)
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
        }
    }
}

#Preview {
    locationDetailsView(model: createEvent(), media: addVideoOrPhotos())
}
