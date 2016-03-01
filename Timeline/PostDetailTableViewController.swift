//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var headerImageView: UIImageView!

    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()

        // implement a updateWithPost method that is safely unwrapped 
    }

    
    

    @IBAction func addCommentTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Comment"
        }
        
        alert.addAction(UIAlertAction(title: "Add Comment", style: .Default, handler: { (action) -> Void in
            
            if let text = alert.textFields?.first?.text {
                
                PostController.addCommentWithTextToPost(text, post: self.post!, completion: { (success, post) -> Void in
                    
                    if let post = post {
                        self.post = post
                        self.updateWithPost(post)
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func updateWithPost(post: Post) {
        
        self.post = post
        
        ImageController.imageForIdentifier(post.imageEndpoint) { (image) -> Void in
            self.headerImageView.image = image
        }
        
        tableView.reloadData()
        
    }
    
    @IBAction func likeTapped(sender: AnyObject) {
        
        PostController.addLikeToPost(post!) { (success, post) -> Void in
            if let post = post {
                self.post = post
                self.updateWithPost(post)
            }
        }
    }
    

    // MARK: - Table view data source



    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return post!.comments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postDetailCell", forIndexPath: indexPath) as! PostCommentTableViewCell

        // Configure the cell...
        
        let comment = post?.comments[indexPath.row]
        
        
        if let comment = comment {
            cell.textLabel?.text = comment.username
            cell.detailTextLabel?.text = comment.text
        }

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
