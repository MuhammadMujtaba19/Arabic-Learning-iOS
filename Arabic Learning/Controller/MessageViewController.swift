//
//  ViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/13/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class MessageViewController: UITableViewController {
    var UserArray : [Users] = [Users]()
    var currentUser = ""
    var stringBuilder = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        showUsers()
        checkIfUserIsLoggedIn()
        tableView.reloadData()
        print("Hello")
     }
    func showUsers(){
        let databaseReference = Database.database().reference().child("/Users")
        databaseReference.observe(.childAdded) { (DataSnapshot) in
            let snap = DataSnapshot.value as! Dictionary<String,String>
            let email = snap["email"]!
            let name = snap["name"]!
            let id = snap["id"]!
            
            let user = Users()
            user.email = email
            user.name = name
            user.id = id
            print(email)
            self.UserArray.append(user)
            
            
     self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell" ,for: indexPath)
        cell.textLabel?.text = UserArray[indexPath.row].name
        return cell
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
        }else{
            let uid = (Auth.auth().currentUser?.uid)!
            Database.database().reference().child("/Users").child(uid).observeSingleEvent(of: .value,with:{(snap)in

                if let dictionary = snap.value as? [String:AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                    print(dictionary["name"] ?? "None" )
                }

            })
        }
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SVProgressHUD.show()
        let userID = Auth.auth().currentUser!.uid
        
         stringBuilder = UserArray[indexPath.row].id
         stringBuilder =  userID+"(TXT)"+stringBuilder
        
        Database.database().reference().child("/Chatroom").queryOrdered(byChild: "users").queryEqual(toValue: stringBuilder).observeSingleEvent(of: .value, with: { snapshot in
            if (!snapshot.exists()){
                    self.stringBuilder = self.UserArray[indexPath.row].id
                    self.stringBuilder = self.stringBuilder+"(TXT)"+userID
                Database.database().reference().child("/Chatroom").queryOrdered(byChild: "users").queryEqual(toValue: self.stringBuilder).observeSingleEvent(of: .value, with: { snapshot in
                    if (!snapshot.exists()){
                        self.createNewChatRoom(ChatID: self.stringBuilder)
                    }else{
                            self.foo()
                    }
                })
            }else {
                self.foo()
            }
        })
        
        SVProgressHUD.dismiss()
        
    }
    func foo(){
        performSegue(withIdentifier: "goToMessage", sender:self )
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChatViewController
        if tableView.indexPathForSelectedRow != nil {
            destinationVC.url = stringBuilder
        }
    }
    func createNewChatRoom(ChatID:String)  {
        let databaseReference = Database.database().reference().child("/Chatroom")
        let newRoom = ["users":ChatID]
        databaseReference.childByAutoId().setValue(newRoom){
            (error,reference) in
            if error != nil {
                print("error")
            }else{
                print("Sent")
            }
        }
        foo()
        
        
    }
}
