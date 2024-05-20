//
//  File.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

class FavoriteSong : Object {
    
  @Persisted(primaryKey: true) var name: String = ""
  @Persisted var  url : String = ""
  @Persisted var  source : String = ""
   
}
