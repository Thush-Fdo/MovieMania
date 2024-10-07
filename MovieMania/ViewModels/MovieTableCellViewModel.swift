//
//  MovieTableCellViewModel.swift
//  MovieMania
//
//  Created by Thush-Fdo on 07/10/2024.
//

import Foundation

class MovieTableCellViewModel{
    var id: Int
    var title: String
    var date: String
    var rating: String
    var imageUrl: String?
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title ?? movie.name ?? ""
        self.date = movie.releaseDate ?? movie.firstAirDate ?? ""
        self.rating = "\(movie.voteAverage)/10"
        self.imageUrl = makeImageURL(movie.posterPath ?? "")
    }
    
    private func makeImageURL(_ imageCode: String) -> String? {
//        URL(string: "\(NetworkConstant.shared.imageServerAddress)\(imageCode)")
        
        return "\(NetworkConstant.shared.imageServerAddress)\(imageCode)"
    }
}
