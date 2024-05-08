//
//  SettingsViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
applyTheme()
        
    }


    @IBAction func changeThemePressed(_ sender: UISwitch) {
        
        if sender.isOn{
            Theme.current  = DarkTheme()
            print(Theme.current.background)
        }
        else{
            Theme.current  = LightTheme()
            print(Theme.current.background)
        }
        
        applyTheme()
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background

    }
    
}
