//
//  addEandHButtonView.swift
//  Evanddays
//
//  Created by David on 5/14/24.
//
import Foundation
import SwiftUI
import PhotosUI // Provides access to the Photos library, enabling photo and video selection.

struct addEandHButtonView: View {
    @State private var model = createEvent()
    @State private var media = addVideoOrPhotos()
    @AppStorage("username") var username: String = ""
    

    var body: some View {
        
        NavigationStack{
            Form{
                Section("Event Name:"){
                    TextField("", text: $model.eventName)
                }
                Section(""){
                    PhotosPicker("hello", selection: $media.selectedItem, matching: .any(of:[.videos, .images]))
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
                    Button("Upload Media") {
                        Task {
                            await media.uploadMediaData()
                        }
                    }
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



//
//Task {
//    if let mediaData = model.mediaData {
//        do {
//            try await uploadMedia(fileData: mediaData, fileName: "media.mov", mimeType: "video/quicktime")
//        } catch {
//            print("Media upload failed with error: \(error)")
//        }
//    }
//}



//func uploadMedia(fileData: Data, fileName: String, mimeType: String) async throws {
//    let boundary = UUID().uuidString
//    var request = URLRequest(url: URL(string: "https://reqres.in/api/upload")!)
//    request.httpMethod = "POST"
//    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//    var body = Data()
//    body.append("--\(boundary)\r\n".data(using: .utf8)!)
//    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//    body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
//    body.append(fileData)
//    body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//    request.httpBody = body
//
//    let (data, response) = try await URLSession.shared.upload(for: request, from: body)
//
//    if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
//        print("Media upload successful")
//    } else {
//        print("Media upload failed with response: \(response)")
//    }
//}
