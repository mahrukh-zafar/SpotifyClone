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
    
    
    func liveSearch(searchQuery: String) -> [ArtistRealm]{
        var search_artists = [ArtistRealm]()
        
        
        for artist in artists {
            if artist.name.capitalized.contains(searchQuery.capitalized){
                search_artists.append(artist)
            }
            else{
                for song in artist.songs{
                    if song.name.capitalized.contains(searchQuery.capitalized){
                        search_artists.append(artist)
                    }
                    else{
                        if let index = search_artists.firstIndex(of: artist) {
                            search_artists.remove(at: index)
                            }
                    }
                }
                

            }
        }
        
//        if artists.contains(where: { artist in
//            if artist.name.capitalized.contains(searchQuery.capitalized){
//                search_artists.append(artist)
//                return true
//            }
//            else{
//                if let index = search_artists.firstIndex(of: artist) {
//                    search_artists.remove(at: index)
//                    }
//                return false
//            }
//        }){
//
//        }
        print(search_artists)
        //search_artists = artists
       return search_artists
    }
    
    
}
