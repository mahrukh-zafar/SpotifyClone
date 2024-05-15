//
//  PlaySongModelView.swift
//  Spotify-Clone
//
//  Created by Dev on 10/05/2024.
//

import Foundation
import RealmSwift

class  PlaySongViewModel{
    let mediaPlayerManager = MediaPlayerManager()
    func getImage(imageUrl : String?, onComplete: @escaping (Data) -> Void){
        
        NetworkManager.shared.getImage(imageUrl: imageUrl!, onComplete: onComplete)
    }
    
    func favorite(_ song: SongRealm) {
        let favSong = FavoriteSong()
        favSong.name = song.name
        favSong.url = song.url
        favSong.source = song.source
        
        do{
            try RealmManager.shared.save(favSong)
        }
        catch{
            
        }
        
    }
    
    func unfavorite(_ song : SongRealm){
        
        do{
            
            let result = try RealmManager.shared.load(for: FavoriteSong.self)?.filter("name=%@",song.name)
          
            if let songToDelete = result{
                try RealmManager.shared.delete(songToDelete)
            }
            
        }
        catch{
            
        }
    }
    
    func isFavorite( songName : String) -> Bool?{
        do{
            let result  = try RealmManager.shared.load(for: FavoriteSong.self)?.filter("name=%@",songName)
            let obj = result?.first
            if obj != nil{
                print("returning true")
                return true
            }
            else{
                print("return false")
                return false
            }
        }
        catch{
            return nil
        }
    }
    
    func isPlaying() -> Bool{
        
        return mediaPlayerManager.mediaIsPlaying()
    }
    func isPaused() ->  Bool{
        return mediaPlayerManager.mediaIsPaused()
    }
    
    func play(songSource: String){
        mediaPlayerManager.playMedia(songSource: songSource)
    }
    
    func pause(){
        mediaPlayerManager.pauseMedia()
    }
    
    func resume(){
        mediaPlayerManager.resumeMedia()
    }
    
}
