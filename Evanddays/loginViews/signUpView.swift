//
//  signUpView.swift
//  Evanddays
//
//  Created by David on 4/23/24.
//

import SwiftUI

struct signUpView: View {
    @State private var signingUP = SignUpModel()
   
   
  
    
    
    var body: some View {
 
                NavigationStack{
                    Form{

                        Section("Basic info"){
                            TextField("First Name", text: $signingUP.firstName)
                            TextField("Last Name", text: $signingUP.lastName)

                        }

                        Section("Address"){
                            TextField("Street Address", text: $signingUP.streetAddress)
                            TextField("Apt/Unit number optinal", text: $signingUP.unit)
                            TextField("city", text: $signingUP.city)
                            TextField("State", text: $signingUP.state)
                            TextField("Zip Code", text: $signingUP.zip)
                           
                        }
                        Section(""){
                            DatePicker("Date of birth", selection: $signingUP.dateOfBirth, displayedComponents: .date)

                        }
                        
                        
                        Section("Create"){
                            NavigationLink("Username and Password"){
                                UsernameandPasswordView(signingUP: signingUP)
                            }
                            
                            
                        }
                    }// end of form
                    
        
        }//end of stack
                
    }
}

#Preview {
    signUpView()
}
