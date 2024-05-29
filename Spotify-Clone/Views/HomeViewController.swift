//
//  HomeViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 02/05/2024.
//

import Foundation
import UIKit
import Alamofire


class HomeViewController : UIViewController{

   
    let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var forYouCV: UICollectionView!
    
    @IBOutlet weak var trendingVC: UICollectionView!
    let reuseableCellIdentifier = "forYouCell"
    let trendingIdentifier = "trendingCell"
    
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var forYouLabel: UILabel!

    @IBOutlet weak var settingsButton: UIButton!
   
    
    override func viewDidLoad() {
    
        trendingVC.delegate = self
        trendingVC.dataSource = self
        
        forYouCV.delegate = self
        forYouCV.dataSource = self

        homeViewModel.loadArtists()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        applyTheme()
    }
  
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
        
    }
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        forYouCV.applyThemeToCollectionView()
        trendingVC.applyThemeToCollectionView()
        forYouLabel.applyThemeToLable()
       
        trendingLabel.applyThemeToLable()
        settingsButton.applyThemeToButton()
        navigationController?.navigationBar.applyThemeToNavBar()
        tabBarController?.tabBar.tintColor = Theme.current.textColor
        forYouCV.reloadData()
        trendingVC.reloadData()
    }
    
    func navigateToPlaylistScreen(artist : ArtistRealm){
         let playlistViewController = PlaylistViewController()
        playlistViewController.artistRealm = artist
        self.navigationController?.pushViewController(playlistViewController, animated: true)
    }

}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getArtists().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let artistList = homeViewModel.getArtists()
        
        if collectionView == forYouCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableCellIdentifier, for: indexPath) as! CustomCollectionViewCell
       
            cell.label.text = artistList[indexPath.row].name
            cell.image.sd_setImage(with: URL(string: (artistList[indexPath.row].url)!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.label.applyThemeToLable()
            
            return cell
           
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingIdentifier, for: indexPath) as! CustomCollectionViewCell
            cell.mylabel.text = artistList[indexPath.row].name
            cell.myimage.sd_setImage(with: URL(string: (artistList[indexPath.row].url)!), placeholderImage: UIImage(named: "placeholder.png"))
            cell.mylabel.applyThemeToLable()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistList = homeViewModel.getArtists()
        navigateToPlaylistScreen(artist: artistList[indexPath.row])
    }

   
}
