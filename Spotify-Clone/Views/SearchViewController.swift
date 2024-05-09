//
//  SearchViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import UIKit

class SearchViewController: UIViewController {

    var trendingArtistNames : [String] = ["A", "B", "C","D", "E", "F","A", "B", "C","D", "E", "F"]
    
    var searchedList = [Artist]()
    
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var browseCV: UICollectionView!
    @IBOutlet weak var genreCV: UICollectionView!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var searchedArtistImage: UIImageView!
    @IBOutlet weak var artistnameLabel: UILabel!
    @IBOutlet weak var yourSearchLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var browseLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchViewModel = SearchViewModel()
    
    let genreCell = "genreCell"
    let browseCell = "browseCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genreCV.delegate = self
        genreCV.dataSource = self
        browseCV.delegate = self
        browseCV.dataSource = self
        searchTextField.delegate = self
        
        searchStackView.isUserInteractionEnabled = true
        let fGuesture = UITapGestureRecognizer(target: self, action: #selector(showF(sender:)))
        searchStackView.addGestureRecognizer(fGuesture)

       
        searchTextField.leftViewMode = .always
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = Theme.current.textColor
        searchTextField.leftView = imageView
        
        Task{
        await searchViewModel.getArtists()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        applyTheme()
        
    }
    @objc func showF(sender: AnyObject){
        print("Navigate")
        let playSongViewController = PlaySongViewController()
        //playlistViewController.artist = artist
        self.navigationController?.pushViewController(playSongViewController, animated: true)
       }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        browseCV.applyThemeToCollectionView()
        genreCV.applyThemeToCollectionView()
        artistnameLabel.applyThemeToLable()
        songNameLabel.applyThemeToLable()
        genreLabel.applyThemeToLable()
        browseLabel.applyThemeToLable()
        searchLabel.applyThemeToLable()
        yourSearchLabel.applyThemeToLable()
//        forYouLabel.textColor = Theme.current.textColor
//        
//        trendingLabel.textColor = Theme.current.textColor

    }
    
    func searchSong(){
        
    }
}

extension SearchViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {

        let searchedArtist = searchViewModel.search(searchString: searchTextField.text!)
    
        
//        DispatchQueue.main.async {
//            self.songNameLabel.text =  searchedArtist?.songs?.first(where: { song in
//                song == self.searchTextField.text!
//            })
//            self.artistnameLabel.text = searchedArtist?.name
//        }
        
        songNameLabel.text =  searchedArtist?.songs?.first(where: {$0.capitalized == searchTextField.text?.capitalized})
        artistnameLabel.text = searchedArtist?.name
        
        searchViewModel.getImage(imageUrl: searchedArtist?.url) { imageData in
            DispatchQueue.main.async {
                self.searchedArtistImage.image = UIImage(data: imageData)
            }
            
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        }else
        {
            searchTextField.placeholder = "Artists, Songs or Podcasts"
            return false
        }
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
            cell.browseLabel.textColor = .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        if collectionView == browseCV{
        
        return CGSize(width: collectionViewWidth, height: collectionViewWidth/3)
        }
        else {
        return CGSize(width: 200, height: 250)
        }
        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
  
}
