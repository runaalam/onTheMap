//
//  LocationListRequest.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 15/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct LocationListRequest : Codable {
    let results: [StudentInformation]
    
    enum codingKeys: String, CodingKey {
        case results
    }
}
