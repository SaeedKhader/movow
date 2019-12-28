//
//  TMDBResponse.swift
//  MovoW
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation

struct TMDBResponse: Codable {
    
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}


extension TMDBResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
