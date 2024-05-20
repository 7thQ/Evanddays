//
//  confirmEventDetailsView.swift
//  Evanddays
//
//  Created by David on 5/18/24.
//

//import PhotosUI // Provides access to the Photos library, enabling photo and video selection.
import SwiftUI // Provides the UI framework for building views in Swift.
import AVKit // Provides the framework for video playback, including AVPlayer and VideoPlayer.
/*import UniformTypeIdentifiers*/ // Provides the framework for identifying and handling different media types.


struct confirmEventDetailsView: View {
    var model: createEvent
    var media: addVideoOrPhotos

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Event Details")
                    .font(.title)
                    .padding(.bottom, 10)
                
                Group {
                    Text("Event Name:")
                        .font(.headline)
                    Text(model.eventName)
                        .font(.body)
                }

                Group {
                    Text("Features:")
                        .font(.headline)
                    ForEach(model.features, id: \.id) { feature in
                        Text(feature.text)
                            .font(.body)
                    }
                }

                Group {
                    Text("Start Time:")
                        .font(.headline)
                    Text(model.start.formatted())
                        .font(.body)
                }

                if model.setEnd {
                    Group {
                        Text("End Time:")
                            .font(.headline)
                        Text(model.end.formatted())
                            .font(.body)
                    }
                }

                if model.useAddress {
                    Group {
                        Text("Address:")
                            .font(.headline)
                        Text(model.streetAddress)
                            .font(.body)
                        Text(model.city)
                            .font(.body)
                        Text(model.state)
                            .font(.body)
                        Text(model.zipCode)
                            .font(.body)
                    }
                }

                if model.useCoordinates {
                    Group {
                        Text("Coordinates:")
                            .font(.headline)
                        Text("Latitude: \(model.latitude)")
                            .font(.body)
                        Text("Longitude: \(model.longitude)")
                            .font(.body)
                    }
                }
                Group {
                    Text("Video/Photo:")
                        .font(.headline)
                    
                    // Checks if there is media data and determines how to display it.
                    if let mediaData = media.mediaData, let mediaType = media.mediaType {
                        if mediaType == .movie, let mediaURL = media.mediaURL {
                            // If the media type is a movie and a URL is available, display the video.
                            VideoPlayer(player: AVPlayer(url: mediaURL))
                                .frame(height: 300)
                        } else if mediaType == .image {
                            // If the media type is an image, create a UIImage from the data and display it.
                            if let uiImage = UIImage(data: mediaData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 300)
                            } else {
                                // If the data cannot be converted to an image, display an unsupported media type message.
                                Text("Unsupported media type")
                                    .font(.body)
                            }
                        } else {
                            // If the media type is neither image nor video, display an unsupported media type message.
                            Text("Unsupported media type")
                                .font(.body)
                        }
                    } else {
                        // If no media is selected, display a message indicating so.
                        Text("No video or photo selected")
                            .font(.body)
                    }
                }
            }
            .padding()
            .navigationTitle("Confirm Event Details")
        }
    }
}

#Preview {
    confirmEventDetailsView(model: createEvent(), media: addVideoOrPhotos())
}
