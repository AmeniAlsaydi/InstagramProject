//
//  ProfileViewController.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var listener: ListenerRegistration?
    
    private var userPosts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
       
        editProfileButton.layer.borderColor = #colorLiteral(red: 0.06776300818, green: 0.06778242439, blue: 0.06776044518, alpha: 1)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 7
        userImageView.layer.cornerRadius = userImageView.frame.width/2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        print("user id \(user.uid)")
        
        listener = Firestore.firestore().collection(DatabaseService.postCollecion).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Try again later", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { Post($0.data())}
                self?.userPosts = posts.filter { $0.userId == user.uid }
            }
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        loadUserInfo()

    }
    
    private func loadUserInfo() {
        // load feilds with already saved user info - profile pic, display name aka username, Bio , phone number?
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        if let photoUrl = user.photoURL {
            userImageView.kf.setImage(with: photoUrl)

        }
        
        if let username = user.displayName {
            navigationItem.title = username
        }
        
        // user.email
        // user.phoneNumber
        // user.photoURL
        
        
        
    }

}


extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? UserPostsCell else {
            fatalError("could mot dowmcast to postCell")
        }
        
        let post = userPosts[indexPath.row]
        cell.configureCell(post: post)
        return cell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let interItemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width // device width
        
        let numberOfItems: CGFloat = 3
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // padding surounding collectionview
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
