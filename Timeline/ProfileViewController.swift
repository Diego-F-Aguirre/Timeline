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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    var user: User?
    var userPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if user == nil {
            user = UserController.sharedController.currentUser
            editButtonItem().enabled = true
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
                //                self.collectinView.reloadData()
            })
        }
        
    }
    
    @IBAction func userTappedLogoutButton(sender: AnyObject) {
        
        
        self.user = nil
        self.tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
    }
    
    
    
    // MARK: DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("profileCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let post = userPosts[indexPath.item]
        
        cell.updateWithImageIdentifier(post.imageEndpoint)
        
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
    
    
    
    
    
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "toEditProfile" {
            
            let destinationViewController  = segue.destinationViewController as? LoginSignUpViewController
            destinationViewController?.user = user
            
        } else if segue.identifier == "profileToPostDetail" {
            
            if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPathForCell(cell) {
                
                let post = userPosts[indexPath.item]
                
                let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                
                destinationViewController?.post = post
                
                
            }
        }
    }
   
    
}

















