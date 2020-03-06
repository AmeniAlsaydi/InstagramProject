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
    
    private let userPosts = [Post]() // didSet?
    
    
    override func viewDidLayoutSubviews() {
       
        editProfileButton.layer.borderColor = #colorLiteral(red: 0.06776300818, green: 0.06778242439, blue: 0.06776044518, alpha: 1)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 7

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        // display view to edit the profile
        // just a segue dont need this anymore 
        
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
