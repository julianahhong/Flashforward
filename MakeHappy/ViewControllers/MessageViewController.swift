//
//  MessageViewController.swift
//  MakeHappy
//
//  Created by Juliana Hong on 8/7/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit
import Parse

class MessageViewController: UIViewController, UITextViewDelegate {
    var emailPassed2: String?
    var datePassed2: NSDate?
    var imagePassed: NSData?
    let formatter = NSDateFormatter()
    var currentDate = NSDate()
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageTextView: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTextView.delegate = self
        messageTextView.text = "Write a message to the future."
        messageTextView.textColor = UIColor.lightGrayColor()
        
        messageTextView.becomeFirstResponder()
        
        messageTextView.selectedTextRange = messageTextView.textRangeFromPosition(messageTextView.beginningOfDocument, toPosition: messageTextView.beginningOfDocument)
        
        println(emailPassed2)
        println(datePassed2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if count(updatedText) == 0 {
            
            textView.text = "Write a message to the future."
            textView.textColor = UIColor.lightGrayColor()
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && count(text) > 0 {
            textView.text = nil
            textView.textColor = UIColor.whiteColor()
        }
        
        return true
    }
    
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }
    
    func getCurrentDate() -> String {
        //formats date to "Month, Day, Year"
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        var dateString = formatter.stringFromDate(currentDate)
        return dateString
    }
    
    
    
    func saveEntryToParse() {
        
        let entry = PFObject(className: "Entry")

        
        var imageFile = PFFile(data: imagePassed!)
        imageFile.saveInBackground()
            
            
        entry["Image"] = imageFile
            

        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")
        
        var notificationDate = formatter.stringFromDate(datePassed2!)
        
        entry["Message"] = messageTextView.text
        entry["NotificationDate"] = notificationDate
        entry["createdDate"] = getCurrentDate()
        entry["Email"] = emailPassed2

        
        entry.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("Entry has been saved.")
            
        }

    }
    
    @IBAction func sendButton(sender: AnyObject) {
        if messageTextView.text == "Write a message to the future." {
            
            let alertView = UIAlertController(title: "Oh no!", message: "Please write a message", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "Got it", style: .Default, handler: nil))
            presentViewController(alertView, animated: true, completion: nil)
            
        }
        else {
            saveEntryToParse()
            messageTextView.text = ""

        }
  
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        messageTextView.endEditing(true)
    }

    @IBAction func homeButtonPressed(sender: AnyObject) {
        //go back to start screen
        var StartVC = self.storyboard?.instantiateViewControllerWithIdentifier("StartVC") as! StartViewController
        self.presentViewController(StartVC, animated: true, completion: nil)
    }


}
