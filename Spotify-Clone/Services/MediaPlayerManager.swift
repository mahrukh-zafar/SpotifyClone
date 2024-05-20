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
    
    

    
    func playMedia(songSource : String, using: @escaping (Double, Double) -> Void){
    
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
        audioPlayer?.actionAtItemEnd = .none
       // playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem)
        audioPlayer?.play()
        let interval = CMTime(seconds: 1,
                                  preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
            if let duration = self!.audioPlayer?.currentItem?.duration{
                using(time.seconds , duration.seconds)
                if time.seconds == duration.seconds{
                    self?.stopMedia()
                }
            }
            
        })
        
    }
    
    func loopSong(songSource: String, shouldLoop: Bool){
        let url = URL(string: songSource)
       let  playerItem = AVPlayerItem(url: url!)
        // audioPlayer?.actionAtItemEnd = .pause

        if audioPlayer == nil {
             audioPlayer = AVQueuePlayer(playerItem: playerItem)


        }else{
            audioPlayer!.replaceCurrentItem(with: playerItem)

        }
        //resumeMedia()
      
            if shouldLoop{
            playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem)}
            else{
                playLooper?.disableLooping()
            }
       
//         audioPlayer?.play()
//         let interval = CMTime(seconds: 1,
//                                   preferredTimescale: CMTimeScale(NSEC_PER_SEC))
         
//         audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
//             if let duration = self!.audioPlayer?.currentItem?.duration{
//                 using(time.seconds , duration.seconds)
//             }
//         })
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
        
        audioPlayer?.replaceCurrentItem(with: nil)
        
        
    }
    
    func updateUI(using: @escaping (Double) -> Void){
        let interval = CMTime(seconds: 1,
                                  preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
            using(time.seconds)
        })
    }
    
    func totalDuration() -> Double{
        return (audioPlayer?.currentItem?.duration.seconds)!
    }
    
   
    
    
}
