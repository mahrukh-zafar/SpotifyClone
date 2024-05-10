//
//  Song.swift
//  Spotify-Clone
//
//  Created by Dev on 10/05/2024.
//

import Foundation
import FirebaseFirestore

struct Song{
    let name: String?
    let url: String?
    let source : String?
     
      init(snapshot: QueryDocumentSnapshot) {
             
              let snapshotValue = snapshot.data()
          
              name = snapshotValue["name"] as? String
          source = snapshotValue["source"] as? String
          url = snapshotValue["url"] as? String
          }
      init(){
          name = ""
          source = ""
          url = ""
        
      }
}
