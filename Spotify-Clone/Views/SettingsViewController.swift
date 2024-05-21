//
//  SettingsViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 08/05/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: "DarkTheme")
    }
    
    
    @IBAction func changeThemePressed(_ sender: UISwitch) {
        
        Theme.current = sender.isOn ? DarkTheme() : LightTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "DarkTheme")
        applyTheme()
    }
    @IBAction func signOutPressed(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "logged In")
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "getStartVC") as! GetStartedViewController
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
      
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        themeLabel.applyThemeToLable()
        navigationController?.navigationBar.applyThemeToNavBar()
        signOutBtn.applyThemeToButton()
        
    }
    
}
