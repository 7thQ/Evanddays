//
//  ConfirmDetailsView.swift
//  Evanddays
//
//  Created by David on 4/23/24.
//

import SwiftUI




struct ConfirmDetailsView: View {
//    @State private var response = Response()
    var message: Response?
    var signingUP: SignUpModel
    
    @State var conformationMessage = ""
    @State var diditwork = false
    @State var showView = true
    @State var HideBackButton = false
    let success = "User created successfully."

    
    var body: some View {
        ScrollView{
            
            if showView {
                Text("\(signingUP.firstName)\(signingUP.lastName)")
                Text("\(signingUP.email)")
                Text("\(signingUP.streetAddress),\(signingUP.city),\(signingUP.state),\(signingUP.zip)")
                Text("\(signingUP.dateOfBirth)")
                Text("\(signingUP.userName)")
                Text("\(signingUP.password)")
                Button("Confirm Sign Up") {
                    Task {
                        await confirmSignUP()
                    }
                }
            }else {
                Spacer()
                Text("Swipe Down and LOG IN! \(signingUP.userName) ;)")
            }
        }
        .navigationBarBackButtonHidden(HideBackButton)
        .alert("shit clipped",isPresented: $diditwork ){
            Button("ok"){}}message: {
                Text(conformationMessage)
            }

    }
        func confirmSignUP () async {
            guard let encoded = try? JSONEncoder().encode(signingUP)else {
                print("Failed")
                return
            }// encode the data we want send first
            let url = URL(string: "http://:3000/create-user")!// use the url init on the string to turn the url string into a url type data, also not that the property is const
            var request = URLRequest(url:url)// now turn the url data type into a urlrequest type with the init urlrequest, note notice taht this property is not const because below we are changing its configurations
            request.setValue("application/json", forHTTPHeaderField: "content-Type")//change the configurations, so the backend end know what we are sending and how to handle it
            request.httpMethod = "Post"// add the method type so the back end knows what we are doing
            do {
                let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
                let dataString = String(data: data, encoding: .utf8)
                print("Received data: \(dataString ?? "nil")")
//                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                     print("Manual JSON Parse: \(jsonObject)")
//                 }
                let decoded = try JSONDecoder().decode(Response.self, from: data)
           
                let serverResponse = decoded.message
             

                if serverResponse == success {
                    HideBackButton = true
                    showView = false
                }else{
                conformationMessage = "\(serverResponse ?? "error")"
                   diditwork = true
                    
                    
                }
                
                
            }catch{
                conformationMessage = "\(error.localizedDescription)"
                diditwork = true
                print("not here : \(error.localizedDescription)")
            }
        }
}

#Preview {
    ConfirmDetailsView(signingUP: SignUpModel())
}
