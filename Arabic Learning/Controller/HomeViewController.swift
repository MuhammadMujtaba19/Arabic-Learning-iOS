//
//  ViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/13/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    var UIEnglish :Bool!
    @IBOutlet weak var HomeCard: UIImageView!
    
    @IBOutlet weak var Card1: UIButton!
    @IBOutlet weak var Card2: UIButton!
    @IBOutlet weak var Card4: UIButton!
    @IBOutlet weak var Card3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.performSegue(withIdentifier: "ccc", sender: self)
        UIEnglish = UserDefaults.standard.bool(forKey: "UIEnglish")


    }
    override func viewDidDisappear(_ animated: Bool) {
       navigationController?.setNavigationBarHidden(false, animated: true)
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIEnglish = UserDefaults.standard.bool(forKey: "UIEnglish")
        if(UIEnglish == true){
            UserDefaults.standard.set(false, forKey:"UIEnglish")
            Card1.setImage(UIImage(named: "card1Arabic") as UIImage?, for: .normal)
            Card2.setImage(UIImage(named: "card2Arabic") as UIImage?, for: .normal)
            Card3.setImage(UIImage(named: "card3Arabic") as UIImage?, for: .normal)
            Card4.setImage(UIImage(named: "card4Arabic") as UIImage?, for: .normal)
            HomeCard.image=UIImage(named: "home_textArabic")

        }else{
            UserDefaults.standard.set(true, forKey:"UIEnglish")
            Card1.setImage(UIImage(named: "card1") as UIImage?, for: .normal)
            Card2.setImage(UIImage(named: "card2") as UIImage?, for: .normal)
            Card3.setImage(UIImage(named: "card3") as UIImage?, for: .normal)
            Card4.setImage(UIImage(named: "card4") as UIImage?, for: .normal)
            
            HomeCard.image=UIImage(named: "home_text")
            
        }
        
    }
    @IBAction func popsetting(_ sender: UIButton) {
        popover()
    }
    func popover(){
        let alert = UIAlertController(title: "Setting", message: "", preferredStyle: .actionSheet)
        
        let restartAction = UIAlertAction(title: "Logout" , style: .default , handler: { (UIAlertAction) in
            do {
                try Auth.auth().signOut()

                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let homeVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                appDelegate.window!.rootViewController = homeVC
                
            }catch{
            
            }

        })
        alert.addAction(restartAction)
        
        let restartAction1 = UIAlertAction(title: "Change Language" , style: .default , handler: { (UIAlertAction) in
            self.changeLang()
        })
        alert.addAction(restartAction1)
        
        present(alert, animated: true, completion: nil)
    }

    func changeLang(){
        UIEnglish = UserDefaults.standard.bool(forKey: "UIEnglish")
        if(UIEnglish == true){
            UserDefaults.standard.set(false, forKey:"UIEnglish")
            Card1.setImage(UIImage(named: "card1Arabic") as UIImage?, for: .normal)
            Card2.setImage(UIImage(named: "card2Arabic") as UIImage?, for: .normal)
            Card3.setImage(UIImage(named: "card3Arabic") as UIImage?, for: .normal)
            Card4.setImage(UIImage(named: "card4Arabic") as UIImage?, for: .normal)
            HomeCard.image=UIImage(named: "home_textArabic")

        }else{
            UserDefaults.standard.set(true, forKey:"UIEnglish")
            Card1.setImage(UIImage(named: "card1") as UIImage?, for: .normal)
            Card2.setImage(UIImage(named: "card2") as UIImage?, for: .normal)
            Card3.setImage(UIImage(named: "card3") as UIImage?, for: .normal)
            Card4.setImage(UIImage(named: "card4") as UIImage?, for: .normal)
            
            HomeCard.image=UIImage(named: "home_text")
            
        }
        

    }
}

