//
//  ArtistRealm.swift
//  Spotify-Clone
//
//  Created by Dev on 13/05/2024.
//

import Foundation
import RealmSwift

class ArtistRealm : Object{
    
    @Persisted(primaryKey: true)  var name: String = ""
    @Persisted var  url : String?
    @Persisted var  createdAt : Double = 0.0
    @Persisted var songs = List<SongRealm>()

}



