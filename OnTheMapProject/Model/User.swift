//
//  User.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 2/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let userKey: String
    let registerd: Bool
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userKey = "key"
        case registerd = "_registered"
    }
}
