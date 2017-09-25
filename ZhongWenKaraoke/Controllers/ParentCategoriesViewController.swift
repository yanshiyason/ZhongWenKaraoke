//
//  ParentCategoriesViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 9/25/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class ParentCategoriesLayout: UICollectionViewFlowLayout {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init() {
        super.init()
        let padding = CGFloat(5)
        sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        minimumLineSpacing = padding
        minimumInteritemSpacing = padding
        let itemWidth = screenWidth - (padding * 2)
        let itemHeight = (screenHeight/5) - padding
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        //        headerReferenceSize = CGSize(width: screenWidth, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ParentCategoriesViewController: UIViewController {

    @IBOutlet weak var parentCategoriesView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Categories"
        setNowPlayingLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbarColor()
        setupLeftMenu()
        
        parentCategoriesView.delegate = self
        parentCategoriesView.dataSource = self
        
        parentCategoriesView.backgroundColor = .mainColor
        
        // without setting this to false, the collection view scrolling is choppy
        parentCategoriesView.isPrefetchingEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        parentCategoriesView.collectionViewLayout = ParentCategoriesLayout()
        parentCategoriesView.reloadData()
    }
    

    
//     MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToSubcategory" {
            let categoryVC = segue.destination as! CategoriesViewController
            if let category = categoryForSelectedItems() {
                categoryVC.category = category
            }
        }
        
        if segue.identifier == "ShowNowPlaying" {
            let vc = segue.destination as! MiguSongTabBarController
            let songDetailsVC = vc.childViewControllers[0] as! MiguSongDetailsViewController
            songDetailsVC.song = AppState.currentSong
        }
        
    }

}

extension ParentCategoriesViewController: UICollectionViewDelegate {
    
}

extension ParentCategoriesViewController: UICollectionViewDataSource {
    func categoryForSelectedItems() -> MiguParentCategory? {
        guard let indexPath = parentCategoriesView.indexPathsForSelectedItems?.first else { return nil }
        return MiguSongStore.categories[indexPath.row]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MiguSongStore.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiguCategoryCell", for: indexPath) as! MiguCategoryCell
        
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        // Configure the cell
        let category = MiguSongStore.categories[indexPath.row]
        cell.english.attributedText = UILabel.strokedText(category.english, font: .systemFont(ofSize: 12))
        cell.chinese.attributedText = UILabel.strokedText(category.chinese, font: .boldSystemFont(ofSize: 25))
        
        cell.cornerRadius = 10.0
        cell.addShadow()
        
        return cell
    }
}
