//
//  ServiceManager.swift
//  MovieTheater
//
//  Created by duytran on 10/6/21.
//

import UIKit
import RealmSwift

class MovieServiceManager {
    static let shared = MovieServiceManager()
    
    private init() {
        
    }
    
    public func fetchMovieByID(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=5ffcc41ffa430808bbb42b1c7070a6b1"
        guard let url = URL(string: urlString) else { return  }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                guard let json = jsonData as? [String:Any] else { return }
                let movie = Movie(json: json)
                completion(.success(movie))
                
            }catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    public func fetchMovieByIDs(moviesID: [Int], completion: @escaping (Result<[Movie], Error>) -> Void) {
        var tempMovies = [Movie]()
        let dispatchGroup = DispatchGroup()
        for id in moviesID {
            dispatchGroup.enter()
            fetchMovieByID(id: id) { (result) in
                switch result {
                case .success(let movie):
                    tempMovies.append(movie)
                case .failure(let error):
                    completion(.failure(error))
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(.success(tempMovies))
        }
    }
}

