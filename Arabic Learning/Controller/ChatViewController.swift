//
//  ChatViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/22/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Firebase
import SVProgressHUD
import UIKit
import AVFoundation
import ChameleonFramework

class ChatViewController:UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    var messageArray : [Message] = [Message]()
    var url:String=""
    
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        messageTableView.separatorStyle = .none
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextField.delegate = self
        //TODO: Set the tapGesture here:

        let tapGesture = UITapGestureRecognizer(target: self
            , action: #selector (tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        

        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier:"customMessageCell")
        
        //messageTableView.estimatedRowHeight = UITableView.automaticDimension
        //messageTableView.rowHeight = UITableView.automaticDimension
        
        confirgureTableView()
        retrieveMessages()
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageText
        cell.senderName.text = messageArray[indexPath.row].sender
        
        if cell.senderName.text == Auth.auth().currentUser?.email{
            cell.Background.backgroundColor = UIColor(hexString: "#F0ECE7")
            cell.messageBody.textColor=UIColor(hexString: "#002436")
            cell.leftConstraint.constant = 104
            cell.rightConstraint.constant = 15
            
        }
        return cell
    }
    //TODO: Declare numberOfRowsInSection here:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped(){
        messageTextField.endEditing(true)
    }
    //TODO: Declare configureTableView here:
    func confirgureTableView(){
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    func retrieveMessages(){
        let databaseReference = Database.database().reference().child("/Messages").child("\(url)")
        databaseReference.observe(.childAdded) { (DataSnapshot) in
            let snap = DataSnapshot.value as! Dictionary<String,String>
            let text = snap["MessageBody"]!
            let sender = snap["Sender"]!
            
            self.playSound(index: "recieve")
            let message = Message()
            message.messageText = text
            message.sender = sender
            self.messageArray.append(message)
            self.confirgureTableView()
            self.messageTableView.reloadData()
        }
    }
    @IBAction func sendPressed(_ sender: Any) {
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
//        sendButton.isEnabled  = true
        let databaseReference = Database.database().reference().child("/Messages").child("\(url)")
        let messageDict = ["Sender":Auth.auth().currentUser?.email,"MessageBody":messageTextField.text!]
        databaseReference.childByAutoId().setValue(messageDict){
            (error,reference) in
            if error != nil {
                print("error")
            }else{
                self.playSound(index: "send")
                print("Sent")
                self.messageTextField.isEnabled = true
//                self.sendButton.isEnabled  = true
                self.messageTextField.text = ""
            }
        }
        
    }
    func playSound(index:String){
        let soundURL = Bundle.main.path(forResource: index, ofType: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundURL!))
        }catch {
            print("Error ha bhai ajeeb")
        }
        
        audioPlayer.play()
    }
}
