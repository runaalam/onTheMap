//
//  Session.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 2/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct Session: Codable {
    let expiration: String
    let sessionId: String
    
    enum CodingKeys: String, CodingKey  {
        case expiration
        case sessionId = "id"
    }
}
