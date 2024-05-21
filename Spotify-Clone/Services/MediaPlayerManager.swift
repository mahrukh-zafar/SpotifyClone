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
        
        //audioPlayer?.actionAtItemEnd = .pause
        
        if audioPlayer == nil {
            audioPlayer = AVQueuePlayer(playerItem: playerItem)
            
            
        }else{
            audioPlayer!.replaceCurrentItem(with: playerItem)
            
        }
        
//        if shouldLoop{
//            playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem!)}
//        else{
//            playLooper?.disableLooping()
//        }
        
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
        for song in songList{
            let url = URL(string: song.source)
            let playerItem = AVPlayerItem(url: url!)
            playerItemList.append(playerItem)
     
        }
        
        audioPlayer = AVQueuePlayer(items: playerItemList)
        audioPlayer?.actionAtItemEnd = .advance
        
        audioPlayer?.play()
        
    }
    
    
    func loopSong(shouldLoop: Bool, onComplete: @escaping (Bool) -> Void){
        
        if let player = audioPlayer, let playerItem = playerItem{
           pauseMedia()
            if shouldLoop{
                playLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                onComplete(true)
            }
            
            else{
                playLooper?.disableLooping()
                onComplete(false)
            }
        }
        
        
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
        //audioPlayer?.replaceCurrentItem(with: nil)
        playLooper = nil
        
        
    }
    
    func updateUI(using: @escaping (Double) -> Void){
        let interval = CMTime(seconds: 1,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { time in
            using(time.seconds)
        })
    }
    
    func totalDuration() -> Double{
        return (audioPlayer?.currentItem?.duration.seconds)!
    }
    
    
    func addToLooper(currentIndex: Int, shouldLoop: Bool){
        
        if shouldLoop{
            playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItemList[currentIndex])
//            onComplete(true)
        }
        
        else{
            playLooper?.disableLooping()
//            onComplete(false)
        }
        
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
    
}
