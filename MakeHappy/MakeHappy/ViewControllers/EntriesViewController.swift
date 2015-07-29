
//
//  EntriesViewController.swift
//  MakeHappy
//
//  Created by Juliana Hong on 7/23/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//


import UIKit
import Foundation
import Parse

class EntriesViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet var selectPhotoButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var messageTextView: UITextView!
    
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var entrySavedLabel: UILabel!
    
    @IBOutlet var chooseDateButton: UIButton!
    
    var currentDate = NSDate()
    let picker = UIImagePickerController()
    
    var selectedDate = NSDate()
    let formatter = NSDateFormatter()

    //App loads
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = "Today's Date: " + getCurrentDate()
        picker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDate() -> String {
//        let formatter = NSDateFormatter()
        //formats date to "Month, Day, Year"
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        var dateString = formatter.stringFromDate(currentDate)
        return dateString
    }
    
    
    func saveEntryToParse() {
        let entry = PFObject(className: "Entry")
        var messageText = messageTextView.text
        
        var imageData = UIImageJPEGRepresentation(imageView.image, 1.0)
        var imageFile = PFFile(data: imageData)
        imageFile.saveInBackground()
        //var chooseDate: String! = chooseDateButton.titleLabel?.text
        
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")

        var notificationDate = formatter.stringFromDate(selectedDate)
        
        entry["Image"] = imageFile
        entry["Message"] = messageText
        entry["NotificationDate"] = notificationDate
        entry["createdDate"] = getCurrentDate()
        
        println(notificationDate)
        
        entry.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Entry has been saved.")
        }
        entrySavedLabel.text = "Entry has been saved!"
        
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        saveEntryToParse()

//        PFCloud.callFunctionInBackground("sendEmail", withParameters: nil) { (result, error) -> Void in
//            if ( error === nil) {
//                NSLog("Email: \(result) ")
//            }
//            else if (error != nil) {
//                NSLog("Ahhh")
//            }
//        }
    }
    
    @IBAction func photoFromLibrary(sender: AnyObject) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func unwindChooseDateVC(segue: UIStoryboardSegue) {
        if let svc = segue.sourceViewController as? ChooseDateVC {
            let formatter = NSDateFormatter()
            //formats date to "Month, Day, Year"
            
            formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            formatter.timeStyle = NSDateFormatterStyle.ShortStyle

            var notificationDate = formatter.stringFromDate(svc.datePicker.date)
            self.chooseDateButton.setTitle(notificationDate, forState: .Normal)
            
            selectedDate = svc.datePicker.date
            
        }
    
    }
    
//    func datePickerChanged(datePicker:UIDatePicker) {
//        var dateFormatter = NSDateFormatter()
//        
//        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
//        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
//        
//        var strDate = dateFormatter.stringFromDate(datePicker.date)
//        dateLabel.text = strDate
//    }
}

// MARK: Tab Bar Delegate

extension EntriesViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is EntriesViewController) {
            println("Take Photo")
            return false
        } else {
            return true
        }
    }
    
}


