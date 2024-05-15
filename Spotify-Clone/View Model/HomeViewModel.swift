//
//  HomeViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation
import RealmSwift

struct HomeViewModel{
    //
    //    let firebaseManager = FirebaseManager()
    //
    //    let networkManager = NetworkManager()
    //
    //    let realmManager = RealmManager()
    
    func getArtists() async -> [Artist] {
        let  artists = await FirebaseManager.shared.getArtists()
        return artists
    }
    
    func refresh() async -> [Artist]{
        var  artists = await FirebaseManager.shared.getArtists()
        artists.sort(){
            $0.createdAt! > $1.createdAt!
        }
        return artists
    }
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void) {
        
        NetworkManager.shared.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    
    
    func  loadArtists() -> [ArtistRealm]?{
        var artistList = [ArtistRealm]()
        do{
            try RealmManager.shared.load(for: ArtistRealm.self)?.forEach({ artist in
                
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
   
}

