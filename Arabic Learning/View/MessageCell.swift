//
//  MessageCell.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/22/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var Background: UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
