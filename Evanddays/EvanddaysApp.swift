//
//  EvanddaysApp.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//

import SwiftUI


@main
struct EvanddaysApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
//                ProfileView()
//                mapView()
                mapView()
//                MapView()
//                mapVi()
                
            }else{
                ContentView()
            }
        }
       
    }
}
