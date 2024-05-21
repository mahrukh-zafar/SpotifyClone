//
//  PlayListViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

struct  PlayListViewModel{

    func favorite(_ artist: ArtistRealm) {
        let favArtist = FavoriteArtist()
        favArtist.name = artist.name
        //favArtist.url = artist.url
        favArtist.createdAt = artist.createdAt
        
        do{
            try RealmManager.shared.save(favArtist)
        }
        catch{
            
        }
        
    }
    
    func unfavorite(_ artist : ArtistRealm){
        
        do{
            
            let result = try RealmManager.shared.load(for: FavoriteArtist.self)?.filter("name=%@",artist.name)
          
            if let artistToDelete = result{
                try RealmManager.shared.delete(artistToDelete)
            }
            
        }
        catch{
            
        }
    }
    
    func isFavorite( artistName : String) -> Bool?{
        do{
            let result  = try RealmManager.shared.load(for: FavoriteArtist.self)?.filter("name=%@",artistName)
            let obj = result?.first
            if obj != nil{
                print("returning true")
                return true
            }
            else{
                print("return false")
                return false
            }
        }
        catch{
            return nil
        }
    }
    
    
}
