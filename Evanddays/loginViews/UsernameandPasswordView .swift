//
//  UsernameandPasswordView .swift
//  Evanddays
//
//  Created by David on 4/23/24.
//

import SwiftUI

struct UsernameandPasswordView: View {
    @Bindable var signingUP: SignUpModel
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Create "){
                    TextField("Enter UserName", text: $signingUP.userName)

                }
                Section(""){
                    SecureField("Enter Password", text: $signingUP.password)
                    SecureField("Confirm Password", text: $signingUP.password)
                }
                Section("Email"){
                    TextField("Email Address", text: $signingUP.email)
                    TextField("Confirm Email Address", text: $signingUP.email)
                }
                Section("#"){
                    TextField("Phone Number", text: $signingUP.phoneNumber)
                }
                Section("Last step") {
                    NavigationLink("Confirm details"){
                        ConfirmDetailsView(signingUP:signingUP)
                        
                        
                    }
                    
                }
                
            }
            
        }
    }
}

#Preview {
    UsernameandPasswordView(signingUP: SignUpModel())
}
