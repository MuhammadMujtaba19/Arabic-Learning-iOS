//
//  Catogery.swift
//  Arabic Learning
//
//  Created by Muhammad Mujtaba on 10/17/19.
//  Copyright © 2019 Muhammad Mujtaba. All rights reserved.
//

import Foundation
import RealmSwift

class Category :Object{
    @objc dynamic var title:String = ""
    let sentences = List<Sentence>()  //Forward Relationship
}
