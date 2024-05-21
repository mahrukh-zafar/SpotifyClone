//
//  PlaylistViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 07/05/2024.
//

import UIKit
import RealmSwift
import SDWebImage

class PlaylistViewController: UIViewController {

    @IBOutlet weak var playlistCV: UICollectionView!

  
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var spotifyLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    
    let playListViewModel = PlayListViewModel()
    
    var artistRealm : ArtistRealm?
//    var artist : String?
//    var artistImageUrl : String?
    var songs = [SongRealm]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.backward")
        
    playlistCV.register(UINib(nibName:"PlayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
        
        artistName.text = artistRealm?.name
        artistImage.sd_setImage(with: URL(string: (artistRealm?.url)!), placeholderImage: UIImage(named: "placeholder.png"))
        songs = Array(artistRealm!.songs)
        setFavButton()
        playlistCV.delegate = self
        playlistCV.dataSource = self
        applyTheme()
        setPlayButton(name: "play.fill")
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        MediaPlayerManager.shared.stopMedia()
    }

    func applyTheme(){
        view.backgroundColor = Theme.current.background
        playlistCV.applyThemeToCollectionView()
        detailsLabel.applyThemeToLable()
        spotifyLabel.applyThemeToLable()
        likesLabel.applyThemeToLable()
        //favButton.applyThemeToButton()
        
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        
        if let fav =  playListViewModel.isFavorite(artistName: artistRealm!.name){
        if !fav{
            playListViewModel.favorite(artistRealm!)
        }else{
            playListViewModel.unfavorite(artistRealm!)
        }
           
        }
        
        setFavButton()
        
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        guard let artist = artistRealm else{
            return
        }
        if MediaPlayerManager.shared.mediaIsPlaying() {
            MediaPlayerManager.shared.pauseMedia()
            setPlayButton(name: "play.fill")
        
        }else if MediaPlayerManager.shared.mediaIsPaused(){
            MediaPlayerManager.shared.resumeMedia()
            setPlayButton(name: "pause.fill")
            
        } else{
            MediaPlayerManager.shared.playBackToBack(songList: Array(artist.songs))
            setPlayButton(name: "pause.fill")
        }
    }
    
    func navigateToPlaySongScreen(currentIndex : Int){
       
        let playSongViewController = PlaySongViewController()
        playSongViewController.songs = songs
        playSongViewController.currentIndex = currentIndex
        self.navigationController?.pushViewController(playSongViewController, animated: true)
    }
    
    func setFavButton(){
        favButton.tintColor = Theme.current.error
        if let fav = playListViewModel.isFavorite(artistName: artistRealm!.name){
            if fav{
                favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
                
            }else{
                favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

}

extension PlaylistViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as! PlayListCollectionViewCell
        
        cell.songName.text = songs[indexPath.row].name
        cell.songName.applyThemeToLable()
        
        cell.artistImage.sd_setImage(with: URL(string: (songs[indexPath.row].url)), placeholderImage: UIImage(named: "placeholder.png"))
        
//        playListViewModel.getImage(imageUrl: songs[indexPath.row].url) { data in
//            DispatchQueue.main.async{
//                cell.artistImage.image = UIImage(data: data)
//            }
//
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlaySongScreen(currentIndex: indexPath.row)
    }
  
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: collectionViewWidth, height: 80)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
    
    func setPlayButton(name: String){
        playButton.setImage(UIImage(systemName: name), for: .normal)
        playButton.tintColor = Theme.current.tint
//        playButton.backgroundColor = .systemGreen
//        playButton.layer.cornerRadius = playButton.frame.height / 2
//        playButton.clipsToBounds = true
//        playButton.contentMode = .center
//        playButton.imageView?.contentMode = .scaleAspectFit
       
    }
}


