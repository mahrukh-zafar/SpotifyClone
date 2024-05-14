//
//  PlaySongViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import UIKit
import AVFAudio
import AVFoundation

class PlaySongViewController: UIViewController {
    
    var audioPlayer : AVPlayer?
    var song : SongRealm?
    var isFav : Bool?
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
        songNameLabel.text = song?.name
        playsongViewModel.getImage(imageUrl: song?.url) { data in
            DispatchQueue.main.async{
                self.songImageUrl.image = UIImage(data: data)
            }
            
        }
        
        //playsongViewModel.getAllFavorites()
        if let mySong = song{
           isFav = playsongViewModel.isFavorite(songName: mySong.name)
            if let fav = isFav{
                if fav{
                    favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    
                }else{
                    favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
            
        }
        else{
            print("error")
        }
        
        //isFav = playsongViewModel.isFavorite(songName: (song?.name)!)
    
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
        if let fav =  isFav{
        if !fav{
        playsongViewModel.favorite(song!)
        }else{
            playsongViewModel.unfavorite(song!)
        }
        }
        
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        //        if let player = audioPlayer, player.{
        //
        //            player.stop()
        //            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        //        }
        //        else{
        //let source = Bundle.main.path(forResource: "apple_macbook_ad", ofType: ".mp3")
        
        
        if let player = audioPlayer, player.timeControlStatus == .playing{
            player.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            let url = URL(string: (song?.source)!)
            let playerItem : AVPlayerItem = AVPlayerItem(url: url!)
            
            playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            audioPlayer =  AVPlayer(playerItem: playerItem)
            audioPlayer!.play()
            
        }
    }
    
}
