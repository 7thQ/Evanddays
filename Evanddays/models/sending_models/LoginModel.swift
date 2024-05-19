//
//  LoginModel.swift
//  Evanddays
//
//  Created by David on 5/16/24.
//

import Foundation

@Observable
class whoLoggedIn: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _userName = "userName"
        case _password = "password"
        
    }
    
    var userName: String = ""
    var password: String = ""

}
