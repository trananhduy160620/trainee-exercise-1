//
//  Movie.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import Foundation
struct Movie {
    var id: Int
    var title:String
    var tagLine:String
    var overview:String
    var runtime:Int
    var releaseDate:String
    var posterPath:String
    var rating:Double
    var voteCount: Int
    var genres:[Genres] = []
    init(json: [String:Any] ) {
        self.id = json["id"] as! Int
        self.title = json["title"] as! String
        self.tagLine = json["tagline"] as! String
        self.runtime = json["runtime"] as! Int
        self.overview = json["overview"] as! String
        self.releaseDate = json["release_date"] as! String
        self.posterPath = json["poster_path"] as! String
        self.rating = json["vote_average"] as! Double
        self.voteCount = json["vote_count"] as! Int
        let genresJson = json["genres"] as! NSArray
        for item in genresJson {
            if let tempGenre = item as? [String:Any] {
                let id = tempGenre["id"] as! Int
                let name = tempGenre["name"] as! String
                let genre = Genres(id: id,
                                   name: name)
                self.genres.append(genre)
            }
        }
    }
    init(id: Int, title:String,
         tagLine:String, overview:String, runtime:Int, releaseDate:String,
         posterPath:String, rating:Double, voteCount:Int, genres:[Genres]) {
        self.id = id
        self.title = title
        self.tagLine = tagLine
        self.overview = overview
        self.runtime = runtime
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.rating = rating
        self.voteCount = voteCount
        self.genres = genres
    }
}
struct Genres {
    var id:Int
    var name:String
}
