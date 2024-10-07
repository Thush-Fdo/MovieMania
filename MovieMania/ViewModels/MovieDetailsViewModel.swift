//
//  MovieDetailsViewModel.swift
//  MovieMania
//
//  Created by Thush-Fdo on 08/10/2024.
//

import Foundation

class MovieDetailsViewModel{
    
    var movie: Movie
    
    var movieImage: String?
    var movieTitle: String
    var desc: String
    var movieID: Int
    
    init(movie: Movie) {
        self.movie = movie
        
        self.movieID = movie.id
        self.movieTitle = movie.title ?? movie.name ?? ""
        self.desc = movie.overview ?? ""
        self.movieImage = makeImageURL(movie.backdropPath ?? "")
    }
    
    private func makeImageURL(_ imageCode: String) -> String? {
        return "\(NetworkConstant.shared.imageServerAddress)\(imageCode)"
    }
}
