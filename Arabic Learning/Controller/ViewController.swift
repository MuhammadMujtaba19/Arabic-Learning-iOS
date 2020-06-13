//
//  ViewController.swift
//
//  Created by Muhammad Raza on 10/22/19.
//  Copyright © 2019 SH Tech. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class ViewController: UIViewController {

    @IBOutlet weak var videoView: YouTubePlayerView!
    var videoID:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.playerVars = [
        "playsinline": "1",
        "controls": "1",
        "showinfo": "1"
        ] as YouTubePlayerView.YouTubePlayerParameters
        
        videoView.loadVideoID(videoID)
        videoView.play()
        
        // Do any additional setup after loading the view.
    }


}

