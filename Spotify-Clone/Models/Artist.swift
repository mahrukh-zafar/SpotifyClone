//
//  File.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation
import FirebaseFirestore


public struct Artist{

  let name: String?
  let url: String?
    let createdAt : Double?
    var documentId : String
    
    init(snapshot: QueryDocumentSnapshot) {
            documentId = snapshot.documentID
            let snapshotValue = snapshot.data()
        createdAt = snapshotValue["createdAt"] as? Double
            name = snapshotValue["name"] as? String
       
        url = snapshotValue["url"] as? String
        }
    init(){
        name = ""
        url = ""
        createdAt = 0.0
        documentId = ""
    }
}



