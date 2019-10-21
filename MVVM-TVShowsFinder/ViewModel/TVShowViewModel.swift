//
//  TVShowViewModel.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation

struct TVShowViewModel {
    
    let posterPath: URL?
    let name: String
    let overview: String
    let voteAverage: Float
    let firstAirDate: String
    
    init (tvShow: TVShow) {
        let baseURL = "https://image.tmdb.org/t/p/w300/"
        
        self.posterPath = URL(string: baseURL + tvShow.posterPath)
        self.name = tvShow.name
        self.overview = tvShow.overview
        self.voteAverage = tvShow.voteAverage
        self.firstAirDate = tvShow.firstAirDate
    }
}
