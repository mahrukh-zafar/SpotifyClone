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

class RealmManager {
    //why this syntax? what is code smell?
   static let shared = RealmManager()
    
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
        
          
            try realm.write {
                realm.add(object, update: .modified)
                
            }
            
        }catch{
            
            //throw RealmError.unableToSaveCategories
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
    
    func updateObject<T: Object>(_ object: T, with dictionary: [String: Any]) throws {
        
        guard let realm = getRealmObject() else {
            throw RealmError.unableToGetRealmObject
        }
        
        realm.writeAsync {
            for (key, value) in dictionary {
                //  print , p , po for debugging
            
                object.setValue(value, forKey: key)
                
            }
        }
    }
  

}
