//
//  EditProfileViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    private var selectedImage: UIImage? {
         didSet {
           profileImageView.image = selectedImage
         }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func changePhotoButtonPressed(_ sender: UIButton) {
        
        // display action sheet
        
        let alertController = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        alertController.view.tintColor = .black
        present(alertController, animated: true)
        
    }
    
    
    @IBAction func doneEditingProfile(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // save all changes to firebase -> user profile
        
        // get profile feilds
        guard let selectedImage = selectedImage else {
            print("CHECK FEILDS 😅")
            return
        }
        // get user
        guard let user = Auth.auth().currentUser else { return }
        
        // resize image
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileImageView.bounds)
        
        // update user profile using .createProfileChangeRequest()
        
        
    }
    
}


extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
          return
        }
         selectedImage = image
        dismiss(animated: true)
    }
}

