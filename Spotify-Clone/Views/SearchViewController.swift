//
//  SearchViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var searchVC: UICollectionView!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    
    @IBOutlet weak var searchedArtistImage: UIImageView!
    @IBOutlet weak var artistnameLabel: UILabel!
    @IBOutlet weak var yourSearchLabel: UILabel!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchViewModel = SearchViewModel()
    var searchArtistList = [ArtistRealm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.register(UINib(nibName:"PlayListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
        searchVC.delegate = self
        searchVC.dataSource = self
        searchTextField.delegate = self
        
        
        
        searchTextField.leftViewMode = .always
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        
        imageView.frame = CGRect(x: 8, y: searchTextField.frame.height/3, width: 16, height: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: searchTextField.frame.height))
        paddingView.addSubview(imageView)
        imageView.tintColor = .black
        searchTextField.leftView = paddingView
        
        searchViewModel.getArtists()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        searchTextField.text?.removeAll()
        notFoundLabel.text = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        applyTheme()
        
    }
    
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        searchLabel.applyThemeToLable()
        yourSearchLabel.applyThemeToLable()
        notFoundLabel.applyThemeToLable()
        searchVC.applyThemeToCollectionView()
        
    }
    func navigateToPlayListScreen(artist : ArtistRealm){
        
        let playListViewController = PlaylistViewController()
        playListViewController.artistRealm = artist
        
        self.navigationController?.pushViewController(playListViewController, animated: true)
    }
    
    func searchSong(){
        
    }
}

extension SearchViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //        if let artist = searchViewModel.search(searchString: searchTextField.text!){
        //            setSearchedArtist(artist: artist, searchString: searchTextField.text!)
        //            notFoundLabel.text = ""
        //        }
        //        else{
        //            if let query = searchTextField.text{
        //                notFoundLabel.text = "\(query) not found"}
        //        }
        
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let searchString = searchTextField.text{
            if searchString != ""{
                searchArtistList = searchViewModel.liveSearch(searchQuery: searchString)
                if searchArtistList.isEmpty {
                    notFoundLabel.text = "\(searchString) not found"
                }
                else{
                    notFoundLabel.text = ""
                }
                
            }
            else{
                searchArtistList.removeAll()
            }
            searchVC.reloadData()
        }
        
    }
    
}


extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArtistList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as! PlayListCollectionViewCell
        
        let songName = searchArtistList[indexPath.row].name.capitalizingFirstLetter()
        cell.songName.text = songName
        cell.songName.applyThemeToLable()
        
        cell.artistImage.sd_setImage(with: URL(string: (searchArtistList[indexPath.row].url!)), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToPlayListScreen(artist: searchArtistList[indexPath.row])
    }
    
    
}
