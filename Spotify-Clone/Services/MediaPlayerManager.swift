//
//  MediaPlayerManager.swift
//  Spotify-Clone
//
//  Created by Dev on 13/05/2024.
//

import Foundation
import AVFoundation

class MediaPlayerManager{
    static let shared = MediaPlayerManager()
    
    var audioPlayer : AVQueuePlayer?
    var playLooper : AVPlayerLooper?
    var currentTime: CMTime?
    var playerItem: AVPlayerItem?
    

    
    func playMedia(songSource : String){
    
            let url = URL(string: songSource)
            let playerItem = AVPlayerItem(url: url!)
       
//            let playerItem2 : AVPlayerItem = AVPlayerItem(url: url2!)
//            audioPlayer =  AVQueuePlayer(items:  [playerItem, playerItem2])
        
           // audioPlayer = AVQueuePlayer(playerItem: playerItem)
        
        
        
        
        if audioPlayer == nil {
             audioPlayer = AVQueuePlayer(playerItem: playerItem)
           
            
        }else{
            audioPlayer?.replaceCurrentItem(with: playerItem)
           
        }
       // audioPlayer?.actionAtItemEnd = .pause
       // playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem)
        audioPlayer?.play()

        
    }
   
    
    func mediaIsPlaying() -> Bool{
        
        return audioPlayer?.timeControlStatus == .playing
    }
    
    func mediaIsPaused() -> Bool{
        return audioPlayer?.timeControlStatus == .paused
    }
    
    func mediaIsStopped() {
        
        
    }
    
    
    func pauseMedia(){
       
        if mediaIsPlaying(){
            audioPlayer?.pause()
          
        }
    }
    
    func resumeMedia(){
        audioPlayer?.seek(to: (audioPlayer?.currentItem?.currentTime())!)
        audioPlayer?.play()
        
    }
    
    func stopMedia(){
        
        
    }
    
    func totalDuration() -> Double{
        return (audioPlayer?.currentItem?.duration.seconds)!
    }
    
    
}
