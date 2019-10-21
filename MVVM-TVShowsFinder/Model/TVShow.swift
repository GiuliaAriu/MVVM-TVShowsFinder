//
//  TVShow.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//


struct TVShow : Decodable {
    
    let originalName: String
    let genreIds: [Int]
    let name: String
    let popularity: Float
    let originCountry: [String]
    let voteCount: Int
    let firstAirDate: String
    let backdropPath: String
    let originalLanguage: String
    let id: Int
    let voteAverage: Float
    let overview: String
    let posterPath: String
}
