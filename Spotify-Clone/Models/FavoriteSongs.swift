//
//  File.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

class FavoriteSong : Object {
    
  @objc dynamic var name: String = ""
  @objc dynamic var  url : String = ""
   @objc dynamic var  source : String = ""
   
}
