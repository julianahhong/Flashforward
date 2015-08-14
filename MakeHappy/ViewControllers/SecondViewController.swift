//
//  SecondViewController.swift
//  MakeHappy
//
//  Created by Juliana Hong on 8/7/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit
import Parse

class SecondViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    let formatter = NSDateFormatter()
    
    var currentDate = NSDate()
    let picker = UIImagePickerController()
    
    var selectedDate = NSDate()
    
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var chooseDateButton: UIButton!

    //var emailAddress: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = "Today is " + getCurrentDate()
        
        emailAddressTextField.font = UIFont(name: "Niconne", size: 20)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDate() -> String {
        //formats date to "Month, Day, Year"
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        var dateString = formatter.stringFromDate(currentDate)
        return dateString
    }

    @IBAction func unwindChooseDateVC(segue: UIStoryboardSegue) {
        if let svc = segue.sourceViewController as? ChooseDateVC {
            let formatter = NSDateFormatter()
            //formats date to "Month, Day, Year"
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            //formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            
            var notificationDate = formatter.stringFromDate(svc.datePicker.date)
            self.chooseDateButton.setTitle(notificationDate, forState: .Normal)
            
            selectedDate = svc.datePicker.date
            
        }
        
    }

    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "segueToPhoto" {
            
            if emailAddressTextField.text == "" && chooseDateButton.titleLabel!.text! != "Choose Date" {
                
                let alertView = UIAlertController(title: "Oh no!", message: "Please enter email address", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
                
                return false
                
            }
                
            else if chooseDateButton.titleLabel!.text! == "Choose Date" && emailAddressTextField.text != "" {
                
                let alertView = UIAlertController(title: "Oh no!", message: "Please choose a notification date", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
                
                return false

            }
                
            else if emailAddressTextField.text == "" && chooseDateButton.titleLabel!.text! == "Choose Date" {
                let alertView = UIAlertController(title: "Oh no!", message: "Please enter an email address and notification date", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
                
                return false

            }
                
                
            else {
                
                return true
            }
        }
        
        // by default, transition
        return true
    }
    
    @IBAction func unwindToSecondVC(segue:UIStoryboardSegue) {
        
    }
    
    //when touch outside text field, keyboard disappears
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        emailAddressTextField.endEditing(true)
        
    }

    func saveEmailAddress() -> String{
        var emailAddress = emailAddressTextField.text
        
        return emailAddress!

    }
    
    func saveDate() -> NSDate {
        var date = selectedDate
        return date
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToPhoto" {
        
            if let destinationVC = segue.destinationViewController as? PhotoViewController{
                destinationVC.emailPassed = saveEmailAddress()
                destinationVC.datePassed = saveDate()
            }
        }
    }
    
    



}
