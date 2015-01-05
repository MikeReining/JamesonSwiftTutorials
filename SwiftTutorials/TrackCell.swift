//
//  TrackCell.swift
//  SwiftTutorials
//
//  Created by Michael Reining on 1/5/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    @IBOutlet weak var playIcon : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
