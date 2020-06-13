//
//  SentenceViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/17/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Firebase
import AVFoundation

class SentViewController: UITableViewController,AVAudioPlayerDelegate {
    var audioPlayer : AVAudioPlayer!
    
    var sentenceArray :[Sentence]=[Sentence]()
    var selectedCatogery :String=""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SentenceCell", bundle: nil), forCellReuseIdentifier: "sentenceCell")
        tableView.separatorStyle = .none
        tableView.rowHeight=105
        loadItems()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playSound(index: sentenceArray[indexPath.row].audioFile)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sentenceCell" ,for: indexPath) as! SentenceCell
        cell.arabicSentence?.text = sentenceArray[indexPath.row].title
        cell.englishSentence?.text = sentenceArray[indexPath.row].EnglishTranslation
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        
        tap.numberOfTapsRequired = 2
        cell.addGestureRecognizer(tap)
        
        return cell
    }
    func loadItems(){
        let databaseReference = Database.database().reference().child("/Sentences").child("\(selectedCatogery)")
        print("\(selectedCatogery)")
        databaseReference.observe(.childAdded) { (DataSnapshot) in
            let snap = DataSnapshot.value as! Dictionary<String,String>
            let arabicSentence = snap["arabicSentence"]
            let englishSentence = snap["englishSentence"]
            let audioFile = snap["audioFile"]
            
            let sentence = Sentence()
            sentence.title = arabicSentence!
            sentence.EnglishTranslation = englishSentence!
            sentence.audioFile = audioFile!
            
            self.sentenceArray.append(sentence)
            
            self.tableView.reloadData()
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
        audioPlayer.delegate = self
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        tableView.deselectRow(at: tableView!.indexPathForSelectedRow!, animated: true)
    }
    
    @objc func doubleTapped(){
        
        ProgressHUD.showSuccess("Copied to Clipboard")
//        UIPasteboard.general.string = sentenceArray[index].title
    }
}
