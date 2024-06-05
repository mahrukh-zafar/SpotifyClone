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

    static let shared = FirebaseManager()
    
    func loginWithEmail(email : String, password: String,  completion: @escaping (Bool,Error?) -> Void)  {
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            
            if let error = error as? NSError {
               
            } else {
               
                UserDefaults.standard.set(true, forKey: "logged In")
                
            }
            completion(UserDefaults.standard.bool(forKey: "logged In"),error)
        }
    }
    
    func loginWithCredentials(credential: AuthCredential, onComplete: @escaping (Bool) -> Void){
        Auth.auth().signIn(with: credential) { result, error in
            
            if let error = error as? NSError {
                print(error)
                onComplete(true)
            } else {
                UserDefaults.standard.set(true, forKey: "logged In")
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
                UserDefaults.standard.set(true, forKey: "logged In")
                completion(true)
            }
        }
        
    }
    
    func authenticateWithGoogle(viewController: UIViewController, onComplete: @escaping (Bool) -> Void){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
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
    
   
    func getArtists(onComplete: @escaping () -> Void) {
        let artistRef = db.collection("artists")
        artistRef.getDocuments { [self] querySnapshot, error in
            if let documents = querySnapshot?.documents{
                for document in documents{
                    let artist = Artist(snapshot: document)
                    let artistRealm = convertToArtistRealm(artist: artist)
                    let name =  document.data()["name"] as? String
                    if let artistName = name{
                        artistRef.document(artistName).collection("songs").getDocuments { songsDocuments, error in
                            if let documents = songsDocuments?.documents{
                                for document in documents{
                                    let song = Song(snapshot: document)
                                    let songRealm = self.convertToSongRealm(song: song)
                                    do{
                                        try RealmManager.shared.saveSong(song: songRealm, artist: artistRealm)
                                    }
                                    catch{
                                        print(error)
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                    do{
                        
                        try RealmManager.shared.save(artistRealm)
                        
                        
                    }
                    catch{
                        print(error)
                    }
                    
                }
                onComplete()
            }
            
            
        }
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
        artistRealm.url = artist.url
        artistRealm.createdAt =  artist.createdAt!
        return artistRealm
    }
    
    
    
}

