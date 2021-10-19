//
//  Movie.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import Foundation
import RealmSwift

class Movie:Object, Codable {
    @Persisted var adult : Bool?
    @Persisted var backdropPath : String?
    @Persisted var movieItem : MovieItem?
    @Persisted var budget : Int?
    @Persisted var genres : List<Genre>
    @Persisted var homepage : String?
    @Persisted(primaryKey: true) var id : Int?
    @Persisted var imdbId : String?
    @Persisted var originalLanguage : String?
    @Persisted var originalTitle : String?
    @Persisted var overview : String?
    @Persisted var popularity : Float?
    @Persisted var posterPath : String?
    @Persisted var productionCompanies : List<ProductionCompany>
    @Persisted var productionCountries : List<ProductionCountry>
    @Persisted var releaseDate : String?
    @Persisted var revenue : Int?
    @Persisted var runtime : Int?
    @Persisted var spokenLanguages : List<SpokenLanguage>
    @Persisted var status : String?
    @Persisted var tagline : String?
    @Persisted var title : String?
    @Persisted var video : Bool?
    @Persisted var voteAverage : Float?
    @Persisted var voteCount : Int?
    @Persisted var isFavor:Bool = false
    @Persisted var inWatchList: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case movieItem = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

