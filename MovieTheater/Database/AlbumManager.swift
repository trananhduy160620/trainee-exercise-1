//
//  AlbumManager.swift
//  MovieTheater
//
//  Created by duytran on 12/16/21.
//

import UIKit
import RealmSwift

class AlbumManager {
    static let shared = AlbumManager()
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
    
    func addAlbum(album: Album) {
        if !checkAlbumExist(id: album.id) {
            do {
                try database.write {
                    database.add(album)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateAlbum(album:Album, name:String?, imageName:String?) {
        if checkAlbumExist(id: album.id) {
            do {
                try database.write {
                    album.name = name ?? ""
                    album.imageName = imageName ?? ""
                    database.add(album)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAlbum(album:Album) {
        if checkAlbumExist(id: album.id) {
            do {
                try database.write {
                    database.delete(album)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAllAlbum() -> [Album]{
        return database.objects(Album.self).toArray(ofType: Album.self)
    }
    
    func checkAlbumExist(id:UUID) -> Bool {
        return database.object(ofType: Album.self, forPrimaryKey: id) != nil
    }
}
