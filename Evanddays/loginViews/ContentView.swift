//
//  ContentView.swift
//  Evanddays
//
//  Created by David on 4/21/24.
//


import SwiftUI


struct ContentView: View {
    @AppStorage("username") var storedUsername: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    //userdefaults
    @State private var loginInfo = whoLoggedIn()
    @State private var response: Logins?
 
    //model instances
    @State private var showingconfimation = false
    @State private var showSignUpView = false
    //view booleans
    @State var backendResponse = ""
    @State private var confimationMessage = ""
    //changing view strings
    let loginResponse = "Login successful"
    //view non changing propertys
    
    
    

    var body: some View {
        ScrollView{
            VStack {
                Spacer()
                    .padding(.bottom, 250)
                TextField("Enter UserName", text: $loginInfo.userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                SecureField("Password", text: $loginInfo.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Log In") {
                    Task{
                        await valitdateUser()
                    }
                    
                    storedUsername = loginInfo.userName  // Save the username
                }.padding()
                Button("Sign UP"){
                    showSignUpView.toggle()
                }.sheet(isPresented: $showSignUpView, content: {
                    signUpView()
                })
            }//vstack end
        }//scrollview end
        .alert("results", isPresented: $showingconfimation){Button("ok"){}}message: {
            Text(confimationMessage)
        }
        .scrollBounceBehavior(.basedOnSize)
    }// body end
    
    func valitdateUser() async {
        guard let encoded = try? JSONEncoder().encode(loginInfo) else{
            print("failed")
            return 
        }//encoding the model sending over
      
        let url = URL(string: "http://192.168.1.21:3000/login")!//we are requesting from
        var request = URLRequest(url: url)//initializing the url
        request.setValue("application/json", forHTTPHeaderField: "content-Type")//configure the request
        request.httpMethod = "Post"//method obvisouly
        
        do {
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedwhoLoggedIn = try JSONDecoder().decode(Response.self, from: data)
            let dataString = String(data: data, encoding: .utf8)
            print("Received data: \(dataString ?? "nil")")
            let back = decodedwhoLoggedIn.Logins?.userName
            
            // turn backend response into string
            
            
            if storedUsername == back {
                isLoggedIn = true
                
            }else{
                showingconfimation = true
                confimationMessage = "InValid User"
                
            }
//            
            
        }catch{
            
 
            print("failed here login view:\(error.localizedDescription)")}
        
        
    }

    
}


#Preview {
    ContentView()
}

//192.168.1.22
