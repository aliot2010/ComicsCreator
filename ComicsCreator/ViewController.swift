//
//  ViewController.swift
//  ComicsCreator
//
//  Created by alex L on 17.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    public let documentsDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    var selectedIndex = -1
    var editMode = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefoultPhoto()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)
       
      
    }
    
    
    @IBAction func editModeClicked(_ sender: UIBarButtonItem) {
        if (editMode==0){
            editMode = 1
            
        } else {
            editMode = 0
        }
    }
    
    

    
  
   
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView?.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  Storage.common.comicsList.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.label.text = Storage.common.comicsList[indexPath.row].title
        cell.image.contentMode = UIViewContentMode.scaleAspectFill
        cell.image.image = Storage.common.loadImage(imageName: Storage.common.comicsList[indexPath.row].cover)
       

        //cell.image.image = Storage.common.loadImage(imageName: "defoultPhoto")
        return cell
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender:sender)
        guard segue.identifier == "mainToItem" else {return}
        guard let pageVC = segue.destination as? PagesCollectionViewController else {
            return
        }
        pageVC.index = sender as! Int
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(selectedIndex != -1){
            collectionView.cellForItem(at: IndexPath(row: selectedIndex, section: 0 ))?.backgroundColor = UIColor.clear
        }
        if (editMode == 1){
            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.orange
            selectedIndex = indexPath.row
        } else {
            
            self.performSegue(withIdentifier: "mainToItem", sender:indexPath.row)
        }
    }
    
    func setDefoultPhoto(){
        let photoURL = NSURL(fileURLWithPath: documentsDirPath).appendingPathComponent("defoultPhoto")
        let data = UIImagePNGRepresentation(UIImage(named: "defoultPhoto")!)
        try! data?.write(to: photoURL!, options: Data.WritingOptions.atomic)
    }
    
    
   
    @IBAction func deleteComics(_ sender: UIBarButtonItem) {
        if(selectedIndex != -1){
        Storage.common.deleteComix(comix: Storage.common.comicsList[selectedIndex])
         self.collectionView?.reloadData()
        self.collectionView?.refreshControl
        }
    }
    
   
   

}

