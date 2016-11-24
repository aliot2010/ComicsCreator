//
//  EditCollectionViewController.swift
//  ComicsCreator
//
//  Created by alex L on 24.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AddCoverCollectionViewController: UICollectionViewController {
    var pageIndex = 1
    var comicsIndex = 1
    var comixPatternsImages = [UIImage(named: "single"), UIImage(named: "dual"), UIImage(named: "dual1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  Storage.common.comicsList.count
        return comixPatternsImages.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        cell.image.contentMode = UIViewContentMode.scaleAspectFill
        
        cell.image.image = comixPatternsImages[indexPath.row]
        return cell
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender:sender)
        guard segue.identifier == "addCoverToPagesColection" else {return}
        guard let pageVC = segue.destination as? PagesCollectionViewController else {
            return
        }
        pageVC.index = sender as! Int
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let page = Page()
                page.pattern = indexPath.row
                try! Storage.common.realm.write {
                    Storage.common.comicsList[comicsIndex].pages.append(page)
                }
        self.performSegue(withIdentifier: "addCoverToPagesColection", sender:comicsIndex)
    }
    

}