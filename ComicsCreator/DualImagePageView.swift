//
//  DualImagePageView.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class DualImagePageView: UIView {

    @IBOutlet var contentView: UIView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
       // initSubviews()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
       // initSubviews()
    }
    
    
    func initSubviews(nibName:String) {

        let nib = UINib(nibName: "DualImagePageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
  
    

}
