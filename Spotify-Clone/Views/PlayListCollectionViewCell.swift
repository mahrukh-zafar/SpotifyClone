//
//  PlayListCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Dev on 07/05/2024.
//

import UIKit

class PlayListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var artistImage: UIImageView!
    
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var menuButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        menuButton.applyThemeToButton()
        // Initialization code
    }
    
    
}
