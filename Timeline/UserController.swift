//
//  UserController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


class UserController {
    
    static let sharedController = UserController()
    
    var currentUser: User! //= UserController.mockUsers().first
    

    
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void ) {
        
        
        completion(user: mockUsers().first)
    }
    
    
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
        
        
    }
    
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
        
        
    }

    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        
        
        
    }
    
    static func userFollowsUser(user: User, otherUser: User, completion: (follows: Bool) -> Void) {
        
        
        
    }
    
    static func followedByUser(user: User, completion: (followers: [User]?) -> Void) {
        
        completion(followers: mockUsers())
        
    }
    
    
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        
        
        completion(success: true, user: mockUsers().first)
    }
    
    
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        
        completion(success: true, user: mockUsers().first)
    }
    
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        completion(success: true, user: mockUsers().first)
        
    }
    
    static func logOutCurrentUser() {
        
        
        
    }
    
    
    static func mockUsers() -> [User] {
        
        let user1 = User(username: "Diego", bio: nil, url: "http://diegoa3d.com", identifier: "jljafdsl;af")
        let user2 = User(username: "Retika", bio: "From India", url: nil, identifier: "jldasfj;ldfas")
        let user3 = User(username: "Tricia", bio: "crossfiter", url: nil, identifier: "jdlfjasdsnnvmc")
        
        
        return [user1, user2, user3]
    }
    
    
    
    
}































