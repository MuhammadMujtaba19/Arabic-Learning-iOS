//
//  SentenceCell.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 11/6/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit

class SentenceCell: UITableViewCell {

    @IBOutlet weak var arabicSentence: UILabel!
    @IBOutlet weak var englishSentence: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func copybutton(_ sender: UIButton) {
        ProgressHUD.showSuccess("Copied to Clipboard")
        UIPasteboard.general.string = arabicSentence.text
    }
    
    
}
