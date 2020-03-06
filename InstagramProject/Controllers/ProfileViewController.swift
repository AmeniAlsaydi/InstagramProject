//
//  ProfileViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLayoutSubviews() {
       
        editProfileButton.layer.borderColor = #colorLiteral(red: 0.06776300818, green: 0.06778242439, blue: 0.06776044518, alpha: 1)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 7

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func addNewImageButtonPressed(_ sender: Any) {
        
    }
    
    

}
