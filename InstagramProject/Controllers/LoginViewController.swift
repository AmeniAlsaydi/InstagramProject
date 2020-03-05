//
//  ViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLayoutSubviews() {
        logInButton.layer.cornerRadius = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            print("missing feilds")
            return
        }
        
        authSession.signExisitingUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    // display error
                    self.showAlert(title: "Invalid password or email", message: "\(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    print("Hello")
                    UIViewController.showViewController(storyBoardName: "MainView", viewControllerId: "MainTabBarController")
                    
                }
            }
        }
    }
}

