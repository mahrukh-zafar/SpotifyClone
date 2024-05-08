//
//  PlayListViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation

struct  PlayListViewModel{
    
    let networkManager = NetworkManager()
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        networkManager.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
}