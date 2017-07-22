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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

