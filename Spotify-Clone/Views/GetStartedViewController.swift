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
    @IBOutlet weak var facebookSignIn: FBLoginButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        
    facebookSignIn?.delegate = self
//        facebookSignIn?.setImage(UIImage(named: "Facebook"), for: .normal)
//        
//        let width = 300
//                let height = 50
//        facebookSignIn.frame.size = CGSize(width: width, height: height)
//
//        facebookSignIn.layer.shadowRadius = 5.0
//        facebookSignIn.layer.cornerRadius = facebookSignIn.frame.size.height/2
        facebookSignIn.layer.borderWidth = 1
        facebookSignIn.layer.borderColor = UIColor.white.cgColor
       
//        facebookSignIn.translatesAutoresizingMaskIntoConstraints = false
//        facebookSignIn.heightAnchor.constraint(equalToConstant: 62).isActive = true
      //  facebookSignIn.backgroundColor = .systemPink
       // facebookSignIn.sizeToFit()
        
       // view.backgroundColor = ThemeManager.currentTheme.backgroundColor

     
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
    
    
    @IBAction func addToFireBase(_ sender: UIButton) {
        Task{
       await  loginViewModel.addToFirestore()
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: UIButton) {
        loginViewModel.authenticateWithGoogle(viewController: self) { (result) in
            if result
            
            {
                self.navigateToHome()
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
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}


//MARK: - Facebook Authentication Delegate

extension GetStartedViewController : LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
                  print(error.localizedDescription)
              return
              }
        guard let tokenString = AccessToken.current?.tokenString else{
            print(error)
            return
        }
        loginViewModel.authenticateWithFacebook(tokenString: tokenString) { (result) in
            if result
            
            {
                self.navigateToHome()
            }
            else{
                print("Error")
            }
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logged out")
    }
    
}

