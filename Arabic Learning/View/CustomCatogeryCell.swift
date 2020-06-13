//
//  CustomCatogeryCell.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/16/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class CustomCatogeryCell: UITableViewCell {

    @IBOutlet weak var CatogeryIcon: UIImageView!
    @IBOutlet weak var CatogeryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
