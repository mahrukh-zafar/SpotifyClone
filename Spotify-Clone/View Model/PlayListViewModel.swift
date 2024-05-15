//
//  PlayListViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

struct  PlayListViewModel{
    
    let networkManager = NetworkManager()
    let firebaseManager = FirebaseManager()
    let realmManager = RealmService()
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    func getSongs(artistName: String) async -> [Song] {
        
      let songs =  await firebaseManager.getSongs(artistName: artistName)
        return songs
    }
    
    func loadSongs(artistName : ArtistRealm) -> List<SongRealm>{
        
        let songs = artistName.songs
        print(songs)
        return songs
    }
    
    func getSongsByArtist(artist: ArtistRealm){
        do{
        try realmManager.getSongsByArtist(artist: artist)
        }
        catch{

        }
       
    }
    
    func syncPlayListFromFirebase(artist: ArtistRealm) async {
       let songs = await firebaseManager.getSongs(artistName: artist.name)
        print(songs)
        songs.forEach { song in
            let songRealm = SongRealm()
            songRealm.name =  song.name!
            songRealm.url =  song.url!
            songRealm.source = song.source!
            do{
                try realmManager.saveSong(song: songRealm, artist: artist)
            }
            catch{
                
            }
        
        }
    }
    
}
