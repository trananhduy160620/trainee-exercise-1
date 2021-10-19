//
//  ProductionCountry.swift
//  MovieTheater
//
//  Created by duytran on 10/19/21.
//

import Foundation
import RealmSwift

class ProductionCountry :Object, Codable {
    @Persisted var iso31661 : String?
    @Persisted var name : String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name = "name"
    }
}
