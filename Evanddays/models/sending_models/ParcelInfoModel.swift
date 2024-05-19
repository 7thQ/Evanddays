//
//  ParcelInfoModel.swift
//  Evanddays
//
//  Created by David on 5/16/24.
//

import Foundation

@Observable
class parcelInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _ID = "ID"
        case _parcelName = "parcelName"
  
        
    }
    
    var ID: String = ""
    var parcelName: String = ""
   

}

