//
//  UserTableViewController.swift
//  Parse1.17.3_Bolts1.9_iOS13_WithoutPods
//
//  Created by AlphaCoders on 12/11/20.
//  Copyright © 2020 Back4app. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {
    
    var usernames = [""]
    var userIDs = [""]
    var isFollowing = ["" : false]
    
    
    @IBAction func goBack(_ sender: Any) {
        
        performSegue(withIdentifier: "goBack", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error ) in
            
            if error != nil{
                
                print(error)
            }
            else if let users = objects {
                
                self.usernames.removeAll()
                self.userIDs.removeAll()
                self.isFollowing.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser{
                        
                        if user.objectId != PFUser.current()?.objectId{
                            
                            let usernameArray = user.username!.components(separatedBy: "@")
                            
                            self.usernames.append(usernameArray[0])
                            self.userIDs.append(user.objectId!)
                            
                            let query = PFQuery(className: "Followers")
                            
                            query.whereKey("Follower", equalTo: (PFUser.current()?.objectId)!)
                            query.whereKey("Following", equalTo: user.objectId!)
                            
                            query.findObjectsInBackground(block: { ( objects, error ) in
                                
                                if let objects = objects {
                                    
                                    if objects.count > 0{
                                        
                                        self.isFollowing[user.objectId!] = true
                                    }
                                    else{
                                        
                                        self.isFollowing[user.objectId!] = false
                                    }
                                    if self.isFollowing.count == self.usernames.count{
                                        
                                        self.tableView.reloadData()
                                    }
                                }
                            })
                        }
                    }
                }
            }
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = usernames[indexPath.row]
        // Configure the cell...
        if isFollowing[userIDs[indexPath.row]]!{
            
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if isFollowing[userIDs[indexPath.row]]! {
            
            isFollowing[userIDs[indexPath.row]] = false
            
            cell?.accessoryType = UITableViewCell.AccessoryType.none
            
            let query = PFQuery(className: "Followers")
            
            query.whereKey("Follower", equalTo: (PFUser.current()?.objectId!)!)
            query.whereKey("Following", equalTo: userIDs[indexPath.row])
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        object.deleteInBackground()
                        
                    }
                    
                }
                
            })
        }
        else {
            
            isFollowing[userIDs[indexPath.row]] = true
        
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
            let following = PFObject(className: "Followers")
        
            following["Follower"] = PFUser.current()?.objectId
            following["Following"] = userIDs[indexPath.row]
        
            following.saveInBackground()
            
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
