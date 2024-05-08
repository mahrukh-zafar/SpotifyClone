//
//  HomeViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation

struct HomeViewModel{
    
    let firebaseManager = FirebaseManager()
    
    let networkManager = NetworkManager()
    
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
    
    
}
