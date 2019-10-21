//
//  NetworkError.swift
//  MVVM-TVShowsFinder
//
//  Created by Giulia Ariu on 20/10/2019.
//  Copyright © 2019 Giulia Ariu. All rights reserved.
//


enum NetworkError : Error {
  case domainError
  case decodingError
  case urlError
  case dataError
  case error
}
