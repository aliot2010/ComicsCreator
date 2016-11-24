//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController {
    @IBOutlet weak var textpageIndex: UILabel!
    
    @IBOutlet weak var testcomixind: UILabel!
    var pageIndex = 1
    var comicsIndex = 1
    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInEditPlace = ImagePageView() as ImagePageView
        (viewInEditPlace)?.initSubviews(nibName: "DualImagePageView", comicsIndex: comicsIndex, pageIndex: pageIndex)//
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        
        viewInEditPlace?.setImage(toImageView: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200")!, toIndex: 0)
        
        viewInEditPlace?.imageView2.center = CGPoint(x:  200, y: 100)
        
        textpageIndex.text = String(pageIndex)
        testcomixind.text = String(comicsIndex)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
