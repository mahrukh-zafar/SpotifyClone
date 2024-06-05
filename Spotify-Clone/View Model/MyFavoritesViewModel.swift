//
//  MyFavoritesViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 05/06/2024.
//

import Foundation

class MyFavoritesViewModel{
   private var songs = [SongRealm]()
    
    func getSongs() -> [SongRealm]{

        return songs
    }
    
     func loadFavoriteSongs(){
         songs.removeAll()
        do{
           try RealmManager.shared.load(for: SongRealm.self)?.forEach({ song in
               if song.favortie{
                   songs.append(song)
               }
            })
          
        }
        catch{
            print(error)
            
        }
     
    }
}
