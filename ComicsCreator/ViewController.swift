//
//  ViewController.swift
//  ComicsCreator
//
//  Created by alex L on 17.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        //cell.label.text = String(indexPath.row)
       // cell.imageViewInCell.image = UIImage(imageLiteralResourceName:"1366564980_919021232")
        return cell
        
        
    }


}

