//
//  CategoriesViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/31/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit
import ChameleonFramework

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Categories"
        setNowPlayingLabel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbarColor()
        
        categoriesView.delegate = self
        categoriesView.dataSource = self

        categoriesView.register(UINib(nibName:"CategorySectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategorySectionTitle")
        
        categoriesView.backgroundColor = .mainColor
        
        // without setting this to false, the collection view scrolling is choppy
        categoriesView.isPrefetchingEnabled = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        categoriesView.collectionViewLayout = CategoriesLayout()
        categoriesView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToCategory" {
            let categoryVC = segue.destination as! CategoryViewController
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

class CategoriesLayout: UICollectionViewFlowLayout {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init() {
        super.init()
        let padding = CGFloat(5)
        sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        minimumLineSpacing = padding
        minimumInteritemSpacing = padding
        let itemWidth = (screenWidth/3) - (padding * 2)
        let itemHeight = (screenHeight/4) - padding
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        headerReferenceSize = CGSize(width: screenWidth, height: 50)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    // MARK: UICollectionViewDataSource
    
    func categoryForSelectedItems() -> MiguCategory? {
        if let indexPath = categoriesView.indexPathsForSelectedItems?.first {
            return MiguSongStore.categories[indexPath.section].categories[indexPath.row]
        } else {
            return nil
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MiguSongStore.categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MiguSongStore.categories[section].categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let parentCategory = MiguSongStore.categories[indexPath.section]
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategorySectionTitle", for: indexPath) as! CategorySectionHeader
            
            // Set background colors:
            sectionHeader.backgroundColor = .mainColor
            for view in sectionHeader.subviews {
                view.backgroundColor = .mainColor
            }
            
//            sectionHeader.chinese?.attributedText = UILabel.strokedText(parentCategory.chinese, strokeWidth: -3)
//            sectionHeader.english?.attributedText = UILabel.strokedText(parentCategory.english, strokeWidth: -3)
            sectionHeader.chinese?.attributedText = UILabel.coloredText(parentCategory.chinese, color: .flatMagenta, font: .boldSystemFont(ofSize: 21))
            sectionHeader.english?.attributedText = UILabel.coloredText(parentCategory.english, color: .flatSkyBlue, font: .boldSystemFont(ofSize: 16))
            return sectionHeader
        default:
            assert(false, "Section Header of kind: \(kind) not implemented")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiguCategoryCell", for: indexPath) as! MiguCategoryCell
        
        cell.backgroundColor = colors[indexPath.row % colors.count]
        
        // Configure the cell
        let category = MiguSongStore.categories[indexPath.section].categories[indexPath.row]
        cell.english.attributedText = UILabel.strokedText(category.english, font: .systemFont(ofSize: 12))
        cell.chinese.attributedText = UILabel.strokedText(category.chinese, font: .boldSystemFont(ofSize: 25))
        
        cell.cornerRadius = 10.0
        cell.addShadow()

        return cell
    }
    
    
}


extension CategoriesViewController: UICollectionViewDelegate {
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
