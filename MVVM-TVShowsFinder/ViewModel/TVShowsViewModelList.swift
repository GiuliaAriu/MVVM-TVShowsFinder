//
//  TVShowsViewModelList.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation

class TVShowsViewModelList {
    
    //Delegate that will reload tableView data once the fetch is completed
    var delegate: TVShowsViewModelListDelegate?
    
    
    private var totalPages: Int?
    private var totalResults: Int?
    var tvShows = [TVShowViewModel]()
    
    //TVshows already fetched
    var currentNumberOfTVShows : Int {
        return tvShows.count
    }
    
    private var currentPage: Int?
    var lastPageReached = false
    private let service: Service
    
    init(service: Service) {
        self.service = service
        fetchPage()
    }
    
    func fetchPage() {
        
        guard !lastPageReached else { return }
        
        service.fetchFromEndPoint(router: Router.getTVShowList) { [unowned self] (results: Result <TVShowsList?, NetworkError>) in
            
            switch results {
                
            case .failure (let error):
                print("Error while fetching results: \(error)", error)
                
            case .success:
                
                if let fetchedPage = try? results.get() {
                    
                    self.tvShows.append(contentsOf: (fetchedPage.results.map {return TVShowViewModel(tvShow: $0)}))
                    
                    self.currentPage = fetchedPage.page
                    self.totalPages = fetchedPage.totalPages
                    self.totalResults = fetchedPage.totalResults
                    
                    if self.totalPages == self.currentPage {
                        self.lastPageReached = true
                    }
                    
                    DispatchQueue.main.async {
                        self.delegate?.fetchCompleted()
                    }
                }
            }
        }
    }
}


protocol TVShowsViewModelListDelegate {
    func fetchCompleted()
}
