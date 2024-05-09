//////
//////  RealmService.swift
//////  Spotify-Clone
//////
//////  Created by Dev on 09/05/2024.
//////
////
//import Foundation
//import RealmSwift
//
//class RealmService{
//
//    let realm = try! Realm()
//    var songs  = [Song]()
//
//    func save(song: Song) {
//        do {
//            try realm.write {
//                realm.add(song)
//            }
//        } catch {
//            print("An error occurred while saving the category: \(error)")
//        }
//
//    }
//
//     func loadSongs() {
//            songs = realm.objects(Song.self)
//
//        }
//
//    func deleteFromFav(song : Song){
//        do {
//                        try realm.write {
//                            try realm.write {
//                                // Delete an item.
//                                realm.delete(song)
//                            }
//                        }
//                    } catch {
//                        print("An error occurred while deleting the item: \(error)")
//                   }
//
//    }
//
//
//}
