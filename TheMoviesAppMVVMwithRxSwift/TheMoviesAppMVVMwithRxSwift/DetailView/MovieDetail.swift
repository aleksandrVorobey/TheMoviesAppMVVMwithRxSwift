//
//  MovieDetail.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 16.05.2024.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let imageMovie: String
    let descriptionMovie: String
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case imageMovie = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case descriptionMovie = "overview"
    }
}
