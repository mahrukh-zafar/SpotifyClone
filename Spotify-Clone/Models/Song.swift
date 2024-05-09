//
//  File.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

class Song : Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var  url : String = ""
    @objc dynamic var  isFavorite : Bool = false
   
}
