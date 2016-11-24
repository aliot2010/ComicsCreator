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
        (viewInEditPlace)?.initSubviews(nibName:Tools.comicsPatternsById[Storage.common.comicsList[comicsIndex].pages[pageIndex].pattern] , comicsIndex: comicsIndex, pageIndex: pageIndex)//
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
