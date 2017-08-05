//
//  CategoriesViewController.swift
//  ZhongWenKaraoke
//
//  Created by Yannick Chiasson on 7/31/17.
//  Copyright © 2017 Yannick Chiasson. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var categoriesView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesView.delegate = self
        categoriesView.dataSource = self

        categoriesView.register(UINib(nibName:"CategorySectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategorySectionTitle")
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        categoriesView.collectionViewLayout = CategoryLayout()
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
    }
}

class CategoryLayout: UICollectionViewFlowLayout {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itemSize = CGSize(width: screenWidth/5, height: screenHeight/4)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
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
        // #warning Incomplete implementation, return the number of sections
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
            
            sectionHeader.chinese?.text = parentCategory.chinese
            sectionHeader.english?.text = parentCategory.english
            return sectionHeader
        default:
            assert(false, "Section Header of kind: \(kind) not implemented")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MiguCategoryCell", for: indexPath) as! MiguCategoryCell
        
        // Configure the cell
        let category = MiguSongStore.categories[indexPath.section].categories[indexPath.row]
        cell.english.text = category.english
        cell.chinese.text = category.chinese
        
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
