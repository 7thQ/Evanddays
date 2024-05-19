//
//  addEandHButtonView.swift
//  Evanddays
//
//  Created by David on 5/14/24.
//

import SwiftUI

struct addEandHButtonView: View {
    @State private var model = createEvent()

    var body: some View {
        NavigationStack{
            Form{
                Section("Event Name:"){
                    TextField("", text: $model.eventName)
                }
                Section("Features") {
                    // Loop over each feature in the model's features array.
                    // Use 'enumerated()' to get both the index and the feature itself in the loop.
                    // 'id: \.element.id' uniquely identifies each feature in the list by its 'id'.
                    ForEach(Array(model.features.enumerated()), id: \.element.id) { index, feature in
                        // Display a text field for each feature.
                        // "Feature \(index + 1)" dynamically labels each text field as Feature 1, Feature 2, etc.
                        // The text field is bound to the text of each feature, allowing for interactive editing.
                        TextField("Feature \(index + 1)", text: $model.features[index].text)
                    }
                    // onDelete modifier allows for deleting a feature at a specific index in the features array.
                    // It calls the 'deleteFeature' function from the model when an item is swiped to delete.
                    .onDelete(perform: model.deleteFeature)
                    
                    // Conditionally display the 'Add Feature' button if there are fewer than 3 features.
                    if model.features.count < 3 {
                        Button(action: model.addFeature) {
                            // Button label
                            Text("Add Feature").foregroundColor(.blue)
                        }
                        // Disable the button if there are already 3 features.
                        .disabled(model.features.count >= 3)
                    }
                }
                Section{
                    DatePicker("Start time", selection: $model.start)
                    Toggle("Set End", isOn: $model.setEnd)
                    if model.setEnd {
                        DatePicker("End time", selection: $model.end)
                    }
                }
                Section{
                    Toggle("Use Address", isOn: $model.useAddress)
                    if model.useAddress {
                        TextField("", text: $model.streetAddress)
                        TextField("", text: $model.city)
                        TextField("", text: $model.state)
                        TextField("", text: $model.zipCode)
                    }
                }
                Section{
                    Toggle("Use Coordinates", isOn: $model.useCoordinates)
                    if model.useCoordinates {
                        TextField("", text: $model.latitude)
                        TextField("", text: $model.longitude)
                    }
                }
                Section{
                    NavigationLink("confirm Details"){
                        confirmEventDetailsView(model:model)
                    }
                    .disabled(model.checker)
                }
            }
            .navigationTitle("The Special Ocasion ;)")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    addEandHButtonView()
}
