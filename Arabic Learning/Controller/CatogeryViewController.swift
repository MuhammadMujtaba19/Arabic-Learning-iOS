//
//  CatogeryViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/16/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import RealmSwift

import UIKit
import Firebase
import SVProgressHUD
class CatogeryViewController: UITableViewController {
    let realm = try! Realm()
    var UIEnglish:Bool!
//    var catogeryArray :Results<Category>?
    var catogeryArray : [String] = [String]()
    var idArray : [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomCatogeryCell", bundle: nil), forCellReuseIdentifier: "CustomCatogeryCell")
        tableView.separatorStyle = .none
        tableView.rowHeight=55
        loadCatogery()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCatogeryCell" ,for: indexPath)
        as! CustomCatogeryCell
        cell.CatogeryIcon?.image = UIImage(named: "cat_\(indexPath.row+1)")
    cell.CatogeryLabel?.text = catogeryArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catogeryArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSentences", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SentViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCatogery = idArray[indexPath.row]
        }
    }
    
    func loadCatogery() {
        SVProgressHUD.show()
        let databaseReference = Database.database().reference().child("/catogery")
        UIEnglish = UserDefaults.standard.bool(forKey: "UIEnglish")
        
        if(UIEnglish == true){
            databaseReference.observe(.childAdded) { (DataSnapshot) in
                let snap = DataSnapshot.value as! Dictionary<String,String>
                let text = snap["name"]!
                let id = snap["id"]!
                print(text)
//
                self.catogeryArray.append(text)
                self.idArray.append(id)
            self.tableView.reloadData()
            }
        }else{
            
            databaseReference.observe(.childAdded) { (DataSnapshot) in
                let snap = DataSnapshot.value as! Dictionary<String,String>
                let text = snap["arabic"]!
                let id = snap["id"]!
                print(text)
                //
                self.catogeryArray.append(text)
                self.idArray.append(id)
                self.tableView.reloadData()
            }
        }
        
        SVProgressHUD.dismiss()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIEnglish = UserDefaults.standard.bool(forKey: "UIEnglish")
        if(UIEnglish == true){
            UserDefaults.standard.set(false, forKey:"UIEnglish")
            
        }else{
            UserDefaults.standard.set(true, forKey:"UIEnglish")
        }
        loadCatogery()
    }
}
