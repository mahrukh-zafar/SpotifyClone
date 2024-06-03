//
//  SongRealm.swift
//  Spotify-Clone
//
//  Created by Dev on 13/05/2024.
//

import Foundation
import RealmSwift

class SongRealm : Object{
    
    @Persisted var name: String = ""
    @Persisted var  url : String = ""
    @Persisted var  source : String = ""
    @Persisted(originProperty: "songs") var parentArtistRealm: LinkingObjects<ArtistRealm>
    
}
