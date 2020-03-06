//
//  AddViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    private lazy var imagePickerController: UIImagePickerController = {
      let ip = UIImagePickerController()
      ip.delegate = self
      return ip
    }()
    
    override func viewDidLayoutSubviews() {
        libraryButton.layer.cornerRadius = 7
        cameraButton.layer.cornerRadius = 7
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func libraryButtonPressed(_ sender: UIButton) {
        // present library - image picker
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true)
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIButton) {
        // present camera
        // if no camera have an alert to tell them "No Camera"
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        } else {
            showAlert(title: "Error", message: "No Camera available 😕")
        }
    }
}


extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
      return
    }
    dismiss(animated: true, completion: nil)
    // get instance of the storyboard
    let appViewStoryboard = UIStoryboard(name: "MainView", bundle: nil)
    let sharedVC = appViewStoryboard.instantiateViewController(identifier: "ShareViewController") { (coder) in
      return ShareViewController(coder: coder, selectedImage: image)
    }
    sharedVC.modalPresentationStyle = .fullScreen
    //sharedVC.modalTransitionStyle = .crossDissolve
    present(UINavigationController(rootViewController: sharedVC), animated: true)
    
    
  }
}
