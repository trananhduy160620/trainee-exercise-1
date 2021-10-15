//
//  RealmManager.swift
//  MovieTheater
//
//  Created by duytran on 10/14/21.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
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
        return Realm.Configuration.defaultConfiguration.fileURL!.path
    }
    
    func addMovie(movie: Movie) {
        if !checkMovieExist(id: movie.id) {
            do {
                try database.write {
                    database.add(movie)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func update(movie: Movie, by isFavor:Bool?, in watchList:Bool?) {
        if checkMovieExist(id: movie.id) { // check movie exist in DB
            do {
                try database.write {
                    if isFavor != nil {
                        movie.isFavor = isFavor ?? false
                    }
                    if watchList != nil {
                        movie.inWatchList = watchList ?? false
                    }
                    database.add(movie, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func update(movie: Movie, in watchList:Bool) {
        let isMovieExist = checkMovieExist(id: movie.id)
        if isMovieExist { // check movie exist in DB
            do {
                try database.write {
                    movie.inWatchList = watchList
                    database.add(movie, update: .modified)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteMovie(movie: Movie) {
        let isMovieExist = checkMovieExist(id: movie.id)
        if isMovieExist {
            do {
                try database.write {
                    database.delete(movie)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchMoviesByFavorite() -> [Movie] {
        return (database.objects(Movie.self).filter("isFavor == true")).toArray(ofType: Movie.self)
    }
    
    func fetchMoviesInWatchList() -> [Movie] {
        return (database.objects(Movie.self).filter("inWatchList == true")).toArray(ofType: Movie.self)
    }
    
    func fetchAllMovie() -> [Movie] {
        return database.objects(Movie.self).toArray(ofType: Movie.self)
    }
    
    func fetchMovieBy(primaryKey:Int) -> Movie {
        return database.object(ofType: Movie.self, forPrimaryKey: primaryKey)!
    }
    
    func checkMovieExist (id: Int) -> Bool {
        return database.object(ofType: Movie.self, forPrimaryKey: id) != nil
    }
}
