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

    var switchTheme = false
    let homeViewModel = HomeViewModel()
    
    @IBOutlet weak var forYouCV: UICollectionView!
    
    @IBOutlet weak var trendingVC: UICollectionView!
    let reuseableCellIdentifier = "forYouCell"
    let trendingIdentifier = "trendingCell"
    
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var forYouLabel: UILabel!
    var artistList : [Artist] = []
    var trendingList : [Artist] = []
    
    override func viewDidLoad() {
    
        trendingVC.delegate = self
        trendingVC.dataSource = self
        
        forYouCV.delegate = self
        forYouCV.dataSource = self
        
        loadData()
        
        applyTheme()
  
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        
        Task{
           artistList =  await homeViewModel.refresh()
            forYouCV.reloadData()
            trendingVC.reloadData()
        }
        
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        print("settings pressed : \(switchTheme)")
        switchTheme = !switchTheme
        
        if switchTheme{
            Theme.current  = LightTheme()
            print(Theme.current.background)
        }
        else{
            Theme.current  = DarkTheme()
            print(Theme.current.background)
        }
        
        applyTheme()
        
    }
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        forYouCV.backgroundColor = Theme.current.background
        trendingVC.backgroundColor = Theme.current.background
        
        forYouLabel.textColor = Theme.current.textColor
        
        trendingLabel.textColor = Theme.current.textColor

    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == forYouCV{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseableCellIdentifier, for: indexPath) as! CustomCollectionViewCell
            if let imageUrl = artistList[indexPath.row].url {
                AF.request(imageUrl).response { response in
                    if let data = response.data{
                        cell.image.image = UIImage(data: data)
                    }
                }
                
            }
            cell.label.text = artistList[indexPath.row].songs![0]
            
            return cell
           
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingIdentifier, for: indexPath) as! CustomCollectionViewCell
            if let imageUrl = artistList[indexPath.row].url {
                AF.request(imageUrl).response { response in
                    if let data = response.data{
                        cell.myimage.image = UIImage(data: data)
                    }
                }
                
            }
            cell.mylabel.text = artistList[indexPath.row].songs![0]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected: \(artistList[indexPath.row].name)")
    }

   func loadData(){
        Task{
           artistList =  await homeViewModel.getArtists()
            trendingList =  await homeViewModel.refresh()
            forYouCV.reloadData()
            trendingVC.reloadData()
        }
    }
}
