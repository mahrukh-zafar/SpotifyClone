//
//  LoginViewModel.swift
//  Spotify-Clone
//
//  Created by Dev on 02/05/2024.
//

import UIKit

class LoginViewModel{
    
    let firebaseManager : FirebaseManager = FirebaseManager()
    
    func login(email: String, password: String, onComplete: @escaping (Bool)-> Void){
        
        firebaseManager.loginWithEmail(email: email, password: password, completion: onComplete)
    }
    
    func authenticateWithGoogle(viewController: UIViewController, onComplete: @escaping (Bool)-> Void){
        
        firebaseManager.authenticateWithGoogle(viewController: viewController) { (result) in
            onComplete(result)
        }
        
    }
    
    func authenticateWithFacebook(tokenString: String, onComplete: @escaping (Bool)-> Void){
        firebaseManager.authenticateWithFacebook(tokenString: tokenString, onComplete: onComplete)
    }
    
    func addToFirestore(){
        firebaseManager.addDataToFirestore()
    }
    
}
