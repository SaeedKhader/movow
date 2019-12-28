//
//  Credits.swift
//  movow
//
//  Created by Saeed Khader on 20/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation

struct Credits: Codable {
    
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Codable {
    let castId: Int?
    let character:String
    let creditId: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
    }
}

struct Crew: Codable {
    let creditId: String
    let department:String
    let gender: Int?
    let id: Int
    let job: String
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case creditId = "credit_id"
        case department
        case gender
        case id
        case job
        case name
        case profilePath = "profile_path"
    }
}
