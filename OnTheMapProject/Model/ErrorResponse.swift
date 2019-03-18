//
//  ErrorResponse.swift
//  OnTheMapProject
//
//  Created by Runa Alam on 2/3/19.
//  Copyright © 2019 Runa Alam. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case errorMessage = "error"
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
}
