//
//  ViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var logInButton: UIButton!
    
    
    override func viewDidLayoutSubviews() {
        logInButton.layer.cornerRadius = 8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
    }
    
}

