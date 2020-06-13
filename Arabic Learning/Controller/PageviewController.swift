//
//  PageviewController.swift
//  Arabic Learning
//
//  Created by Muhammad Raza on 11/27/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit


class PageViewController: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labeltext: UILabel!
    
    @IBOutlet weak var progressBar: UIView!
    
    var count = 0
    var imagearray = ["card1","card2","card3","card4"]
    var textarray = ["Use our Translation feature to translate from eng-to-arabic and from arabic-to-eng, and get a chance to query your understandings of language",
                    "Get access to rich database full of category based filtered arabic pharses/dialoges, also listen pronounciations of sentences",
                    "Learn Arabic through our interactive lecture sessions under supervision of our qaulified teachers !!!",
                    "Chat with other users to practice arabic language and help us build a better community"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidDisappear(_ animated: Bool) {
            navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
             navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func nextbutton(_ sender: UIButton) {
        count = count+1
        if (count >= 4){
            self.navigationController?.popViewController(animated: true)
        }else{
            imageView.image = UIImage (named: imagearray[count])
            labeltext.text = textarray[count]
                      progressBar.frame.size.width = (view.frame.size.width/4) * CGFloat (count+1)
        }
        
    }
    
    
    @IBAction func previousButton(_ sender: Any) {
        print("****1")
        count=count-1
        if (count < 0){
            count=0
            
        }
        else{
            imageView.image = UIImage (named: imagearray[count])
            labeltext.text = textarray[count]
                      progressBar.frame.size.width = (view.frame.size.width/4) * CGFloat (count+1)
        }
    }
}



