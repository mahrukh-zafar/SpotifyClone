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
    
    let db = Firestore.firestore()
    
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
    
    func addDataToFirestore(){
        // Add a new document in collection "cities"
        
//        let artist = Artist(name: "Ed Sheeran", songs: [""], url: "    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKrIOUVo6lkCNjBFNPxAamVvGkfS_zBlq5BOHrMhm5AQ&s")
//        do{
//        let jsonData = try JSONEncoder().encode(artist)
//            let data = String(data: jsonData, encoding: .utf8)!
//            print(data)
//        }catch{
//
//        }
//        db.collection("artists").document("Muhammad Al-Husayn").setData([
//            "name": "Muhammad Al-Husayn",
//            "songs": ["Ya Ilahi", "Mawlay", "Tafa'al", "Araftuka Ya Rab", "Jesus"],
//            "url": "    https://cdn.siasat.com/wp-content/uploads/2023/10/arijit-singh.jpg",
//            "createdAt": Date().timeIntervalSince1970
//          ])
//         print("Added")
//
 //       db.collection("artists").document("Ed Sheeran").setData(from: artist)
        
//        db.collection("artists").document("Atif Aslam").updateData(["createdAt" : Date().timeIntervalSince1970])
//        db.collection("artists").document("V").updateData(["createdAt" : Date().timeIntervalSince1970])
//        db.collection("artists").document("Katy Parry").updateData(["createdAt" : Date().timeIntervalSince1970])
//        print("Added")
    }
    func getArtists() async -> [Artist] {
        var artists: [Artist] = []
            do {
                let querySnapshot = try await db.collection("artists").getDocuments()
              for document in querySnapshot.documents {
                  let artist = Artist(snapshot: document)
                  artists.append(artist)
                
                  
                  
//                  let decoder = JSONDecoder()
     //             let pairs = try? decoder.decode(Artist.self, from: document.data())
               
              }
            } catch {
              print("Error getting documents: \(error)")
            }
        
            return artists
        }
    
    
    
//    func addArtists(){
//        let song  = Song(name: "Desh Mere", url: "https://cdn.siasat.com/wp-content/uploads/2023/10/arijit-singh.jpg", isFavorite: true, createdAt: 0.0)
//
//        let artist = MyArtist(name: "Arjeet Sing", url: "https://cdn.siasat.com/wp-content/uploads/2023/10/arijit-singh.jpg", createdAt: 0.0, songs: [song])
//
//        let songs = ["name" : song.name,
//                                  "url" : song.url,
//                                  "createdAt" : song.createdAt,
//                     "isFavorite" : song.isFavorite] as [String : Any]
//
//        let mysongs = {
//            "name" : "",
//            "isFavorite" : true,
//            "url" : ""
//        }
//
//
//        let artistInfo = ["name" : artist.name,
//                                  "url" : artist.url,
//                                  "createdAt" : artist.createdAt,
//                          "songs" : artist.songs] as [String : Any]
//
//
//        db.collection("my-artists").document("Arjeet Singh").setData(artistInfo)
//    }
    
    func getSongs(artistName: String) async -> [Song]{
        var songs: [Song] = []
            do {
                let querySnapshot = try await db.collection("artists/\(artistName)/songs").getDocuments()
              for document in querySnapshot.documents {
                  let song = Song(snapshot: document)
                  songs.append(song)
            
              }
            } catch {
              print("Error getting documents: \(error)")
            }
        
            return songs
    }
  
}
