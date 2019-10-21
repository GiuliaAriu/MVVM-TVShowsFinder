//
//  Service.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//

import Foundation

final class Service {
    
    private var isFetching = false
    
    var isFetchingNextPage : Bool {
        return isFetching
    }
    
    
    private func createURLSessionConfiguration () -> URLSessionConfiguration {
        
        // 500 Mb
        let fiveHundredMB = 500 * 1024 * 1024
        
        let memoryCapacity =  fiveHundredMB
        let diskCapacity = fiveHundredMB
        
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "shared_cache")
        
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = cache
        
        return configuration
    }
    
    
    private func executeFetch <T: Decodable> (urlRequest: URLRequest, completion: @escaping (Result<T?, NetworkError>) -> ()) {
        
        isFetching = true
        
        let configuration = createURLSessionConfiguration()
        
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: urlRequest) { [unowned self] (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.error))
                return
            }
            
            guard let data = data else {
                completion(.failure((.dataError)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let tvShows = try decoder.decode(T.self, from: data)
                self.isFetching = false
                
                DispatchQueue.main.async {
                    completion(.success(tvShows))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error)
            }
        }.resume()
    }
    
    
    
    func fetchFromEndPoint<T: Decodable> (router: Router, completion: @escaping (Result <T?, NetworkError>) -> ()) {
        
        var components = URLComponents()
        
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.queryItems
        
        guard let url = components.url else {
            completion(.failure(.urlError))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        executeFetch(urlRequest: urlRequest, completion: completion)
    }
}
