//
//  VideoListController.swift
//  temp
//
//  Created by Muhammad Raza on 10/26/19.
//  Copyright © 2019 SH Tech. All rights reserved.
//

import UIKit
import Kingfisher

class VideoListController: UITableViewController {
    
    var data=VideoBank()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        
        self.navigationItem.title = "Video Lectures"
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! videoCell

        cell.name.text = data.list[indexPath.row].name
        let url = URL(string: data.list[indexPath.row].imageURL)
        cell.img.kf.setImage(with: url)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "videoListToPlayer", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoListToPlayer"{
            let ss = segue.destination as! ViewController
            let index = tableView.indexPathForSelectedRow?.row
            ss.videoID = data.list[index!].videoID
            
        }

    }
}
