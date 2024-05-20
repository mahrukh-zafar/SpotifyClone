//
//  FavoriteArtist.swift
//  Spotify-Clone
//
//  Created by Dev on 16/05/2024.
//

import Foundation
import RealmSwift

class FavoriteArtist : Object {
    
  @Persisted(primaryKey: true) var name: String = ""
  @Persisted var  url : String = ""
    @Persisted var  createdAt : Double = 0.0
   
}
