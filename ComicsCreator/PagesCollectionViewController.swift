//
//  PagesCollectionViewController.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PagesCollectionViewController: UICollectionViewController {
     public var index = 0
    
   
    @IBAction func addPge(_ sender: UIBarButtonItem) {
        let page = Page()
        try! Storage.common.realm.write {
            Storage.common.comicsList[index].pages.append(page)
        }
        self.collectionView?.reloadData()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func addPage(_ sender: UIBarButtonItem) {
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Storage.common.comicsList[index].pages.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = String(indexPath.row + 1)
        return cell
        
        
    }
    
   
    

}
