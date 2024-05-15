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
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var songImageUrl: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var loopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var currentIndex : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        let song = songs![currentIndex!]
        
        songNameLabel.text = song.name
        playsongViewModel.getImage(imageUrl: song.url) { data in
            DispatchQueue.main.async{
                self.songImageUrl.image = UIImage(data: data)
            }
            
        }
        
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
        }
    }
    
    
    @IBAction func playNextSong(_ sender: UIButton) {
        if currentIndex!+1 < songs!.count{
            currentIndex =  currentIndex! + 1
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source)
            setFavoriteButton(song: songs![currentIndex!])
            songNameLabel.text = songs![currentIndex!].name
        }

        
        
//        if playsongViewModel.isPaused() {
//            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            playsongViewModel.resume()
//        }else if playsongViewModel.isPlaying(){
//            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            playsongViewModel.pause()
//        }
//        else {
//            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            playsongViewModel.play(songSource: url)
//        }
    
    }
    
    
    @IBAction func playPreviousSong(_ sender: UIButton) {
        if currentIndex != 0{
            currentIndex = currentIndex! - 1
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source)
            setFavoriteButton(song: songs![currentIndex!])
            songNameLabel.text = songs![currentIndex!].name
            
        }
        
        
//        if playsongViewModel.isPaused() {
//            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            playsongViewModel.resume()
//        }else if playsongViewModel.isPlaying(){
//            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//            playsongViewModel.pause()
//        }
//        else {
//            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
//            playsongViewModel.play(songSource: song!.source)
//        }
    }
    
    
    @IBAction func shuffleList(_ sender: UIButton) {
    }
    
    
    @IBAction func loopSong(_ sender: UIButton) {
        
       // MediaPlayerManager.shared.loopSong()
        
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
       
        if playsongViewModel.isPaused() {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.resume()
        }else if playsongViewModel.isPlaying(){
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            playsongViewModel.pause()
        }
        else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            playsongViewModel.play(songSource: songs![currentIndex!].source)
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
