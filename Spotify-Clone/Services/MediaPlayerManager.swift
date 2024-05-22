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
    var playerItem : AVPlayerItem?
    var playerItemList = [AVPlayerItem]()
    
    
    func makePlayerItems(songList: [SongRealm]){
        for song in songList{
            let url = URL(string: song.source)
            let playerItem = AVPlayerItem(url: url!)
            playerItemList.append(playerItem)
     
        }
    }
    
    func playMedia(songSource : String, shouldLoop: Bool, using: @escaping (Double, Double) -> Void){
  
        let url = URL(string: songSource)
        playerItem = AVPlayerItem(url: url!)
                
        if audioPlayer == nil {
            audioPlayer = AVQueuePlayer(playerItem: playerItem)
            
            
        }else{
            audioPlayer!.replaceCurrentItem(with: playerItem)
            
        }
        if shouldLoop{
            playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem!)
            print(playLooper?.loopingPlayerItems.count)
        }
        else{
     
            playLooper?.disableLooping()
         
        }
        
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

    func playBackToBack(songList: [SongRealm]){
        playerItemList.removeAll()
        for song in songList{
            let url = URL(string: song.source)
         playerItem = AVPlayerItem(url: url!)
            playerItemList.append(playerItem!)
     
        }
        
        if audioPlayer ==  nil{
        audioPlayer = AVQueuePlayer(items: playerItemList)
        }else{
            audioPlayer?.replaceCurrentItem(with: playerItem)
        }
        audioPlayer?.actionAtItemEnd = .advance
        
        audioPlayer?.play()
        
    }
    
    
    func loopSong(onComplete: @escaping (Bool) -> Void){
        

        if let player = audioPlayer, let item = playerItem {
            if player == nil {
                audioPlayer = AVQueuePlayer(playerItem: playerItem)
                
                
            }else{
                audioPlayer!.replaceCurrentItem(with: playerItem)
                
            }
            
        playLooper = AVPlayerLooper(player: player, templateItem: item)
            player.seek(to: (player.currentItem?.currentTime())!)
            player.play()
                onComplete(true)
        }
        
    
    }
    
    func mediaIsPlaying() -> Bool{
        
        return audioPlayer?.timeControlStatus == .playing
    }
    
    func mediaIsPaused() -> Bool{
        return audioPlayer?.timeControlStatus == .paused
    }
    
   
    func pauseMedia(){
        
        if mediaIsPlaying(){
            print("pause")
            audioPlayer?.pause()
            
        }
    }
    
    func resumeMedia(){
        print("resume")
        audioPlayer?.seek(to: (audioPlayer?.currentItem?.currentTime())!)
        audioPlayer?.play()
        
    }
    
    func stopMedia(){
        audioPlayer = nil
        audioPlayer?.replaceCurrentItem(with: nil)
        playLooper = nil
        //audioPlayer?.removeAllItems()
        //audioPlayer?.remove(playerItem!)
        
    }
    
    func removeFromLooper(){
       
        
        
    }
    
    func playSong(currentIndex: Int){
//        let url = URL(string: songSource)
//        playerItem = AVPlayerItem(url: url!)
//
        //audioPlayer?.actionAtItemEnd = .pause
        
        if audioPlayer == nil {
            audioPlayer = AVQueuePlayer(playerItem: playerItemList[currentIndex])


        }else{
            audioPlayer!.replaceCurrentItem(with: playerItemList[currentIndex])

        }
        audioPlayer?.play()
        print(audioPlayer?.currentItem?.status.rawValue)
//        let interval = CMTime(seconds: 1,
//                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
//
//        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
//            if let duration = self!.audioPlayer?.currentItem?.duration{
//                using(time.seconds , duration.seconds)
//                if time.seconds == duration.seconds{
//                    self?.stopMedia()
//                }
//            }
//
//        })
        
    }
    
    func addToLooper(songSource: String, currentIndex: Int, shouldLoop: Bool){
         
        if let player = audioPlayer, let item = playerItem{
        playLooper = AVPlayerLooper(player: player, templateItem: item)
        }
       
         
     }
}
