//
//  UserDetailsResponseModel.swift
//  Evanddays
//
//  Created by David on 5/16/24.
//

import Foundation


struct userDetails: Codable, Hashable {
    var firstName: String
    var lastName: String
    var userName: String
    var password: String
    var email: String
    var streetAddress: String
    var unit: String
    var city:String
    var state:String
    var zip:String
    var dateOfBirth: Date
    var phoneNumber: String
}

