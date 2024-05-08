//
//  File.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import Foundation
import FirebaseFirestore


public struct Artist: Codable {

  let name: String?
  let songs: [String]?
  let url: String?
    let createdAt : Double?
    var documentId : String?

    var dictionary: [String: Any] {
        return [
            "createdAt": createdAt  ?? 0.0,
                        "name": name ?? "",
            "songs" : songs ?? [],
            "url" : url ?? ""
                ]
        }
    init(snapshot: QueryDocumentSnapshot) {
            documentId = snapshot.documentID
            let snapshotValue = snapshot.data()
        createdAt = snapshotValue["createdAt"] as? Double
            name = snapshotValue["name"] as? String
        songs = snapshotValue["songs"] as? [String]
        url = snapshotValue["url"] as? String
        }
    init(){
        name = ""
        songs = []
        url = ""
        createdAt = 0.0
        documentId = ""
    }
}

