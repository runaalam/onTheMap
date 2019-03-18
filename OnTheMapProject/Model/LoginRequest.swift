//
//  LoginRequest.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 2/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let account: Account
    let session: Session
    
    enum codingKeys: String, CodingKey {
        case account
        case session
    }
}
