//
//  PostController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class PostController {
    
    static func fetchTimeLineForUser(user: User, completion: (post: [Post]) -> Void) {
        
        completion(post: mockPosts())
        
    }
    
    
    static func addPost(image: String, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().first)
        
    }
    
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        completion(post: mockPosts()[1])
        
    }
    
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        completion(posts: mockPosts())
        
    }
    
    
    static func deletePost(post: Post) {
        
        
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts().first)
        
    }
    
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts()[2])
    }
    
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        completion(success: true, post: mockPosts()[1])
        
    }
    
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        
        
        completion(success: true, post: mockPosts().first)
    }
    
    
    static func orderPosts(posts: [Post]) -> [Post] {
        
        // return a sorted array of Posts
        return []
        
    }
    
    static func mockPosts() -> [Post] {
        let post1 = Post(imageEndPoint: "ljdaf;", caption: nil, username: "kitkat48", comments: [], likes: [], identifier: nil)
        let post2 = Post(imageEndPoint: "djfaslj", caption: "New person here!", username: "helloWorld", comments: [], likes: [], identifier: "djfljadjsfa")
        let post3 = Post(imageEndPoint: "xjdlsfal", caption: "another social platform", username: "morbid89", comments: [], likes: [], identifier: nil)
        
        return [post1, post2, post3]
        
    }
    
    
}































