//
//  StartPageViewController.swift
//  ComicsCreator
//
//  Created by alex L on 17.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionViewItems: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewItems.delegate = self
        collectionViewItems.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 5
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIndeficator = "startPageCell"
        let cell = collectionViewItems.dequeueReusableCell(withReuseIdentifier: cellIndeficator, for: indexPath) as! CollectionViewCell
        let label = cell.viewWithTag(1) as! UILabel
        label.text = "rrrrr"
        return cell
        
    }

}
