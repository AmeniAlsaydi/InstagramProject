//
//  EditProfileViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private let storageService = StorageService()
    
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
    
    override func viewDidLayoutSubviews() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInfo()
    }
    
    private func loadUserInfo() {
        // load feilds with already saved user info - profile pic, display name aka username, Bio , phone number?
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        if let photoUrl = user.photoURL {
            profileImageView.kf.setImage(with: photoUrl)
        }
        
        selectedImage = profileImageView.image
        
        if let username = user.displayName {
            usernameTextField.text = username
        }
        
        if let userEmail = user.email {
            emailTextField.text = userEmail
        }
    }
    
    
    @IBAction func changePhotoButtonPressed(_ sender: UIButton) {
        
        // display action sheet
        
        let alertController = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { alertAction in
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
       // dismiss(animated: true, completion: nil)
        // save all changes to firebase -> user profile
        
        // get profile feilds
        guard let selectedImage = selectedImage else { // unless they change the image it will return
            print("CHECK FEILDS 😅")
            return
        }
        // get user
        guard let user = Auth.auth().currentUser else { return }
        
        // resize image
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileImageView.bounds)
        
        // update user profile using .createProfileChangeRequest()
        
        storageService.uploadPhoto(userId: user.uid, image: resizedImage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "error uploading photo/ updating profile", message: "\(error.localizedDescription)")
            case .success(let url):
                let request = Auth.auth().currentUser?.createProfileChangeRequest()
                
                if let userName = self?.usernameTextField.text, !userName.isEmpty {
                    request?.displayName = userName
                }
                    request?.photoURL = url
              
                
                request?.commitChanges(completion: { [unowned self] (error) in
                    if let error = error  {
                        DispatchQueue.main.async {
                            self?.showAlert(title: "Error updating profile", message: "Error: changing an alert \(error.localizedDescription) ")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.showAlert(title:"Profile change" , message: "profile successfully created")
                        }
                    }
                })
            }

        }
        print("!!!")
        
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
