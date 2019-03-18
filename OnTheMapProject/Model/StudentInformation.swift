//
//  StudentInformation.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 1/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaUrl: String?
    let objectId: String?
    let uniqueKey: String?
    let createdAt: String?
    let updatedAt: String?
    
    
    enum CodingKeys: String, CodingKey  {
        case firstName = "firstName"
        case lastName = "lastName"
        case latitude = "latitude"
        case longitude = "longitude"
        case mapString = "mapString"
        case mediaUrl = "mediaURL"
        case objectId = "objectId"
        case uniqueKey = "uniqueKey"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
