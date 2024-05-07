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
    let loginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton)   {
        
        guard let email = emailTextField.text else{
            return
        }
        guard let password = passwordTextField.text else{
            return
        }
        
        loginViewModel.login(email: email, password: password) { (result) in
            if result
            
            {
                self.navigateToHome()
            }
            else{
                print("Error")
            }
        }
        
        
        
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func navigateToHome(){
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "homeTabBarController") as! TabBarController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    
}
