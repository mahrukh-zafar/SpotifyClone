//
//  ViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 29/04/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FirebaseFirestore


class GetStartedViewController: UIViewController{
    
    
    @IBOutlet weak var googleSignIn: GIDSignInButton!
    
    @IBOutlet weak var spotifyLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var freeSpotifyLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    let loginViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        if UserDefaults.standard.bool(forKey: "logged In"){
            navigateToHome()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        signUpButton.applyThemeToFilledButton()
        loginButton.applyThemeToButton()
        spotifyLabel.applyThemeToLable()
        freeSpotifyLabel.applyThemeToLable()
    }
    
    
    
    @IBAction func googleSignInPressed(_ sender: UIButton) {
        loginViewModel.authenticateWithGoogle(viewController: self) { (result) in
            if result
                
            {
                FirebaseManager.shared.getArtists {
                    self.navigateToHome()
                }
            }
            else{
                print("Error")
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
        
    }
    
    func navigateToHome(){
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "homeTabBarController") as! TabBarController
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
}
