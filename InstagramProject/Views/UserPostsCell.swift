//
//  CollectionViewCell.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/5/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import Kingfisher

class UserPostsCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    
    public func configureCell(post: Post) {
        postImageView.kf.setImage(with: URL(string: post.imageUrl))
        
    }
}
