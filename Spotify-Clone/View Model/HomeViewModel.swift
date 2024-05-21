//
//  HomeViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation
import RealmSwift

class HomeViewModel{
    
    private var artistList = [ArtistRealm]()
    
    func refresh() {
  
        FirebaseManager.shared.getArtists(onComplete: {
            
        })
    }
   
    func  loadArtists() {
        do{
            try RealmManager.shared.load(for: ArtistRealm.self)?.forEach({ artist in
                
                artistList.append(artist)
                
            })
           
        }
        catch{
            print(error)
            
        }
    }
    
    func getArtists() -> [ArtistRealm]{
        return artistList
    }
   
}

