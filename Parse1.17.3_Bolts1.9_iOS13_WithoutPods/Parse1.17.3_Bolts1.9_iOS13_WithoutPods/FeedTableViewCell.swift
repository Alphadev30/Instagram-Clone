//
//  FeedTableViewCell.swift
//  Parse1.17.3_Bolts1.9_iOS13_WithoutPods
//
//  Created by AlphaCoders on 13/11/20.
//  Copyright © 2020 Back4app. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePosted: UIImageView!
    
    @IBOutlet weak var caption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
