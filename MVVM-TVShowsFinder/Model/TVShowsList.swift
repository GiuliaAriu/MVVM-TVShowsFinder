//
//  TVShowsList.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//


struct TVShowsList: Decodable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [TVShow]
}
