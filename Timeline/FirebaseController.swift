//
//  FirebaseController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = Firebase(url: "https://timelinediego.firebaseio.com")
    
    static func dataAtBaseEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        let baseForEndpoint = base.childByAppendingPath(endpoint)
        
        baseForEndpoint.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
        
    }
    
    
    static func observeDataAtBaseEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
        let baseForEndpoint = base.childByAppendingPath(endpoint)
        
        baseForEndpoint.observeEventType(.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
            
        })
    }
}

protocol FirebaseType {
    
    var identifier: String? {get set}
    var endpoint: String { get }
    var jsonValue: [String : AnyObject] { get }
    
    init?(json: [String: AnyObject], identifier: String)
    
    mutating func save()
    func delete()
    
}

extension FirebaseType {
    
    mutating func save() {
        
        var endpointBase: Firebase
        
        if let childID = self.identifier {
            endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(childID)
        } else {
            endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAutoId()
            self.identifier = endpointBase.key
        }
        
        endpointBase.updateChildValues(self.jsonValue)
    }
    
    func delete() {
        let endpointBase: Firebase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(self.identifier)
        
        endpointBase.removeValue()
    }
}






























