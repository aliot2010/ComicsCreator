//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController {

    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInEditPlace = ImagePageView() as ImagePageView
        (viewInEditPlace)?.initSubviews(nibName: "DualImagePageView1")
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        
        viewInEditPlace?.setImage(toImageView: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200")!, toIndex: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
