//
//  SignUpViewController.swift
//  Spotify-Clone
//
//  Created by Dev on 30/04/2024.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let signUpViewModel = SignUpViewModel()
    
    let firebaseManager = FirebaseManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        guard let email = emailTextField.text else{
            return
        }
        guard let password = passwordTextField.text else{
            return
        }
        signUpViewModel.signUp(email: email, password: password) { (result) in
            if result
            
            {
                
                let story = UIStoryboard(name: "Main", bundle:nil)
                let vc = story.instantiateViewController(withIdentifier: "homeTabBarController") as! TabBarController
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                
            }
            else{
                print("Error")
            }
        }
      
    }
    
}
