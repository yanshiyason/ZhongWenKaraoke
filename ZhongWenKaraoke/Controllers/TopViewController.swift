//
//  TopViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/21/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var songsTable: UITableView!
    var topViewDataService: TopViewDataService!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topViewDataService = TopViewDataService()
        self.songsTable.delegate = topViewDataService
        self.songsTable.dataSource = topViewDataService
        NotificationCenter.default.addObserver(self, selector: #selector(loadSongs), name: NSNotification.Name(rawValue: "songsArrived"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSongs(notification: NSNotification){
        //load data here
        self.songsTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToSongView" {
            if let row = songsTable.indexPathForSelectedRow?.row {
                let dataService = songsTable.dataSource as! TopViewDataService
                if let song = dataService.miguSongStore.songs?[row] {
                    let songVC = segue.destination as! MiguSongViewController
                    songVC.song = song
                }
            }
        }
    }

}

