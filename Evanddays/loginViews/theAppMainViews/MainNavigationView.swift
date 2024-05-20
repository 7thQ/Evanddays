//
//  MainNavigationView.swift
//  Evanddays
//
//  Created by David on 5/19/24.
//
extension View {
    func CustomStyleForBoxing() -> some View {
        self.modifier(CustomStyleModifier())
    }
}

struct CustomStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .background(Color.white) // .opacity(0.9) is optional
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .padding(.bottom, 35)
            .shadow(color: Color.black.opacity(0.95), radius: 3, x: 0, y: 0)
    }
}


import SwiftUI

struct MainNavigationView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isLoggedIn") // Reset the login flag
                }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                }
                NavigationLink(destination:  addEandHButtonView()) {
                    Text("Host Something Fun! ")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                
                
                .CustomStyleForBoxing()
                
            
                .cornerRadius(10)
                
            
                NavigationLink(destination: HostingView()) {
                    Text("Currently Hosting")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .CustomStyleForBoxing()
                .cornerRadius(0)
//                gang()
//                bang()
                
            }
          
            


         
        }
    }
}


#Preview {
    MainNavigationView()
}


