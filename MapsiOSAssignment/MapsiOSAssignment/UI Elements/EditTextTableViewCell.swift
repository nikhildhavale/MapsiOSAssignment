//
//  EditTextTableViewCell.swift
//  MapsiOSAssignment
//
//  Created by Nikhil Vivek Dhavale on 27/05/19.
//  Copyright © 2019 Nikhil Vivek Dhavale. All rights reserved.
//

import UIKit

class EditTextTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
