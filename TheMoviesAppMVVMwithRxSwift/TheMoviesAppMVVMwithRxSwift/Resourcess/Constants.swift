//
//  Constants.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 18.04.2024.
//

import Foundation

struct Constants {
    static let apiKey = "?api_key=21b6645187b681d20c7cec8d277555b7"
    
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w500"
    }
    
    struct Endpoints {
        static let urlListPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/movie/"
    }
}
