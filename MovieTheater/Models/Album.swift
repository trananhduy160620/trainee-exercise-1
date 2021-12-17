//
//  Album.swift
//  MovieTheater
//
//  Created by duytran on 12/13/21.
//

import Foundation
import RealmSwift
class Album:Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name:String
    @Persisted var imageName:String
    
    convenience init(id:UUID, name:String, imagename:String = "folder") {
        self.init()
        self.id = id
        self.name = name
        self.imageName = imagename
    }
}
