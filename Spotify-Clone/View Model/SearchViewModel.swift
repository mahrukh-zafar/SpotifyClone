//
//  SearchViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 09/05/2024.
//

import Foundation

class SearchViewModel{
    
    let firebaseManager = FirebaseManager()

    
    private var artists = [ArtistRealm]()
    private var songs = [Song]()
    
   private var searchedArtist : ArtistRealm?
    
   func getArtists() {
       do{
           try RealmManager.shared.load(for: ArtistRealm.self)?.forEach({ artist in
               
               artists.append(artist)
               
           })
           print(artists)
          
       }
       catch{
           print(error)
        
       }
    }
    
    func getLastSearched() -> ArtistRealm?{
        guard let artist = searchedArtist else{
            return nil
        }
        return artist
    }
    
    func search( searchString : String)  ->  ArtistRealm?{
       
        if  artists.contains(where: { artist in
            print(artist.name.contains(searchString))
            print(artist.name.capitalized.contains(searchString.capitalized))
            if artist.name.capitalized == searchString.capitalized{
                searchedArtist = artist
                return true
            }
            else {
                if artist.songs.contains(where: { $0.name.capitalized == searchString.capitalized}){
                    searchedArtist = artist
                    return true
                }
                else{
                    return false
                }
            }

        })
          {
              return searchedArtist
           } else {
               return nil
           }
    }
    
    
}
