//
//  Account.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 2/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct Account: Codable {
    let registered: Bool
    let accountkey: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case accountkey = "key"
    }
    
}
