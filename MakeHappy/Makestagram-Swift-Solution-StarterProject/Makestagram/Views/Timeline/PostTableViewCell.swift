//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Juliana Hong on 7/12/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {

    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var likesIconImageView: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    var likeBond: Bond<[PFUser]?>!
    
    @IBAction func moreButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func likeButtonTapped(sender: AnyObject) {
        post?.toggleLikePost(PFUser.currentUser()!)
    }
    var post:Post? {
        didSet {
            if let post = post {
                // bind the image of the post to the 'postImage' view
                post.image ->> postImageView
                
                // bind the likeBond that we defined earlier, to update like label and button when likes change
                post.likes ->> likeBond
            }
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 1
        likeBond = Bond<[PFUser]?>() { [unowned self] likeList in
            // 2
            if let likeList = likeList {
                // 3
                self.likesLabel.text = self.stringFromUserList(likeList)
                // 4
                self.likeButton.selected = contains(likeList, PFUser.currentUser()!)
                // 5
                self.likesIconImageView.hidden = (likeList.count == 0)
            } else {
                // 6
                // if there is no list of users that like this post, reset everything
                self.likesLabel.text = ""
                self.likeButton.selected = false
                self.likesIconImageView.hidden = true
            }
        }
    }
    
    // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
    func stringFromUserList(userList: [PFUser]) -> String {
        // 1
        let usernameList = userList.map { user in user.username! }
        // 2
        let commaSeparatedUserList = ", ".join(usernameList)
        
        return commaSeparatedUserList
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
