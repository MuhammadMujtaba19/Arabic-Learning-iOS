//
//  video.swift
//  temp
//
//  Created by Muhammad Raza on 10/27/19.
//  Copyright © 2019 SH Tech. All rights reserved.
//

import Foundation

class Video{
    var name:String!
    var imageURL:String!
    var videoID:String!
    var videoNumber:Int!
    var description:String!
    
    init(nameOfVideo: String , imageURL: String,V_ID:String,V_Number:Int,descOfVideo:String) {
        name = nameOfVideo
        self.imageURL = imageURL
        videoID = V_ID
        videoNumber = V_Number
        description  = descOfVideo
    }
    
    
}
