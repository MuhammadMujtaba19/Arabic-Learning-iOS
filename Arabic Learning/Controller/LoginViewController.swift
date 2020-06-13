//
//  LoginViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/13/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD


import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "goToHome", sender: self)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goToHome", sender: self)
        }
        let tapGesture = UITapGestureRecognizer(target: self
            , action: #selector (tableViewTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func tableViewTapped(){
        emailTextView.endEditing(true)
        passwordTextView.endEditing(true)
    }
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        let email = emailTextView.text!
        let password = passwordTextView.text!
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password)
        { (user,error) in
            if error != nil{
                print("Error present")
                SVProgressHUD.dismiss()
//                ProgressHUD.showError("Error! Wrong password or email")
                self.handleError(error!)
            }else{
                SVProgressHUD.dismiss()
                //self.performSegue(withIdentifier: "goToHome", sender: self)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let homeVC = storyboard.instantiateViewController(withIdentifier: "try1")
                appDelegate.window!.rootViewController = homeVC
                

            }
        }
                
    }
    
    @IBAction func forgetbutton(_ sender: Any) {
    
    }
    
    func forgetpass(){
        let alert = UIAlertController(title: "Forget Password", message: "Enter registered email to recive reset link", preferredStyle: .alert)
        
        var emailtextField:UITextField!
        alert.addTextField { (ff) in
            ff.text = "pskis"
        }
        let restartAction = UIAlertAction(title: "Submit" , style: .default , handler: { (UIAlertAction) in
            Auth.auth().sendPasswordReset(withEmail: "k163890@nu.edu.pk") { (Error) in
                if Error != nil {
                    ProgressHUD.showError("Error! Try again")
                }else{
                    ProgressHUD.showSuccess("Email Sent")
                }
            }
        })
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(restartAction)
        

        
        present(alert, animated: true, completion: nil)

    }
    

    
}

//extension AuthErrorCode {
//    var errorMessage: String {
//        switch self {
//        case .emailAlreadyInUse:
//            return "The email is already in use with another account"
//        case .userNotFound:
//            return "Account not found for the specified user. Please check and try again"
//        case .userDisabled:
//            return "Your account has been disabled. Please contact support."
//        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
//            return "Please enter a valid email"
//        case .networkError:
//            return "Network error. Please try again."
//        case .weakPassword:
//            return "Your password is too weak. The password must be 6 characters long or more."
//        case .wrongPassword:
//            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
//        default:
//            return "Unknown error occurred"
//        }
//    }
//}
//
//
//extension UIViewController{
//    func handleError(_ error: Error) {
//        if let errorCode = AuthErrorCode(rawValue: error._code) {
//            print(errorCode.errorMessage)
//            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
//
//            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//
//            alert.addAction(okAction)
//
//            self.present(alert, animated: true, completion: nil)
//
//        }
//    }
//}

