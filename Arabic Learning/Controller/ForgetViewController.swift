//
//  ForgetViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Raza on 12/2/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ForgetViewController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    @IBAction func forgetButton(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email.text! ) { (Error) in
            if Error != nil {
                ProgressHUD.showError("Error! Try again")
            }else{
                ProgressHUD.showSuccess("Email Sent")
            }
        }
    }
    
}
