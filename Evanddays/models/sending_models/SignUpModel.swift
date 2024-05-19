//
//  SignUpModel.swift
//  Evanddays
//
//  Created by David on 4/23/24.
//

import Foundation


@Observable
class SignUpModel: Codable {
    enum CodingKeys: String, CodingKey {
        case _firstName = "firstName"
        case _lastName = "lastName"
        case _userName = "userName"
        case _password = "password"
        case _email = "email"
        case _streetAddress = "streetAddress"
        case _unit = "unit"
        case _city = "city"
        case _state = "state"
        case _zip = "zip"
        case _dateOfBirth = "dateOfBirth"
        case _phoneNumber = "phoneNumber"
    }
    var firstName: String = ""
    var lastName: String = ""
    var userName: String = ""
    var password: String = ""
    var email: String = ""
    var streetAddress: String = ""
    var unit: String = ""
    var city:String = ""
    var state:String = ""
    var zip:String = ""
    var dateOfBirth: Date = .now
    var phoneNumber: String = ""
    
}
