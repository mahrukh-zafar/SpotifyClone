//
//  PlayListViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import Foundation
import RealmSwift

struct  PlayListViewModel{
    
//    let networkManager = NetworkManager()
//    let firebaseManager = FirebaseManager()
//    let realmManager = RealmManager()
    
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        NetworkManager.shared.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    
}
