//
//  FeedCell.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/7/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postedImage: UIImageView!
    @IBOutlet weak var bottomUsernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func layoutSubviews() {
        userImage.layer.cornerRadius = userImage.frame.width/2
    }
    
    public func configureCell(post: Post) {
        // figure out user image
        usernameLabel.text = post.userName
        postedImage.kf.setImage(with: URL(string: post.imageURL))
        bottomUsernameLabel.text = "@\(post.userName)"
        captionLabel.text = post.caption
        
    }
}
