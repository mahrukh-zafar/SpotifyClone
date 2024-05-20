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
    @IBOutlet weak var loopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var currentIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        progressView.progress = 0.0
        let song = songs![currentIndex!]
        
        songNameLabel.text = song.name
      
       songImageUrl.sd_setImage(with: URL(string: (song.url)), placeholderImage: UIImage(named: "placeholder.png"))
        
//        playsongViewModel.getImage(imageUrl: song.url) { data in
//            DispatchQueue.main.async{
//                self.songImageUrl.image = UIImage(data: data)
//            }
//            
//        }
        
        if let fav = playsongViewModel.isFavorite(songName: song.name){
            if fav{
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
            }else{
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        //setFavoriteButton(song: song)
        
        
//        if let mySong = song{
//           //isFav = playsongViewModel.isFavorite(songName: mySong.name)
//            if let fav = playsongViewModel.isFavorite(songName: mySong.name){
//                if fav{
//                    favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//
//                }else{
//                    favButton.setImage(UIImage(systemName: "heart"), for: .normal)
//                }
//            }
//
//        }
//        else{
//            print("error")
//        }
    
    }
    override func viewWillDisappear(_ animated: Bool) {
        MediaPlayerManager.shared.stopMedia()
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        favButton.applyThemeToButton()
        songNameLabel.applyThemeToLable()
        playButton.applyThemeToButton()
        loopButton.applyThemeToButton()
        nextButton.applyThemeToButton()
        prevButton.applyThemeToButton()
        shuffleButton.applyThemeToButton()
        progressView.tintColor = Theme.current.textColor
        
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
        progressView.progress = 0.0
        if currentIndex!+1 < songs!.count{
            currentIndex =  currentIndex! + 1
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source) { time, duration in
                self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
                self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
                self.progressView.progress = Float(time)/Float(duration)
                print(time)
            }
            setFavoriteButton(song: songs![currentIndex!])
            songNameLabel.text = songs![currentIndex!].name
        }
    
    }
    
    
    @IBAction func playPreviousSong(_ sender: UIButton) {
        progressView.progress = 0.0
        if currentIndex != 0{
            currentIndex = currentIndex! - 1
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source) { time, duration in
                self.starTimeLabel.text = String(format: "%0.0f", floor(time/60)) + "." + String(format: "%0.0f", time.truncatingRemainder(dividingBy: 60))
                self.endTimeLabel.text = String(format: "%0.0f", floor(duration/60)) + "." + String(format: "%0.0f", duration.truncatingRemainder(dividingBy: 60))
                self.progressView.progress = Float(time) / Float(duration)
                print(time)
            }
            setFavoriteButton(song: songs![currentIndex!])
            songNameLabel.text = songs![currentIndex!].name
            
        }
    
    }
    
    
    @IBAction func shuffleList(_ sender: UIButton) {
    }
    
    
    @IBAction func loopSong(_ sender: UIButton) {
        isLooping = !isLooping
        if isLooping{
            loopButton.tintColor = .green
        }
        else{
            loopButton.applyThemeToButton()
        }
        playsongViewModel.loopSong(songSource: songs![currentIndex!].source,shouldLoop: isLooping)
        
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
            playsongViewModel.play(songSource: songs![currentIndex!].source) { time, duration in
//                if floor(time) == floor(duration){
//
//                    self.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//                }
                
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
                
            }else{
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
        
    }
    
}
