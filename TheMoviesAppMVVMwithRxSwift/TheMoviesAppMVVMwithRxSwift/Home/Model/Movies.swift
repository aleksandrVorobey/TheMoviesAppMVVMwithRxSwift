//
//  Movies.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 14.05.2024.
//

import Foundation

struct Movies: Codable {
    let listOfMovies: [Movie]
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let popularity: Double
    let movieId: Int
    let voteCount: Int
    let originalTitle: String
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let image: String

        enum CodingKeys: String, CodingKey {
            case title
            case popularity
            case movieId = "id"
            case voteCount = "vote_count"
            case originalTitle = "original_title"
            case voteAverage = "vote_average"
            case overview
            case releaseDate = "release_date"
            case image = "poster_path"
        }
}
