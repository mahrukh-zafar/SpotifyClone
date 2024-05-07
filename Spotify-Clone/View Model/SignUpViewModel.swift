//
//  SignUpViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 02/05/2024.
//

import Foundation
class SignUpViewModel{
    
    let firebaseManager : FirebaseManager = FirebaseManager()
    
    func signUp(email: String, password: String, onComplete: @escaping (Bool)-> Void){
        
        firebaseManager.signUp(email: email, password: password, completion: onComplete)
    }
    
}
