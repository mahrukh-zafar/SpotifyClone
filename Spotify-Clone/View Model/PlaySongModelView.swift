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
    
    var favSongs: List<FavoriteSong>?
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    func favorite(_ song: Song) {
        
        let favoriteSong = FavoriteSong()
        favoriteSong.name =  song.name!
        favoriteSong.url = song.url!
        favoriteSong.source = song.source!
        do{
        try realmManager.save(favoriteSong)
        }
        catch{
            
        }
        
    }
    
    func getAllFavorites(){
        do{
            favSongs = try realmManager.load(for: FavoriteSong.Type) as? List<FavoriteSong>
        }
        catch{
            
        }
    }
    
}
