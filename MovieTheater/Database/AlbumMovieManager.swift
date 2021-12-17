//
//  AlbumMovie.swift
//  MovieTheater
//
//  Created by duytran on 12/16/21.
//

import UIKit
import RealmSwift
class AlbumMovieManager {
    static let shared = AlbumMovieManager()
    private let database: Realm
    private init() {
        do {
            database = try Realm()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getDatabasePath() -> String{
        return Realm.Configuration.defaultConfiguration.fileURL?.path ?? "Error: No exist database path"
    }
    
    func addAlbumMovie(albumMovie: AlbumMovie) {
        if !checkAlbumMovieExist(id: albumMovie.id) {
            do {
                try database.write {
                    database.add(albumMovie)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateAlbumMovie(albumMovie: AlbumMovie, movie:Movie) {
        if checkAlbumMovieExist(id: albumMovie.id) { // check movie exist in DB
            do {
                try database.write {
                    if checkMovieExist(in: albumMovie, movie: movie) == false {
                        let realmMovie = MovieManager.shared.fetchMovieBy(primaryKey: movie.id)
                        albumMovie.movies.append(realmMovie)
                        database.add(albumMovie, update: .modified)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAlbumMovie(albumMovie: AlbumMovie) {
        if checkAlbumMovieExist(id: albumMovie.id) {
            do {
                try database.write {
                    database.delete(albumMovie)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteMovieItem(in album:AlbumMovie, movie:Movie, at index:Int) {
        if checkAlbumMovieExist(id: album.id) {
            do {
                try database.write {
                    if checkMovieExist(in: album, movie: movie) {
                        let realmMovies = fetchMoviesInAlbumBy(primaryKey: album.id)
                        realmMovies.remove(at: index)
                        database.add(album, update: .modified)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAlbumMovieBy(primaryKey:UUID) -> AlbumMovie {
        return database.object(ofType: AlbumMovie.self, forPrimaryKey: primaryKey)!
    }
    
    func fetchMoviesInAlbumBy(primaryKey:UUID) -> List<Movie> {
        return database.object(ofType: AlbumMovie.self, forPrimaryKey: primaryKey)!.movies
    }
    
    func fetchAllAlbumMovie() -> [AlbumMovie]{
        return database.objects(AlbumMovie.self).toArray(ofType: AlbumMovie.self)
    }
    
    func checkAlbumMovieExist(id:UUID) -> Bool {
        return database.object(ofType: AlbumMovie.self, forPrimaryKey: id) != nil
    }
    
    func checkMovieExist(in watchList:AlbumMovie, movie:Movie) -> Bool {
        for movieItem in watchList.movies {
            if movieItem.id == movie.id {
                return true
            }
        }
        return false
    }
}
