//
//  PlaySongModelView.swift
//  Spotify-Clone
//
//  Created by Dev on 10/05/2024.
//

import Foundation
import RealmSwift

class  PlaySongViewModel{
    
    let networkManager = NetworkManager()
 let realmManager = RealmService()
    
    var favSongs = [FavoriteSong]()
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    func favorite(_ song: SongRealm) {
        let favSong = FavoriteSong()
        favSong.name = song.name
        favSong.url = song.url
        favSong.source = song.source
        
        do{
        try realmManager.save(favSong)
        }
        catch{
            
        }
        
    }
    
    func unfavorite(_ song : SongRealm){
        
        do{
            
            let result = try realmManager.load(for: FavoriteSong.self)?.filter("name=%@",song.name)
          
            if let songToDelete = result{
            try realmManager.delete(songToDelete)
            }
            
        }
        catch{
            
        }
    }
    
    func getAllFavorites(){
      
        do{
            let result =   try realmManager.load(for: FavoriteSong.self)?.forEach({ song in
                favSongs.append(song)
            })
         
        }
        catch{
            
        }
    }
     
    func isFavorite( songName : String) -> Bool?{
        do{
       let result  = try realmManager.load(for: FavoriteSong.self)?.filter("name=%@",songName)
            let obj = result?.first
            if obj != nil{
                print("returning true")
                return true
            }
            else{
                print("return false")
                return false
            }
//           let found =  favSongs.contains(where: {$0.name.capitalized == songName.capitalized})
//
//          // let result = try realmManager.load(for: FavoriteSong.self)?.filter("name=@%", songName)
//            return found
        }
        catch{
            return nil
        }
    }
    
}
