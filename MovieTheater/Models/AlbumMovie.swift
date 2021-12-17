//
//  AlbumMovie.swift
//  MovieTheater
//
//  Created by duytran on 12/13/21.
//

import Foundation
import RealmSwift
class AlbumMovie:Object {
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var album: Album?
    @Persisted var movies:List<Movie>
    
    convenience init(id: UUID, album:Album, movies:List<Movie>) {
        self.init()
        self.id = id
        self.album = album
        self.movies = movies
    }
}
