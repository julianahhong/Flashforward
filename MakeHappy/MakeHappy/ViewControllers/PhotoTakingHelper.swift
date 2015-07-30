//
//  PhotoTakingHelper.swift
//  MakeHappy
//
//  Created by Juliana Hong on 7/30/15.
//  Copyright (c) 2015 Juliana Hong. All rights reserved.
//

import UIKit

typealias PhotoTakingHelperCallback = UIImage? -> Void

class PhotoTakingHelper : NSObject {
    
    /** View controller on which AlertViewController and UIImagePickerController are presented */
    weak var viewController: UIViewController!
    var callback: PhotoTakingHelperCallback
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: PhotoTakingHelperCallback) {
        self.viewController = viewController
        self.callback = callback
        
        super.init()
        
        showPhotoSourceSelection()
    }
    
    func showPhotoSourceSelection() {
        
    }
    
}
