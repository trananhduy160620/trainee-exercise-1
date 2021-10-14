//
//  Movie.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import Foundation
import RealmSwift
class Movie:Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title:String = ""
    @Persisted var tagLine:String = ""
    @Persisted var overview:String = ""
    @Persisted var runtime:Int = 0
    @Persisted var releaseDate:String = ""
    @Persisted var posterPath:String = ""
    @Persisted var rating:Double = 0
    @Persisted var voteCount: Int = 0
    @Persisted var genres:List<Genres>
    @Persisted var isFavor:Bool = false
    @Persisted var inWatchList:Bool = false
    
    convenience init(json: [String:Any] ) {
        self.init()
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
    
    convenience init(id: Int, title:String, tagLine:String, overview:String, runtime:Int,
                     releaseDate:String, posterPath:String, rating:Double, voteCount:Int, genres:List<Genres>, isFavor:Bool = false, inWatchList:Bool = false) {
        self.init()
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
        self.isFavor = isFavor
        self.inWatchList = inWatchList
    }
}

