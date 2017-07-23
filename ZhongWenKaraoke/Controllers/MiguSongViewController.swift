//
//  MiguSongViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/22/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class MiguSongViewController: UIViewController {
    var song: MiguSong!
    var miguSongDetails: MiguSongDetails!
    var miguSongLyrics: MiguSongLyrics!

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!

    @IBOutlet weak var lyricsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        lyricsTable.delegate = self
        lyricsTable.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSongDetails()
        getLyrics()
    }
    
    func getSongDetails() {
        MiguDataService().getSongDetails(song) { (miguSongDetails, error) in
            if let miguSongDetails = miguSongDetails {
                self.miguSongDetails = miguSongDetails
                self.posterImage.setImageFromURl(miguSongDetails.poster)
                self.songTitle.text? = miguSongDetails.songName.removingPercentEncoding!
                self.artistName.text? = miguSongDetails.singerName
            } else {
                print(error!)
            }
        }
    }
        
    func getLyrics() {
        MiguDataService().getLyrics(song) { miguSongLyrics, error in
            if let miguSongLyrics = miguSongLyrics {
                self.miguSongLyrics = miguSongLyrics
                self.lyricsTable.reloadData()
            }
        }
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
extension MiguSongViewController: UITableViewDelegate {
}

extension MiguSongViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if miguSongLyrics == nil {
            return UITableViewCell()
        } else {
            let cell = lyricsTable.dequeueReusableCell(withIdentifier: "LyricLineCell", for: indexPath)
            //        cell.textLabel?.text = miguSongLyrics.lyrics[indexPath.row]
            //        cell.textLabel?.text = "placeholder"
            cell.textLabel?.text = self.miguSongLyrics.lyrics[indexPath.row].text
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if miguSongLyrics == nil {
            return 1
        } else {
            return miguSongLyrics.lyrics.count
        }
    }
}
