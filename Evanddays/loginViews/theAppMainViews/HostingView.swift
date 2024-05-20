//
//  HostingView.swift
//  Evanddays
//
//  Created by David on 5/19/24.
//


import SwiftUI

struct HostingView: View {
    // State variable to hold the list of active events
    @State private var activeEvents = ["Event 1", "Event 2", "Event 3"]
    
    var body: some View {
        VStack {
            // Title
            Text("Hosting")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
            
            // List of active events
            ForEach(activeEvents.indices, id: \.self) { index in
                HStack {
                    Text(activeEvents[index])
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(maxWidth: .infinity)
                        .border(Color.white)
                    
                        .cornerRadius(30)
                    
                    Spacer()
                    
                    // Delete button for each event
                    Button(action: {
                        // Action to remove an event
                        activeEvents.remove(at: index)
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
            }
            
            // Add button to add new events
            Button(action: {
                // Action to add a new event
                activeEvents.append("Event \(activeEvents.count + 1)")
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add Event")
                }
                .foregroundColor(.green)
            }
            .padding()
        }
        .background(Color.black)
        .frame(maxWidth: .infinity)
        .border(Color.white)
        .cornerRadius(30)
        .shadow(radius: 40)
        
    
    }
    
}

struct HostingView_Previews: PreviewProvider {
    static var previews: some View {
        HostingView()
    }
}
