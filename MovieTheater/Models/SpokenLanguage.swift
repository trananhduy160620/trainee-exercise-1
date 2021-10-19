//
//  SpokenLanguage.swift
//  MovieTheater
//
//  Created by duytran on 10/19/21.
//

import Foundation
import RealmSwift

class SpokenLanguage :Object, Codable {
    @Persisted var englishName : String?
    @Persisted var iso6391 : String?
    @Persisted var name : String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name = "name"
    }
}
