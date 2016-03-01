//
//  Comment.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let kPost = "post"
    private let kUsername = "username"
    private let kText = "text"
    
    let username: String
    let text: String
    let postIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "/posts/\(self.postIdentifier)/comments/"
    }
    
    var jsonValue: [String : AnyObject] {
        
        return [kPost: postIdentifier, kUsername : username, kText : text]
    }
    
    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let postIdentifier = json[kPost] as? String,
            let username = json[kUsername] as? String,
            let text = json[kText] as? String else { return nil }
        
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = identifier
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
    
}