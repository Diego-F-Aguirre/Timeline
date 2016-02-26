//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    var userDataSource: [User] = []
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()
        setUpSearchController()
    }
    
    
    enum ViewMode: Int {
        case Friends
        case All
        
        func users(completion: (users: [User]?) -> Void) {
            
            switch self {
                
            case .Friends:
                UserController.followedByUser(UserController.sharedController.currentUser, completion: { (followers) -> Void in
                    completion(users: followers)
                })
            case .All:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    var mode: ViewMode {
        switch modeSegmentedControl.selectedSegmentIndex {
        case 0:
            return .Friends
        case 1:
            return .All
        default:
            return .Friends
        }
    }
    
    func updateViewBasedOnMode() {
        
        mode.users { (users) -> Void in
            
            if let users = users {
                self.userDataSource = users
            } else {
                self.userDataSource = []
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func selectedIndexChanged(sender: AnyObject) {
        updateViewBasedOnMode()
    }
    
    
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //
    //
    //        return 0
    //    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("usernameCell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        let user = userDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        
        
        return cell
    }
    
    // MARK: - SearchController
    
    func setUpSearchController() {
        
        let resultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsVC")
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text ?? ""
        let lowerCaseSearchTerm = searchTerm.lowercaseString
        
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
        
        resultsViewController.usersResultsDataSource = userDataSource.filter({$0.username.lowercaseString.containsString(lowerCaseSearchTerm)})
        resultsViewController.tableView.reloadData()
        
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
