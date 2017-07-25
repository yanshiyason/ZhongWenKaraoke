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
        songsTable.delegate = topViewDataService
        songsTable.dataSource = topViewDataService
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
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
    
    func songForRow() -> MiguSong? {
        if let row = songsTable.indexPathForSelectedRow?.row {
            let dataService = songsTable.dataSource as! TopViewDataService
            return dataService.miguSongStore.songs?[row]
        } else {
            return nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToSongView" {
            if let song = songForRow() {
                let tabBarVC = segue.destination as! MiguSongTabBarController
                tabBarVC.song = song
            }
        }
    }

}

