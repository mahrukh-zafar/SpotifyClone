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
    var artistList : [ArtistRealm] = []
    var trendingList : [Artist] = []
    
   
    @IBOutlet weak var bellButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
    
        trendingVC.delegate = self
        trendingVC.dataSource = self
        
        forYouCV.delegate = self
        forYouCV.dataSource = self
//
//        Task{
//        await homeViewModel.getArtists()
//        }
//
        
        if let artists = homeViewModel.loadArtists(){
            artistList = artists
        }
        
        
//        loadData()
       
    }
    override func viewDidAppear(_ animated: Bool) {
        applyTheme()
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        print("refresh pressed")
        
//        Task{
//           artistList =  await homeViewModel.refresh()
//            forYouCV.reloadData()
//            trendingVC.reloadData()
//        }
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
        
    }
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        forYouCV.applyThemeToCollectionView()
        trendingVC.applyThemeToCollectionView()
        bellButton.applyThemeToButton()
        forYouLabel.applyThemeToLable()
        refreshButton.applyThemeToButton()
        trendingLabel.applyThemeToLable()
        settingsButton.applyThemeToButton()
        navigationController?.navigationBar.applyThemeToNavBar()
     
    }
    
    func navigateToPlaylistScreen(artist : ArtistRealm){
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let playlistViewController = PlaylistViewController()
        playlistViewController.artistRealm = artist
//        playlistViewController.artist = artist.name
//        playlistViewController.artistImageUrl =  artist.url
        self.navigationController?.pushViewController(playlistViewController, animated: true)
    }
    
    func loadData(){
//         Task{
//            artistList =  await homeViewModel.getArtists()
//             forYouCV.reloadData()
//             trendingVC.reloadData()
//         }
     }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == forYouCV{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableCellIdentifier, for: indexPath) as! CustomCollectionViewCell
            homeViewModel.getImage(imageUrl: artistList[indexPath.row].url) { data in
                DispatchQueue.main.async{
                    cell.image.image = UIImage(data: data)
                }
                
            }
            cell.label.text = artistList[indexPath.row].name
            
            cell.label.applyThemeToLable()
            
            return cell
           
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingIdentifier, for: indexPath) as! CustomCollectionViewCell
            homeViewModel.getImage(imageUrl: artistList[indexPath.row].url) { data in
                DispatchQueue.main.async{
                    cell.myimage.image = UIImage(data: data)
                }
                
            }
            cell.mylabel.text = artistList[indexPath.row].name
            
            cell.mylabel.applyThemeToLable()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlaylistScreen(artist: artistList[indexPath.row])
    }

   
}
