//
//  PostCommentTableViewCell.swift
//  Timeline
//
//  Created by Diego Aguirre on 2/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostCommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithComment(comment: Comment) {
        
        let user = UserController.sharedController.currentUser
        
        usernameLabel.text = "\(user.username)"
        commentLabel.text = "\(comment.text)"
    }

}
