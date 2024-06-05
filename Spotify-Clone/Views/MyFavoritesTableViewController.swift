//
//  MyFavoritesTableViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 05/06/2024.
//

import UIKit

class MyFavoritesTableViewController: UITableViewController {
    @IBOutlet var favoriteTV: UITableView!
    
    fileprivate let favoriteViewModel = MyFavoritesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
    favoriteTV.register(UINib(nibName: "LikedTableViewCell", bundle: nil), forCellReuseIdentifier: "likedCell")
        
        view.backgroundColor = Theme.current.background
        favoriteTV.applyThemeToTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        favoriteViewModel.loadFavoriteSongs()
        favoriteTV.reloadData()
        self.title = "Favorites"
        view.backgroundColor = Theme.current.background
        favoriteTV.applyThemeToTableView()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return favoriteViewModel.getSongs().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songs = favoriteViewModel.getSongs()
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell",for: indexPath) as! LikedTableViewCell
        cell.name.text = songs[indexPath.row].name
       
        cell.songIV.sd_setImage(with: URL(string: (songs[indexPath.row].url)), placeholderImage: UIImage(named: "placeholder.png"))
      
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
      return "Favorites"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playSongViewController = PlaySongViewController()
        playSongViewController.songs = favoriteViewModel.getSongs()
        playSongViewController.currentIndex = indexPath.row
        self.navigationController?.pushViewController(playSongViewController, animated: true)
    }

   
}
