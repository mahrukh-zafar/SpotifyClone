//
//  ArtistRealm.swift
//  Spotify-Clone
//
//  Created by Dev on 13/05/2024.
//

import Foundation
import RealmSwift

class ArtistRealm : Object{
    
    @objc dynamic var name: String = ""
     @objc dynamic var  url : String = ""
   @objc dynamic var  createdAt : Double = 0.0
    var songs = List<SongRealm>()
    
}



