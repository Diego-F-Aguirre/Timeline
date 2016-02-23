//
//  Like.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Like: Equatable {
    
    let username: String
    let postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String, identifier: String?) {
        
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
}

func ==(lhs: Like, rhs: Like) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
    
}