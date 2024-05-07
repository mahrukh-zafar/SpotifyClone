//
//  Network Manager.swift
//  Spotify-Clone
//
//  Created by Dev on 06/05/2024.
//

import Foundation
import Alamofire

struct NetworkManager{
    
    
    func getImage(imageUrl : String) -> Data{
        var imageData : Data = Data()
        AF.request(imageUrl).response { response in
            if let data = response.data{
                imageData = data
            }
        }
     return imageData
    }
}
