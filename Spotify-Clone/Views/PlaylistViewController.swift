//
//  PlaylistViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 07/05/2024.
//

import UIKit

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
    var artist : Artist?
    var songs = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.backBarButtonItem?.image = UIImage(systemName: "chevron.backward")
        
    playlistCV.register(UINib(nibName:"PlayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
        
        artistName.text = artist?.name
        songs = artist?.songs ?? []
        playListViewModel.getImage(imageUrl: artist?.url) { data in
            DispatchQueue.main.async{
                self.artistImage.image = UIImage(data: data)
            }
            
        }
//        Task{
//
//        }
      
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
    func navigateToPlaySongScreen(){
       
        let playSongViewController = PlaySongViewController()
        //playlistViewController.artist = artist
        self.navigationController?.pushViewController(playSongViewController, animated: true)
    }

}

extension PlaylistViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as! PlayListCollectionViewCell
        
        cell.songName.text = songs[indexPath.row]
        cell.songName.applyThemeToLable()
        playListViewModel.getImage(imageUrl: artist?.url) { data in
            DispatchQueue.main.async{
                cell.artistImage.image = UIImage(data: data)
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlaySongScreen()
    }
  
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: collectionViewWidth, height: 80)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
}


