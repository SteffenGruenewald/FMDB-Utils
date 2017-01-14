//
//  MyfriendsTableViewCell.swift
//  OUT
//
//  Created by MidnightSun on 1/13/17.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class MyfriendsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imvMyfriends: UIImageView!

    @IBOutlet weak var lblMyfriendsUserName: UILabel!
    
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
