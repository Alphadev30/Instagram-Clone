//
//  ViewController.swift
//  Parse1.17.3_Bolts1.9_iOS13_WithoutPods
//
//  Created by Venom on 06/04/20.
//  Copyright © 2020 Back4app. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Home Page
    
    
    @IBAction func Heart(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ShowUserTable", sender: self)    }
    
    @IBAction func LogOut(_ sender: Any) {
        
        PFUser.logOut()
        self.performSegue(withIdentifier: "toLogout", sender: self)
        
    }
    @IBOutlet weak var StoryCol: UICollectionView!
    
    @IBOutlet weak var MainCol: UICollectionView!
    
    var imageArray = [UIImage(named: "6"), UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "7"),UIImage(named: "4"),
                      UIImage(named: "5"),UIImage(named: "8"),UIImage(named: "1"), UIImage(named: "9"),]
    
    var images = [UIImage(named: "Home1"), UIImage(named: "Home4"), UIImage(named: "Home3"), UIImage(named: "Home2"),]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == MainCol){
           
            return images.count
        }
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = StoryCol.dequeueReusableCell(withReuseIdentifier: "HomeController", for: indexPath) as! HomeController
        cell.StoryCells.image = imageArray[indexPath.row]
        
        if (collectionView == MainCol) {
            
            
            let cell2 = MainCol.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
            
           
            
            cell2.ImagesCell.image = images[indexPath.row]
            
            return cell2
        }
        
        return cell
    }
    
    
    
    
    
  // Login and Signup Page
    var signupMode = true

    var activityIndicator = UIActivityIndicatorView()
    
    func createAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)    }

    @IBOutlet weak var EmailTextFiled: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var LoginOrSignup: UIButton!
    
    @IBOutlet weak var ChangeMode: UIButton!
    
    @IBOutlet weak var ChangeSignupMode: UIButton!
    
    @IBAction func LoginOrSignup(_ sender: Any) {
        
        if EmailTextFiled.text == "" || PasswordTextField.text == ""{
            
            createAlert(title: "Error in Form", message: "Please Enter A valid Username And Password")
        }
        else{
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y:0 ,width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.medium
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                
                // Sign UP
                
                let user = PFUser()
                
                user.username = EmailTextFiled.text
                user.email = EmailTextFiled.text
                user.password = PasswordTextField.text
                
                user.signUpInBackground(block: { ( success, error ) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil{
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        
                        print("user signed up")
                        
                        self.performSegue(withIdentifier: "loginToMain", sender: self)
                        
                    }
                })
            }
            else{
                
                // Login
                
                PFUser.logInWithUsername(inBackground: EmailTextFiled.text! , password: PasswordTextField.text! , block: { ( user, error ) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now  UIApplication.shared
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        let error = error as NSError?
                        
                        if let errorMessage = error?.userInfo["error"] as? String {
                            
                            displayErrorMessage = errorMessage
                            
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                        
                    } else {
                        
                        print("Logged in")
                        
                        self.performSegue(withIdentifier: "loginToMain", sender: self)
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var ChangeTheTextSorL: UILabel!
    
    @IBAction func ChangeSignupMode(_ sender: Any) {
        
        if signupMode{
            
            //Change To login Mode
            
            LoginOrSignup.setTitle(" Log in", for: [])
            ChangeSignupMode.setTitle("Sign Up", for: [])
            ChangeTheTextSorL.text = " Dont have an Acoount ? "
            signupMode = false
        }
        else{
            
            // change to Signup Mode
            
            LoginOrSignup.setTitle(" Sign Up", for: [])
            ChangeSignupMode.setTitle("Log in", for: [])
            ChangeTheTextSorL.text = " Already have an account?? "
            signupMode = true
            
        }
    }
    
  /*  override func viewDidAppear(_ animated: Bool) {
        
        // If logged in, page Will redirect to Home Screen automatically
        if PFUser.current() != nil{
            
            self.performSegue(withIdentifier: "loginToMain", sender: self)
        }
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}




