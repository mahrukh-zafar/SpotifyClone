//
//  PlaySongModelView.swift
//  Spotify-Clone
//
//  Created by Dev on 10/05/2024.
//

import Foundation
import RealmSwift

class  PlaySongViewModel{

    func isPlaying() -> Bool{
        
        return MediaPlayerManager.shared.mediaIsPlaying()
    }
    func isPaused() ->  Bool{
        return MediaPlayerManager.shared.mediaIsPaused()
    }
    
    func play(songSource: String, shouldLoop: Bool, using: @escaping (Double, Double) -> Void){
        MediaPlayerManager.shared.playMedia(songSource: songSource, shouldLoop: shouldLoop, using: using)
    }
    
    func pause(){
        MediaPlayerManager.shared.pauseMedia()
    }
    
    func resume(){
        MediaPlayerManager.shared.resumeMedia()
    }
    
    
    func playBackToBack(songList: [SongRealm]){
        MediaPlayerManager.shared.playBackToBack(songList: songList)
    }
}
