//
//  APIManager.swift
//  MovieMania
//
//  Created by Thush-Fdo on 04/10/2024.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case cannotParseData
}

class APIManager {
    static func getTrendingMovies(completed: @escaping (_ result: Result<TrendingMovieModel, NetworkError>) -> Void){
        let urlString = NetworkConstant.shared.serverAddress +
        "trending/all/day?api_key=" +
        NetworkConstant.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(TrendingMovieModel.self, from: data){
                completed(.success(resultData))
            } else {
                completed(.failure(.cannotParseData))
            }
            
        }.resume()
    }
}
