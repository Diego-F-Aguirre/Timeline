//
//  TimeLineTableViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    
    
    
    var posts: [Post]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let currentUser = UserController.sharedController.currentUser {
            if posts!.count > 0 {
                loadTimelineForUser(currentUser)
            }
        } else {
            tabBarController?.performSegueWithIdentifier("noCurrentUserSegue", sender:nil)
        }
    }
    
    
    func loadTimelineForUser (user: User) {
        PostController.fetchTimeLineForUser((user)) { (post) -> Void in
            if let posts = self.posts {
                self.posts = posts
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            } else {
                self.refreshControl?.endRefreshing()
            }
        }
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell

        // Configure the cell...
        
        let post = posts![indexPath.row]
        
        cell.updateWithPost(post)

        return cell
    }
    
    // MARK: Refresh Control
    
    @IBAction func userRefreshedTable(sender: AnyObject) {
        
        loadTimelineForUser(UserController.sharedController.currentUser)
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDetailView" {
            
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                
                let post = posts![indexPath.row]
                
                let destinationController = segue.destinationViewController as! PostDetailTableViewController
                
                destinationController.post = post
            }
        }
        
    }
    

}
























