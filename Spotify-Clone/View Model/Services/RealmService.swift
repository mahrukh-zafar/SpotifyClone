//
//  Service.swift
//  Notes
//
//  Created by Dev on 16/04/2024.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case unableToSaveCategories
    case unableToGetRealmObject
    case unableToDeleteCategory
    case unableToStore(Object)
}

class RealmService {
    //why this syntax? what is code smell?
   
    
    func getRealmObject() -> Realm? {
        do {
            return try Realm()
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func save(_ object : Object) throws {
        
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
        
        do{
            print("writing artist")
            try realm.write {
                realm.add(object)
                
            }
        }catch{
            
            throw RealmError.unableToSaveCategories
        }
    }
    
    
    /*
     
     Error Handling by two ways
     thorws
     result
     
     */
    
    
    func load<T: Object>(for type: T.Type) throws -> Results<T>? {
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
        return realm.objects(type)
    }
    
    
    
    func saveSong(song: SongRealm, artist: ArtistRealm) throws {
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
       
        do{

            try realm.write {
                artist.songs.append(song)
            }
        }catch{

            throw RealmError.unableToSaveCategories
        }
    }
    
    
//    func delete(_ object : Object) throws {
//        guard let name = object.value(forKey: "name") else{
//            print("error")
//            return
//        }
//
//
//        guard let realm = getRealmObject() else {
//            throw RealmError.unableToGetRealmObject
//        }
//
//
//        do {
//
//            try realm.write {
//
//                realm.delete(realm.objects(FavoriteSong.self).filter("name=%@",name))
//
//            }
//
//        } catch {
//            throw RealmError.unableToDeleteCategory
//
//        }
//    }
    
    func delete<T: Object>(_  object : Results<T>) throws {
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
        
        
        do {
        
                    try realm.write {
        
                        realm.delete(object)
        
                    }
        
                } catch {
                    throw RealmError.unableToDeleteCategory
        
                }
        
    }
    
    func getSongsByArtist(artist: ArtistRealm) throws {
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
        
        if let artist = realm.objects(ArtistRealm.self).filter("name = %@", artist.name).first {
                // Once you have the artist, you can access their songs

            print(artist.songs)
                //return artist.songs
            } else {
                // Artist not found
                print("Artist not found")
                //return nil
            }
        
        print(artist.songs)
        
    }
    
 

}
