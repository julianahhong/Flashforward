//
//  PhotoViewController.swift
//  MakeHappy
//
//  Created by Juliana Hong on 8/7/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    var emailPassed: String?
    var datePassed: NSDate?
    
    var photoTakingHelper: PhotoTakingHelper?


    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func choosePhoto(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            println("received a callback")
            self.imageView.image = image
            
            self.imageView.setupImageViewer()
        }
    }
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "segueToMessage" {
            
            if imageView.image == nil {
                
                let alertView = UIAlertController(title: "Oh no!", message: "Please choose photo", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
                
                return false
                
            }
            else {
            return true
            }
        }
        
        return true
    }

    @IBAction func unwindToPhotoVC(segue:UIStoryboardSegue) {

    }
    
    func saveImage() -> NSData {
        var imageData = UIImageJPEGRepresentation(imageView.image, 1.0)
        return imageData

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToMessage" {
            
            if let destinationVC = segue.destinationViewController as? MessageViewController{
                destinationVC.emailPassed2 = emailPassed
                destinationVC.datePassed2 = datePassed
                destinationVC.imagePassed = saveImage()
                
                
            }
        }
    }

}
