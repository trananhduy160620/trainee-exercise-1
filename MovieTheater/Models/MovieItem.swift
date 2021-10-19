//
//  MovieItem.swift
//  MovieTheater
//
//  Created by duytran on 10/19/21.
//

import Foundation
import RealmSwift

class MovieItem :Object, Codable {

    @Persisted var backdropPath : String?
    @Persisted var id : Int?
    @Persisted var name : String?
    @Persisted var posterPath : String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
    }
}
