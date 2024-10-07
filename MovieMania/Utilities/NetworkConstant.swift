//
//  NetworkConstant.swift
//  MovieMania
//
//  Created by Thush-Fdo on 04/10/2024.
//

import Foundation

class NetworkConstant{
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        //singleton
    }
    
    public var apiKey: String {
        get {
            return "6f60caeef70cc80967dede949df69bcb"
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerAddress: String {
        get {
            return "https://image.tmdb.org/t/p/w500/"
        }
    }
}
