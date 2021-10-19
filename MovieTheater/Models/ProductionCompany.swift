//
//  ProductCompany.swift
//  MovieTheater
//
//  Created by duytran on 10/19/21.
//

import Foundation
import RealmSwift

class ProductionCompany : Object, Codable {

    @Persisted var id : Int?
    @Persisted var logoPath : String?
    @Persisted var name : String?
    @Persisted var originCountry : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
}
