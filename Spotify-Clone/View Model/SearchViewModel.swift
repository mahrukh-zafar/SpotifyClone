//
//  SearchViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 09/05/2024.
//

import Foundation

class SearchViewModel{
    
    let firebaseManager = FirebaseManager()
    let networkManager = NetworkManager()
    
    var artists = [Artist]()
    var songs = [Song]()
    
   private var searchedArtist : Artist?
    
   func getArtists() async{
      let  artists = await firebaseManager.getArtists()
        self.artists = artists
    }
    
    
    func search( searchString : String)  -> Artist? {
       
        if  artists.contains(where: { artist in
            if artist.name?.capitalized == searchString.capitalized{
                searchedArtist = artist
                return true
            }
            else {
                if artist.songs!.contains(where: { $0.capitalized == searchString.capitalized}){
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
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void) {
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
//    func searchFrom(searchString: String) -> Any? {
//        var result : Any?
//        if  artists.contains(where: { artist in
//            if artist.name?.capitalized == searchString.capitalized{
//                result = artist
//                return true
//            }
//            else {
//                if let songs = getSong(artistName: artist.name!){
//                    searchedArtist = artist
//                    return true
//                }
//                else{
//                    return false
//                }
//            }
//            
//        })
//          {
//              return searchedArtist
//           } else {
//               return nil
//           }
//    }
}
