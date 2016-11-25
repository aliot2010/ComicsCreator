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
    var modeFlag = 0
    var selectedIndex = -1
    
    

    
    @IBAction func switchMode(_ sender: UISegmentedControl) {
        if (modeFlag==0){
                        modeFlag = 1
                        
                    } else {
                        modeFlag = 0
                        let cell = collectionView?.cellForItem(at: IndexPath(item: selectedIndex, section: 0))
                        cell?.backgroundColor = UIColor.clear
                        selectedIndex = -1
                    }
        
    }
    
    
    @IBAction func editPageClicked(_ sender: UIBarButtonItem) {
        if (modeFlag == 1){
            let cell = collectionView?.cellForItem(at: IndexPath(item: selectedIndex, section: 0))
            cell?.backgroundColor = UIColor.clear
            self.performSegue(withIdentifier: "pagesToPadeditor", sender: selectedIndex)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
      
        self.navigationController?.navigationBar.tintColor = UIColor.black
            }
    
    @IBAction func addPge(_ sender: UIBarButtonItem) {
//        let page = Page()
//        try! Storage.common.realm.write {
//            Storage.common.comicsList[index].pages.append(page)
//        }
//        self.collectionView?.reloadData()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Storage.common.comicsList[index].pages.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.image.image = Tools.comixPatternsImages[Storage.common.comicsList[index].pages[indexPath.row].pattern]
        //говно?
        cell.label.text = String(indexPath.row + 1)
        return cell
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        if(modeFlag == 1){
            selectedIndex = indexPath.row
            let cell = collectionView.cellForItem(at: indexPath)
        
            cell?.backgroundColor = UIColor.orange
        } else {
            openPageInReadMode(byIndex: indexPath.row)
        }
        
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
        super.prepare(for: segue, sender:sender)
        if segue.identifier == "pagesToPadeditor"{
            guard let pageVC = segue.destination as? EditModeViewController else {return}
                    pageVC.pageIndex = sender as! Int
                    pageVC.comicsIndex = self.index
        } else if segue.identifier == "PagesToAddCover"{
            guard let pageVC = segue.destination as? AddCoverCollectionViewController else {return}
            
            pageVC.comicsIndex = self.index
            
        }
        
    }
    
    
    func openPageInReadMode(byIndex:Int){
        self.performSegue(withIdentifier: "pagesToPagereader", sender: selectedIndex)

    }
    

}
