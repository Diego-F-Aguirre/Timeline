//
//  PostController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit


class PostController {
    
    static func fetchTimeLineForUser(user: User, completion: (post: [Post]) -> Void) {
        
//        completion(post: mockPosts())
        
    }
    
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
        ImageController.uploadImage(image) { (identifier) -> Void in
            
            if let identifier = identifier {
                var post = Post(imageEndpoint: identifier, caption: caption)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
        
    }
    
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        FirebaseController.dataAtBaseEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String : AnyObject] {
                let post = Post(json: data, identifier: identifier)
                
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
        
    }
    
    
    static func postsForUser(user: User, completion: (posts: [Post]?) -> Void) {
        
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let postDictionaries = snapshot.value as? [String : AnyObject] {
                
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                
                let orderedPosts = orderPosts(posts)
                
                completion(posts: orderedPosts)
            } else {
                completion(posts: nil)
            }
            
        })
        
    }
    
    
    static func deletePost(post: Post) {
        
        post.delete()
        
    }
    
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postIdentifier = post.identifier {
            
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier, completion: { (post) -> Void in
                completion(success: true, post: post)
            })
        } else {
            
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier, completion: { (post) -> Void in
                completion(success: true, post: post)
            })
        }
        
    }
    
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        
        comment.delete()
        
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postIdentifier = post.identifier {
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
        } else {
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        
        PostController.postFromIdentifier(post.identifier!) { (post) -> Void in
            completion(success: true, post: post)
        }
        
    }
    
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        
        like.delete()
        
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }

    }
    
    
    static func orderPosts(posts: [Post]) -> [Post] {
        
        // return a sorted array of Posts
        return posts.sort({$0.0.identifier > $0.1.identifier})
        
    }
    
//    static func mockPosts() -> [Post] {
//        let post1 = Post(imageEndPoint: "ljdaf;", caption: nil, username: "kitkat48", comments: [], likes: [], identifier: nil)
//        let post2 = Post(imageEndPoint: "djfaslj", caption: "New person here!", username: "helloWorld", comments: [], likes: [], identifier: "djfljadjsfa")
//        let post3 = Post(imageEndPoint: "xjdlsfal", caption: "another social platform", username: "morbid89", comments: [], likes: [], identifier: nil)
//        
//        return [post1, post2, post3]
//        
//    }
    
    
}































