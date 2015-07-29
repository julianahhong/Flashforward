
//
//  Display.swift
//  MakeHappy
//
//  Created by Juliana Hong on 7/21/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit
import Parse

class Display: UIViewController {

    @IBOutlet var displayImage: UIImageView!

    @IBOutlet var throwbackFromLabel: UILabel!
    @IBOutlet var displayMessage: UILabel!
    @IBOutlet var displayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //when display button pressed, display image
    
    @IBAction func displayImage(sender: AnyObject)
    {
        showImage()
        showMessage()
    }

    var entriesViewController: EntriesViewController? = EntriesViewController()
    
    func showImage() {
        //Retrieving the image back involves calling one of the getData variants on the PFFile. Here we retrieve the image file off another UserPhoto named anotherPhoto:

        var query = PFQuery(className: "Entry")
        query.orderByDescending("createdAt")
        
        var object: Void = query.getFirstObjectInBackgroundWithBlock {
        (object: PFObject?, error: NSError?) -> Void in
        if error != nil || object == nil {
            println("The getFirstObject request failed.")
        } else {
            // The find succeeded.
            println("Successfully retrieved the object.")
            
            var pFFileImage: AnyObject? = object?.objectForKey("Image") //PFFile
            pFFileImage!.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.displayImage.image = image
                        println("Yay")
                    }
                }
            }
            

        }
            
    }

}
    
    func showMessage() {
        
        var query = PFQuery(className: "Entry")
        query.orderByDescending("createdAt")
        
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil {
                println("Noooo")
            } else {
                // The find succeeded.
                var message: AnyObject? = object?.objectForKey("Message")
                self.displayMessage.text = message as? String
                
                //adding throwback date to title label
                var throwbackDate: String? = object?.objectForKey("createdDate") as? String
                self.throwbackFromLabel.text = "Throwback from: " + throwbackDate!
            }
        }
        
    
    }
    
}


