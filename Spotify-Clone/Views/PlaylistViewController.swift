//
//  PlaylistViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 07/05/2024.
//

import UIKit
import RealmSwift

class PlaylistViewController: UIViewController {

    @IBOutlet weak var playlistCV: UICollectionView!

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var spotifyLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
    
    let playListViewModel = PlayListViewModel()
    
    var artistRealm : ArtistRealm?
//    var artist : String?
//    var artistImageUrl : String?
    var songs = List<SongRealm>()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.backward")
        
    playlistCV.register(UINib(nibName:"PlayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
        
        artistName.text = artistRealm?.name
        playListViewModel.getImage(imageUrl: artistRealm?.url) { data in
            DispatchQueue.main.async{
                self.artistImage.image = UIImage(data: data)
            }

        }
//        Task{
//            await playListViewModel.syncPlayListFromFirebase(artist: artistRealm!)
//        }
        playListViewModel.getSongsByArtist(artist: artistRealm!)
        
        songs = artistRealm!.songs
        
        
//        Task{
//         songs = await  playListViewModel.getSongs(artistName:artist!)
//            playlistCV.reloadData()
//
//        }
//
        playlistCV.delegate = self
        playlistCV.dataSource = self
        applyTheme()
        
    }
    override func viewDidAppear(_ animated: Bool) {
       
        
    }

    func applyTheme(){
        view.backgroundColor = Theme.current.background
        playlistCV.applyThemeToCollectionView()
        detailsLabel.applyThemeToLable()
        spotifyLabel.applyThemeToLable()
        likesLabel.applyThemeToLable()
        favButton.applyThemeToButton()
        menuButton.applyThemeToButton()
    }
    func navigateToPlaySongScreen(song : SongRealm){
       
        let playSongViewController = PlaySongViewController()
        playSongViewController.song = song
        self.navigationController?.pushViewController(playSongViewController, animated: true)
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
        playListViewModel.getImage(imageUrl: songs[indexPath.row].url) { data in
            DispatchQueue.main.async{
                cell.artistImage.image = UIImage(data: data)
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlaySongScreen(song: songs[indexPath.row])
    }
  
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: collectionViewWidth, height: 80)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
}


