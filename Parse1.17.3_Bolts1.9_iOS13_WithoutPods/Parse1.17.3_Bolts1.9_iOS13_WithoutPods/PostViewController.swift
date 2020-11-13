//
//  PostViewController.swift
//  Parse1.17.3_Bolts1.9_iOS13_WithoutPods
//
//  Created by AlphaCoders on 12/11/20.
//  Copyright © 2020 Back4app. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var message: UITextField!
    
    @IBOutlet weak var AddImage: UIButton!
    
    
    @IBAction func AddImage(_ sender: Any) {
        
        // To grab the image.
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // To upload the image to imageView
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            
            ImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func PostImage(_ sender: Any) {
        
        let post = PFObject(className: "Posts")
        
        post["message"] = message.text
        post["userid"] = PFUser.current()?.objectId!
        
        let imageData = ImageView.image!.pngData()
        let imageFile = PFFileObject(name: "image.png", data: imageData!)    // PFFile(name: "image.png", data: imageData! )
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            UIApplication.shared.endIgnoringInteractionEvents() // UIApplication.shared() is now UIApplication.shared
            
            if error != nil {
                
                self.createAlert(title: "Could not post image", message: "Please try again later")
                
            } else {
                
                self.createAlert(title: "Image Posted!", message: "Your image has been posted successfully")
                
                self.message.text = ""
                
                 self.ImageView.image = UIImage(named: "real eye png hd - 595x514.png")
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageView.image = UIImage(named: "real eye png hd - 595x514.png")
        // Do any additional setup after loading the view.
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
