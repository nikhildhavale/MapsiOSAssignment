//
//  SwitchTableViewCell.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 27/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var uiSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
