//
//  PlaySongViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import UIKit
import AVFAudio
import AVFoundation
import RealmSwift

class PlaySongViewController: UIViewController {
    
    
    var songs : [SongRealm]?
    
    let playsongViewModel = PlaySongViewModel()
    var isLooping = false
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var starTimeLabel: UILabel!
    @IBOutlet weak var songImageUrl: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var endTimeLabel: UILabel!
  
    @IBOutlet weak var backwordButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
 
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var currentIndex : Int?
    var playingRate: Float = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        progressView.progress = 0.0
        
        guard let songs = songs, let index = currentIndex else {
            return
        }
        let song = songs[index]
        
        songNameLabel.text = song.name.capitalizingFirstLetter()
        
        songImageUrl.sd_setImage(with: URL(string: (song.url)), placeholderImage: UIImage(named: "placeholder.png"))
        
        setFavoriteButton(song: song)
        setPlayButton(name: "play.fill")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        MediaPlayerManager.shared.stopMedia()
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        favButton.tintColor = Theme.current.error
        songNameLabel.applyThemeToLable()
        forwardButton.applyThemeToButton()
        backwordButton.applyThemeToButton()
        nextButton.applyThemeToButton()
        prevButton.applyThemeToButton()
        starTimeLabel.applyThemeToLable()
        endTimeLabel.applyThemeToLable()
        progressView.tintColor = Theme.current.tint
        
    }
    
    @IBAction func backwardButtonPressed(_ sender: UIButton) {
        playingRate = playingRate - 0.25
        
        MediaPlayerManager.shared.playAtRate(playingRate: playingRate)
        
    }
    
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        playingRate = playingRate + 0.25
        
        MediaPlayerManager.shared.playAtRate(playingRate: playingRate)
        
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        
        if let songs = songs, let index = currentIndex{
            if let fav =  playsongViewModel.isFavorite(songName: songs[index].name){
                if !fav{
                    playsongViewModel.favorite(songs[index])
                }else{
                    playsongViewModel.unfavorite(songs[index])
                }
            }
            setFavoriteButton(song: songs[index])
        }
        
    }
    
    
    @IBAction func playNextSong(_ sender: UIButton) {
        
        if let index = currentIndex, let songs = songs {
            if index + 1 < songs.count{
                currentIndex = index + 1
                progressView.progress = 0.0
                playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                playsongViewModel.play(songSource: songs[index+1].source, shouldLoop: isLooping) { time, duration in
                    self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
                    self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
                    self.progressView.progress = Float(time)/Float(duration)
                    print(time)
                }
                setFavoriteButton(song: songs[index+1])
                songNameLabel.text = songs[index+1].name.capitalizingFirstLetter()
            }
        }
        
    }
    
    
    @IBAction func playPreviousSong(_ sender: UIButton) {
        
        if let index = currentIndex, let songs = songs {
            if index != 0{
                currentIndex = index - 1
                progressView.progress = 0.0
                playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                playsongViewModel.play(songSource: songs[index-1].source, shouldLoop: isLooping) { time, duration in
                    self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
                    self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
                    self.progressView.progress = Float(time)/Float(duration)
                    print(time)
                }
                setFavoriteButton(song: songs[index-1])
                songNameLabel.text = songs[index-1].name.capitalizingFirstLetter()
            }
        }

        
    }
    

    
    @IBAction func loopSong(_ sender: UIButton) {
        
//        isLooping = !isLooping
//        if isLooping{
//           // playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            loopButton.tintColor = Theme.current.tint
//            MediaPlayerManager.shared.addToLooper()
//
//        }
//        else{
//            loopButton.tintColor = Theme.current.textColor
//            MediaPlayerManager.shared.removeFromLooper()
//
//        }
//
//        if playsongViewModel.isPaused() {
//            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//
//        }else if playsongViewModel.isPlaying(){
//            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//
//        }
//        MediaPlayerManager.shared.playMedia(songSource: songs![currentIndex!].source, shouldLoop: isLooping) { time, duration in
//            if floor(time) == floor(duration){
//                print("I am here")
//                self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//                self.progressView.progress = 1
//            }
//
//            if self.playsongViewModel.isPaused(){
//                self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            }
//            if self.playsongViewModel.isPlaying(){
//                self.playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            }
//
//            self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
//            self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
//            self.progressView.progress = Float(time)/Float(duration)
//            print(time)
//        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        //progressView.progress = 0.0
        if playsongViewModel.isPaused() {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.resume()
        }else if playsongViewModel.isPlaying(){
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            playsongViewModel.pause()
        }
        else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source, shouldLoop: isLooping) { time, duration in
                if floor(time) == floor(duration){
                    
                    self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                    self.progressView.progress = 1
                }
                
                if self.playsongViewModel.isPaused(){
                    self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                }
                
                self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
                self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
                self.progressView.progress = Float(time)/Float(duration)
                print(time)
                
            }
        }
        
    }
    
    func setFavoriteButton(song: SongRealm){
        if let fav = playsongViewModel.isFavorite(songName: song.name){
            if fav{
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                favButton.tintColor = Theme.current.error
                
            }else{
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        
    }
    func setPlayButton(name: String){
        playButton.setImage(UIImage(systemName: name), for: .normal)
        playButton.tintColor = Theme.current.tint
    }
    
}
