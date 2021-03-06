//
//  SignUpViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! 
    
    override func viewDidLayoutSubviews() {
        signUpButton.layer.cornerRadius = 8
    }
    
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logInButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            self.showAlert(title: "Missing feilds", message: "Please provide an email and password.")
            return
        }
        
        authSession.createNewUser(email: email, password: password) { (result) in
        switch result {
        case .failure(let error):
            DispatchQueue.main.async {
                self.showAlert(title: "Error Signing up", message: "\(error.localizedDescription)")

            }
        case .success:
            DispatchQueue.main.async {
                UIViewController.showViewController(storyBoardName: "MainView", viewControllerId: "MainTabBarController")

            }
        }
    }
}
}

