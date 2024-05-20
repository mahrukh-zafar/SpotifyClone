//
//  SearchViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 03/05/2024.
//

import UIKit

class SearchViewController: UIViewController {

    var trendingArtistNames : [String] = ["A", "B", "C","D", "E", "F","A", "B", "C","D", "E", "F"]
    
    var searchedArtist = ArtistRealm()
    
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var searchLabel: UILabel!
    
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var searchedArtistImage: UIImageView!
    @IBOutlet weak var artistnameLabel: UILabel!
    @IBOutlet weak var yourSearchLabel: UILabel!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var searchViewModel = SearchViewModel()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchTextField.delegate = self
        
        searchStackView.isUserInteractionEnabled = true
        let fGuesture = UITapGestureRecognizer(target: self, action: #selector(showF(sender:)))
        searchStackView.addGestureRecognizer(fGuesture)
        
       
        searchTextField.leftViewMode = .always
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = Theme.current.textColor
        searchTextField.leftView = imageView
        
        searchViewModel.getArtists()
        
        let lastSearched = UserDefaults.standard.string(forKey: "last searched")
        
        if let lastSearchedArtist = searchViewModel.search(searchString: lastSearched!){
        searchedArtist = lastSearchedArtist
            songNameLabel.text =  searchedArtist.songs.first(where: { $0.name.capitalized == searchedArtist.name.capitalized
            })?.name
            artistnameLabel.text = searchedArtist.name
            searchedArtistImage.sd_setImage(with: URL(string: (searchedArtist.url)!), placeholderImage: UIImage(named: "placeholder.png"))
            
        }
        //searchedArtist = searchViewModel.search(searchString: lastSearched!)!
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTextField.text?.removeAll()
        notFoundLabel.text = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        applyTheme()
        
    }
    @objc func showF(sender: AnyObject){
        print("Navigate")
        let playListViewController = PlaylistViewController()

        playListViewController.artistRealm = searchedArtist

        self.navigationController?.pushViewController(playListViewController, animated: true)
       }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
    
        
        artistnameLabel.applyThemeToLable()
        songNameLabel.applyThemeToLable()
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

        if let artist = searchViewModel.search(searchString: searchTextField.text!){
            searchedArtist = artist
            songNameLabel.text =  searchedArtist.songs.first(where: { $0.name.capitalized == searchedArtist.name.capitalized
            })?.name
            
            artistnameLabel.text = searchedArtist.name
            searchedArtistImage.sd_setImage(with: URL(string: (searchedArtist.url)!), placeholderImage: UIImage(named: "placeholder.png"))

        }
        else{
            if let query = searchTextField.text{
                notFoundLabel.text = "\(query) not found"}
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


