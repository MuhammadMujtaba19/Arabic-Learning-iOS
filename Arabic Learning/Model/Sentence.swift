//
//  Sentence.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/17/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//
import RealmSwift
import Foundation

class Sentence: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var isFavourite : Bool = false
    @objc dynamic var audioFile : String = ""
    @objc dynamic var EnglishTranslation : String = ""
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "sentences")
    
    
}
