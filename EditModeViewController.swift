//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController {

    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = DualImagePageView()
        view.initSubviews(nibName: "DualImagePageView")
        
        view.frame = editPlace.bounds
        
        editPlace.addSubview(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
