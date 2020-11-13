//
//  FeedViewController.swift
//  Parse1.17.3_Bolts1.9_iOS13_WithoutPods
//
//  Created by AlphaCoders on 13/11/20.
//  Copyright © 2020 Back4app. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users = [String : String]()
    var messages = [String]()
    var imageFiles = [PFFileObject]()
    
    @IBOutlet weak var usernameTextField: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the username and name filed to current usrname
        let usernameArray = PFUser.current()?.username?.components(separatedBy: "@")
        usernameTextField.title = usernameArray![0]
        nameTextField.text = usernameArray![0]
        
        
        /*
        // Upating images from the aws server
        let query = PFUser.query()
        query?.findObjectsInBackground(block: { (objects, error ) in
            
            /*  if let users = objects{
                
                self.users.removeAll()
                
                for object in users {
                    
                    if let user = objects as? PFUser{
                        
                        self.users[user.objectId!] = user.username
                    }
                }
            } */
            
            let getFollowedUsersQuery = PFQuery(className: "Followers")
            
            getFollowedUsersQuery.whereKey("Follower", equalTo: (PFUser.current()?.objectId!)!)
            
            getFollowedUsersQuery.findObjectsInBackground(block: { ( objects, error ) in
                
                if let followers = objects {
                    
                    for object in followers{
                        
                        if let follower = object as? PFObject {
                            
                            let followedUser = follower["Following"] as? String
                            
                            let query = PFQuery(className: "Posts")
                            query.whereKey("userid", equalTo: followedUser)
                            
                            query.findObjectsInBackground(block: { (objects, error) in
                                
                                if let posts = objects {
                                    
                                    for object in posts {
                                        
                                        if let post = object as? PFObject {
                                            
                                            self.messages.append(post["message"] as! String)
                                            
                                            self.imageFiles.append(post["imageFile"] as! PFFileObject)
                                            
                                           // self.usernames.append(self.users[post["userid"] as! String]!)
                                            
                                            
                                            //self.reloadInputViews()
                                            
                                           // self.tableView.reloadData()
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            })
        })
        */
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath ) // as! FeedTableViewCell
        
        /* imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
            
                if let downloadedImage = UIImage(data: imageData) {
                
                    cell.imagePosted.image = downloadedImage
                
                }
                
            }
            
        }
        
        cell.imagePosted.image = UIImage(named: "real eye png hd - 595x514.png")
        
        // cell.usernameLabel.text = usernames[indexPath.row]
        
        cell.caption.text = messages[indexPath.row] */
        
        return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
