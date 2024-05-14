//
//  HomeViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation
import RealmSwift

struct HomeViewModel{
    
    let firebaseManager = FirebaseManager()
    
    let networkManager = NetworkManager()
    
    let realmManager = RealmService()
    
    func getArtists() async -> [Artist] {
      let  artists = await firebaseManager.getArtists()
        return artists
    }
    
    func refresh() async -> [Artist]{
        var  artists = await firebaseManager.getArtists()
        artists.sort(){
            $0.createdAt! > $1.createdAt!
        }
          return artists
    }
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void) {
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    func getSongs( artistName : String) async -> [Song]{
       return await firebaseManager.getSongs(artistName: artistName)
    }
    
    func getSongsWithCompletion(artistName: String, onComplete: @escaping ([Song]) -> Void){

        firebaseManager.getSongWithCompletion(artistName: artistName, onComplete: onComplete)
    }
    
    func syncWithFirebase() async {
        let artists = await getArtists()
        
        print(artists)
        
        var artistsRealm = [ArtistRealm]()
        artists.forEach { artist in
            let artistRealm = ArtistRealm()
            artistRealm.name = artist.name!
            artistRealm.url = artist.url!
            artistRealm.createdAt = artist.createdAt!
            artistsRealm.append(artistRealm)
            do{
                try  realmManager.save(artistRealm)

            }catch{}
            
            
           
        }
    }
    
   func  loadArtists() -> [ArtistRealm]?{
       var artistList = [ArtistRealm]()
       do{
           try realmManager.load(for: ArtistRealm.self)?.forEach({ artist in
               artist.songs = loadSongs(artistName: artist)
               artistList.append(artist)
               
           })
           print(artistList)
           return artistList
       }
       catch{
           print(error)
           return nil
       }
        
    }
    func loadSongs(artistName : ArtistRealm) -> List<SongRealm>{
        let songs = artistName.songs
        return songs
    }
    
    
    
    
}

