//
//  Post.swift
//  InstagramProject
//
//  Created by Amy Alsaydi on 3/6/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct Post {
    let imageURL: String
    let caption: String
    let userId: String
    let userName: String
    let postDate: Date

}

extension Post {
    init(_ dictionary: [String: Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? "no image"
        self.caption = dictionary["caption"] as? String ?? "No caption"
        self.userId = dictionary["userId"] as? String ?? "no user id"
        self.userName = dictionary["username"] as? String ?? "AnonBot // no user name"
        self.postDate = dictionary["postDate"] as? Date ?? Date()
    }
}
