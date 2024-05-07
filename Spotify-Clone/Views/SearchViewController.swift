//
//  SearchViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import UIKit

class SearchViewController: UIViewController {

    var trendingArtistNames : [String] = ["A", "B", "C","D", "E", "F","A", "B", "C","D", "E", "F"]
    
    @IBOutlet weak var browseCV: UICollectionView!
    @IBOutlet weak var genreCV: UICollectionView!
    
    @IBOutlet weak var searcTextField: UITextField!
    let genreCell = "genreCell"
    let browseCell = "browseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreCV.delegate = self
        genreCV.dataSource = self
        
        browseCV.delegate = self
        browseCV.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
        
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        browseCV.backgroundColor = Theme.current.background
        genreCV.backgroundColor = Theme.current.background
        
//        forYouLabel.textColor = Theme.current.textColor
//        
//        trendingLabel.textColor = Theme.current.textColor

    }
}

extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingArtistNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == genreCV{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCell, for: indexPath) as! CustomCollectionViewCell
            
            cell.genreLabel.text = trendingArtistNames[indexPath.row]
            
            cell.contentView.backgroundColor = .systemTeal
           
            //cell.genreLabel.textColor = .white
            return cell
           
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: browseCell, for: indexPath) as! CustomCollectionViewCell
            cell.contentView.backgroundColor = .systemPink
            
            cell.browseLabel.text = trendingArtistNames[indexPath.row]
            cell.browseLabel.textColor = .black
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == genreCV{
            return CGSize(width: 110, height: 110)
        }else{
            return CGSize(width: 140, height: 140)
        }
        }
  
}
