//
//  SongRealm.swift
//  Spotify-Clone
//
//  Created by Dev on 13/05/2024.
//

import Foundation
import RealmSwift

class SongRealm : Object{
    
   @objc dynamic var name: String = ""
     @objc dynamic var  url : String = ""
     @objc dynamic var  source : String = ""
    
    var parentArtistRealm = LinkingObjects(fromType: ArtistRealm.self, property: "songs")
  
    
    
}
