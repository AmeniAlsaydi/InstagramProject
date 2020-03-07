//
//  Post.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    let caption: String
    let userID: String
    let userName: String
    let postDate: Date

}

extension Post {
    init(_ dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? "no image"
        self.caption = dictionary["caption"] as? String ?? "no caption"
        self.userID = dictionary["userID"] as? String ?? "no user id"
        self.userName = dictionary["username"] as? String ?? "no user name"
        self.postDate = dictionary["postDate"] as? Date ?? Date()
    }
}
