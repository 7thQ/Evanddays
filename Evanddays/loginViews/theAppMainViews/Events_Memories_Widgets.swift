//
//  Events_Memories_Widgets.swift
//  Evanddays
//
//  Created by David on 5/19/24.
//

import SwiftUI



struct Events_Memories_Widgets: View {
    
    
    @State private var host = false
    var body: some View {
        
        VStack {
            Spacer()
            HStack{
                
                VStack { // Use VStack here for vertical stacking

                    Button(action: {
                        host = true
                    }) {
                        Image(systemName: "party.popper")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(8)
                    //                        .padding(.vertical) // Adjust padding as needed
                }
                .background(Color.black)
                .cornerRadius(18)
                .padding(.bottom, 10)
                .frame(width: 50) // Adjust the frame as needed
                .padding(.leading, 30) // Adjust the padding as needed
                Spacer()
            }
            .padding(.leading, -10)

            .padding(.bottom, 90)
            
        }
                .sheet(isPresented: $host) {
                    MainNavigationView()

                }
 
        
    }

}



#Preview {
    Events_Memories_Widgets()
}





