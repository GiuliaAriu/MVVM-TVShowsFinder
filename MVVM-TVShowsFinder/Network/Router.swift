//
//  Router.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation


enum Router {
    
    case getTVShowList
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getTVShowList:
            return "/3/tv/top_rated"
        }
    }
    
    private static var page = 0
    
    var queryItems: [URLQueryItem] {
        
        let apiKey = "06c477fb6235927e8e8ea7e96b18133c"
        
        switch self {
        case .getTVShowList:
            
            //Increment number of page to fetch the next one
            Router.page += 1
            
            return [URLQueryItem(name: "api_key", value: apiKey), URLQueryItem(name: "page", value: "\(Router.page)")]
        }
    }
    
    var method: String {
        switch self {
        case .getTVShowList:
            return "GET"
        }
    }
}
