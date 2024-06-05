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
    var loop = false
    
    
    func makePlayerItems(songList: [SongRealm]){
        playerItemList.removeAll()
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
        audioPlayer?.actionAtItemEnd = .advance
//        if shouldLoop{
//            playLooper = AVPlayerLooper(player: audioPlayer!, templateItem: playerItem!)
//            print(playLooper?.loopingPlayerItems.count)
//        }
//        else{
//            
//            playLooper?.disableLooping()
//           
//        }
        
        audioPlayer?.play()
        
        let interval = CMTime(seconds: 1,
                              preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        audioPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] time in
            if let duration = self!.audioPlayer?.currentItem?.duration{
                using(time.seconds , duration.seconds)
                if time.seconds == duration.seconds{
                    self?.stopMedia()
                   
                    if self?.loop ?? false {
                        self?.playMedia(songSource: songSource, shouldLoop: false, using: using)
                    }
                }
            }
            
        })
        
    }
    
    func playAtRate(playingRate : Float){
        audioPlayer?.playImmediately(atRate: playingRate)
    }
    
    func playBackToBack(songList: [SongRealm]){
        makePlayerItems(songList: songList)
        
        if audioPlayer ==  nil{
            audioPlayer = AVQueuePlayer(items: playerItemList)
        }else{
            audioPlayer?.replaceCurrentItem(with: playerItem)
        }
        audioPlayer?.actionAtItemEnd = .advance
        
        audioPlayer?.play()
        
        print(audioPlayer?.currentItem)
    }
    
    
    func mediaIsPlaying() -> Bool{
        
        return audioPlayer?.timeControlStatus == .playing
    }
    
    func mediaIsPaused() -> Bool{
        return audioPlayer?.timeControlStatus == .paused
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
        audioPlayer = nil
        playLooper = nil
        
    }
    
    func addToLooper(){
        loop = true
//        guard let player = audioPlayer, let item = playerItem else{return}
//        playLooper = AVPlayerLooper(player: player, templateItem: item)
        
    }
    
    func removeFromLooper(){
        loop = false
//        guard let looper = playLooper else{return }
//      looper.disableLooping()
        
    }
}
