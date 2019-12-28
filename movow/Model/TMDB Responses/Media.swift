//
//  Media.swift
//  MovoW
//
//  Created by Saeed Khader on 18/12/2019.
//  Copyright © 2019 Saeed Khader. All rights reserved.
//

import Foundation

struct Media: Codable, Equatable {
    
    let posterPath: String?
    let poster: Data?
    let overview: String
    let releaseDateForMovie: String?
    let firstAirDateForTV: String?
    let genreIds: [Int]
    let id: Int
    let title: String?
    let name: String?
    let voteCount: Int
    let voteAverage: Double
    
    var releaseYearForMovie: String {
        return String(releaseDateForMovie?.prefix(4) ?? "unknown")
    }
    
    var releaseYearForTV: String {
        return String(firstAirDateForTV?.prefix(4) ?? "unknown")
    }
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case poster
        case overview
        case releaseDateForMovie = "release_date"
        case firstAirDateForTV = "first_air_date"
        case genreIds = "genre_ids"
        case id
        case title
        case name
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}
