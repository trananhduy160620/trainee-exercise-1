//
//  Genres.swift
//  MovieTheater
//
//  Created by duytran on 10/14/21.
//

import Foundation
import RealmSwift

class Genre :Object, Codable {
    @Persisted var id : Int?
    @Persisted var name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
