//
//  LoginViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 30/04/2024.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var isloading = false
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    let loginViewModel = AuthenticationViewModel()
    override func viewDidLoad() {
        loadingLabel.text = ""
        super.viewDidLoad()
        emailTextField.text = "mahrukh@gmail.com"
        passwordTextField.text = "123456"
        applyTheme()
    }
    
    func applyTheme(){
        view.backgroundColor = Theme.current.background
        backButton.applyThemeToButton()
        loginLabel.applyThemeToLable()
        loginButton.applyThemeToFilledButton()
        loadingLabel.applyThemeToErrorLabel()
        loadingIndicator.isHidden = true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton)   {
       isloading = true
        loadingLabel.text = ""
        if isloading{
            loadingIndicator.isHidden = false
            loginButton.isHidden = true
            loadingIndicator.startAnimating()
        }
       
        guard let email = emailTextField.text else{
            return
        }
        guard let password = passwordTextField.text else{
            return
        }

        loginViewModel.login(email: email, password: password) { result, error in
            if result

            {
                FirebaseManager.shared.getArtists {
                    self.navigateToHome()
                }
            }
            else{
                self.loadingIndicator.isHidden = true
                self.loginButton.isHidden = false
                self.loadingLabel.text = error?.localizedDescription
            }
        }
       
    }
    
    
    
    func navigateToHome(){
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "homeTabBarController") as! TabBarController
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    
}
