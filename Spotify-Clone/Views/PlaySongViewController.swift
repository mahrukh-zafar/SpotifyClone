//
//  PlaySongViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import UIKit

class PlaySongViewController: UIViewController {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var loopButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
applyTheme()
        // Do any additional setup after loading the view.
    }
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        favButton.applyThemeToButton()
        songNameLabel.applyThemeToLable()
        playButton.applyThemeToButton()
        loopButton.applyThemeToButton()
        nextButton.applyThemeToButton()
        prevButton.applyThemeToButton()
        shuffleButton.applyThemeToButton()
        progressView.tintColor = Theme.current.textColor
        
    }
    
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        
        
    }
    

}
