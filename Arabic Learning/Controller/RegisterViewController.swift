//
//  RegisterViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/13/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD

import UIKit

class RegisterViewController: UIViewController{
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        if(userName.text == ""){
            SVProgressHUD.dismiss()
            ProgressHUD.showError("Error: Fill Missing Field")
        }
        else if(userPassword.text == confirmpassword.text){
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) {
                
                (user, error) in
                if error != nil{
                    print("error")
                    SVProgressHUD.dismiss()
                    //ProgressHUD.showError("Error in Registration? Try with new id/password")
                    self.handleError(error!)
                    print("error")
                    
                }else{
                    print("Sucessful")
                    let userID = Auth.auth().currentUser!.uid
                    let databaseReference = Database.database().reference().child("/Users")
                    let newUser = ["name":self.userName.text!,"email":self.userEmail.text!,"ID":userID]
                    databaseReference.child(userID).setValue(newUser){
                        (error,reference) in
                        if error != nil {
                            SVProgressHUD.dismiss()
                            self.handleError(error!)
                        }else{
                            SVProgressHUD.dismiss()
                            print("Sent")
                        }
                    }

                    self.performSegue(withIdentifier: "goToHome", sender: self)
                }
            }

        }
        else{
            ProgressHUD.showError("Error : Password mismatch")
            SVProgressHUD.dismiss()
        }
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}


extension UIViewController{
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

            alert.addAction(okAction)

            self.present(alert, animated: true, completion: nil)

        }
    }
}
