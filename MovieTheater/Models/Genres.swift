//
//  Genres.swift
//  MovieTheater
//
//  Created by duytran on 10/14/21.
//

import Foundation
import RealmSwift

class Genres:Object {
    @Persisted var id:Int = 0
    @Persisted var name:String = ""
    convenience init(id:Int, name:String) {
        self.init()
        self.id = id
        self.name = name
    }
}
