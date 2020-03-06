//
//  ShareViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postingImage: UIImageView!
    
    private var selectedImage: UIImage
    
    init?(coder: NSCoder, selectedImage: UIImage) {
        self.selectedImage = selectedImage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postingImage.image = selectedImage

    }
    
    
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        // TODO:
        // 1. Create post
        // 2. Dissmiss VC and move to home tab
        // 3. Local notification that there has been a post
        
    }
    

}
