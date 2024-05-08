//
//  MyArtist.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation

public struct MyArtist : Codable {
    let name: String
    let url: String
    let createdAt : Double
    let songs : [String]
}
