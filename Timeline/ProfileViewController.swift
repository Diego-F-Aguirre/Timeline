//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, ProfileHeaderCollectionReusableViewDelegate {
    
    var user: User?
    var userPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print(user)
    }
    
    func updateBasedOnUser() {
        
        self.title = user?.username
        
        PostController.postsForUser(user!) { (posts) -> Void in
            if let posts = posts {
                self.userPosts = posts
            } else {
                self.userPosts = []
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                self.collectinView
            })
        }
        
    }
    
    
    // MARK: DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let post = userPosts[indexPath.item]
     
        cell.updateWithImageIdentifier(post.imageEndPoint)
        
        return cell
    }
    
    // MARK: Profile Header Reusable Delegate
    
    func userTappedFollowActionButton() {
        
        guard let user = user else { return }
        
        if user == UserController.sharedController.currentUser {
            
            UserController.logOutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
            
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, otherUser: user) { (follows) -> Void in
                
                if follows {
                    UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(self.user!, completion: { (success) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                }
            }
        }
    }
    
    func userTappedURLButton() {
        
        if let profileURL = NSURL(string: (user?.url)!) {
            
            let safariViewController = SFSafariViewController(URL: profileURL)
            
            self.presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
