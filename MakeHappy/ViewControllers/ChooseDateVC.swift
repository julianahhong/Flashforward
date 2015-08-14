//
//  ChooseDateVC.swift
//  MakeHappy
//
//  Created by Juliana Hong on 7/23/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit

class ChooseDateVC: UIViewController {
    
    @IBOutlet var backButton: UIButton!

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var oneWeekButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        restrictTimeRange()
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        //dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func restrictTimeRange() {
        let minDate = NSDate()
        datePicker.minimumDate = minDate
    }

}

