//
//  videoCell.swift
//  temp
//
//  Created by Muhammad Raza on 10/27/19.
//  Copyright © 2019 SH Tech. All rights reserved.
//

import UIKit

class videoCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var img: UIImageView!
 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
