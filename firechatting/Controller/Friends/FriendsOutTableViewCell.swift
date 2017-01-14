//
//  FriendsOutTableViewCell.swift
//  OUT
//
//  Created by MidnightSun on 1/13/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class FriendsOutTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imvFriendOut: UIImageView!
    @IBOutlet weak var lblFriendsOutUserName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
