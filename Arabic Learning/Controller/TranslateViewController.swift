//
//  TranslateViewController.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 11/18/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD
class TranslateViewController:UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var FromLanguageLabel: UILabel!
    @IBOutlet weak var ToLanguageLabel: UILabel!
    
    @IBOutlet weak var InputTextView: UITextView!
    @IBOutlet weak var OutputTextView: UITextView!
    var translateFromEnglish = true
    override func viewDidLoad() {
        super.viewDidLoad()
        InputTextView.delegate = self
        InputTextView.text = "Enter Sentence in English........."
        InputTextView.textColor = UIColor.lightGray
     
        let tapGesture = UITapGestureRecognizer(target: self
            , action: #selector (selector_to_end_editing))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func selector_to_end_editing(){
        InputTextView.endEditing(true)
    }
    
    
    @IBAction func SwapLanguageButtonPressed(_ sender: Any) {
        
        if (translateFromEnglish == true){
            translateFromEnglish = false
            FromLanguageLabel.text = "Arabic"
            ToLanguageLabel.text = "English"
            InputTextView.textColor = UIColor.lightGray
            InputTextView.text = "......... اكتب جملة باللغة الإنجليزية "
        }
        else if(translateFromEnglish==false){
            translateFromEnglish = true
            FromLanguageLabel.text = "English"
            ToLanguageLabel.text = "Arabic"
            InputTextView.text = "Write a Sentence in English........."
            InputTextView.textColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func TranslateButtonPressed(_ sender: Any) {
        
        if (translateFromEnglish == true){
            let options = TranslatorOptions(sourceLanguage: .en, targetLanguage: .ar)
            let englishArabicTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
            let conditions = ModelDownloadConditions(
                allowsCellularAccess: false,
                allowsBackgroundDownloading: true
            )
            englishArabicTranslator.downloadModelIfNeeded(with: conditions) { error in
                guard error == nil else { return }
                englishArabicTranslator.translate(self.InputTextView!.text) { translatedText, error in
                    guard error == nil, let translatedText = translatedText
                        else { return }
                    print(translatedText)
                    self.OutputTextView.text = translatedText
                    // Translation succeeded.
                }
            }
            
            
        }else if(translateFromEnglish == false){
            let options = TranslatorOptions(sourceLanguage: .ar, targetLanguage: .en)
            let englishArabicTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
            let conditions = ModelDownloadConditions(
                allowsCellularAccess: false,
                allowsBackgroundDownloading: true
            )
            englishArabicTranslator.downloadModelIfNeeded(with: conditions) { error in
                guard error == nil else { return }
                englishArabicTranslator.translate(self.InputTextView!.text) { translatedText, error in
                    guard error == nil, let translatedText = translatedText
                        else { return }
                    print(translatedText)
                    self.OutputTextView.text = translatedText
                    // Translation succeeded.
                }
            }
            
            
        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if InputTextView.textColor == UIColor.lightGray {
            InputTextView.text = nil
            InputTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if InputTextView.text.isEmpty {
            if(translateFromEnglish==true){
            InputTextView.text = "Enter Sentence in English"
            }
            else{
                InputTextView.text = "......... اكتب جملة باللغة الإنجليزية "
            }
            InputTextView.textColor = UIColor.lightGray
        }
    }
}
