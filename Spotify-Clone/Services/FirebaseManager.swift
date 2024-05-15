//
//  FirebaseManager.swift
//  Spotify-Clone
//
//  Created by Dev on 30/04/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Alamofire
import SwiftUI


class FirebaseManager{
    
    private let db = Firestore.firestore()
    //let realmManager = RealmManager()
    static let shared = FirebaseManager()
    
    func loginWithEmail(email : String, password: String,  completion: @escaping (Bool) -> Void)  {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
           
            if let error = error as? NSError {
                print(error)
               
                completion(false)
                
            } else {
                print("User signs in successfully")
                //                let userInfo = Auth.auth().currentUser
                //                let email = userInfo?.email
               
                completion(true)
            }
            
        }
    }
    
    func loginWithCredentials(credential: AuthCredential, onComplete: @escaping (Bool) -> Void){
        Auth.auth().signIn(with: credential) { result, error in
            
            if let error = error as? NSError {
                print(error)
                onComplete(true)
            } else {
                print("User signs up successfully")
                //            let newUserInfo = Auth.auth().currentUser
                //            let email = newUserInfo?.email
                //              print(email)
                onComplete(true)
            }
        }
        
    }
    
    
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                print(error)
                completion(false)
            } else {
                print("User signs up successfully")
                //            let newUserInfo = Auth.auth().currentUser
                //            let email = newUserInfo?.email
                //              print(email)
                completion(true)
            }
        }
        
    }
    
    func authenticateWithGoogle(viewController: UIViewController, onComplete: @escaping (Bool) -> Void){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) {  result, error in
            guard error == nil else {
                print(error)
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print(error)
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            self.loginWithCredentials(credential: credential, onComplete: onComplete)
            
        }
    }
    
    
    
    
   
    @MainActor func getArtists() async -> [Artist] {
        let artistRef = db.collection("artists")
        var artists: [Artist] = []
        var songList = [Song]()
            do {
                let querySnapshot = try await artistRef.getDocuments()
              for document in querySnapshot.documents {
                  let artist = Artist(snapshot: document)
                  let artistRealm = convertToArtistRealm(artist: artist)
                  
               
                
                  let name = document.data()["name"]
                  if let name = name as? String {
                      let songs = try await artistRef.document(name).collection("songs").getDocuments()
                      for songDocument in songs.documents{
                          let song = Song(snapshot: songDocument)
                         let songRealm = convertToSongRealm(song: song)
                      
                          try RealmManager.shared.saveSong(song: songRealm, artist: artistRealm)

                          //songList.append(song)
                      }
                  }
                  
                  
                  try RealmManager.shared.save(artistRealm)
              }
            } catch {
              print("Error getting documents: \(error)")
            }
    
            return artists
        }
    
  
    func convertToSongRealm(song: Song) -> SongRealm{
        let songRealm = SongRealm()
        songRealm.name =  song.name!
        songRealm.url = song.url!
        songRealm.source =  song.source!
        return songRealm
    }
    
    func convertToArtistRealm(artist: Artist) -> ArtistRealm{
        let artistRealm = ArtistRealm()
        artistRealm.name =  artist.name!
        artistRealm.url = artist.url!
        artistRealm.createdAt =  artist.createdAt!
        return artistRealm
    }
    
    func authenticateWithFacebook(tokenString: String, onComplete: @escaping (Bool) -> Void){
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
       
//             Auth.auth().signIn(with: credential) { (authResult, error) in
//                 if let error = error {
//                     print("Facebook authentication with Firebase error: ", error)
//                     return
//                 }
//             print("Login success!")
//             }
        
        loginWithCredentials(credential: credential, onComplete: onComplete)
    }
  
}

