//
//  ShareViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ShareViewController: UIViewController {
    
    
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var postingImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    private var selectedImage: UIImage
    
    private let dbService = DatabaseService()
    private let storageService = StorageService()
    private let db = Firestore.firestore()
    
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
        
        guard let caption = captionTextField.text, !caption.isEmpty else {
            captionLabel.textColor = .red
            captionLabel.text = "Caption Required*"
            print("prompt user to enter caption- maybe make board red")
            return
        }
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: postingImage.bounds)
        
        // TODO:
        // 1. Create post
        
        dbService.createPost(caption: caption) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error creating item", message: error.localizedDescription)
                }
            case .success(let postId):
                self.uploadPhoto(image: resizedImage, postId: postId)

            }
        }
        
        
        
        // 2. Dissmiss VC and move to home tab
        // 3. Local notification that there has been a post
        
        
        
    }
    
    private func uploadPhoto(image: UIImage, postId: String) {
        // takes in an image and a item id
        
        storageService.uploadPhoto(postId: postId, image: image) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error uploading item photo", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                self?.updateItemImageURL(url, postId: postId)
                

            }
        }
        
        
    }
    
    private func updateItemImageURL( _ url: URL, postId: String) {
           // update am exisiitng document on firebase
        db.collection(DatabaseService.postCollecion).document(postId).updateData(["imageURL": url.absoluteString]) { [weak self] (error) in
               
               if let error = error {
                   DispatchQueue.main.async {
                       self?.showAlert(title: "failed to update post image url", message: "\(error.localizedDescription)")
                   }
               } else {
                   // everything wemt ok
                   print("all went well with update")
                   DispatchQueue.main.async {
                       self?.dismiss(animated: true)
                   }
               }
               
           }
           
       }
}
