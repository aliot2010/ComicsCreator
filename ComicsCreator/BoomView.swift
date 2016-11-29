//
//  BoomView.swift
//  ComicsCreator
//
//  Created by alex L on 26.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit


class BoomView: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet var contentView: UIView!
    
required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
     //initSubviews()
    }
override init(frame: CGRect) {
    super.init(frame: frame)
    // initSubviews()
}


func initSubviews(nibName:String) {
    
    let nib = UINib(nibName: nibName, bundle: nil)
    
    nib.instantiate(withOwner: self, options: nil)
    contentView.frame = bounds
    
    self.addSubview(contentView)
    
}
  
    
    
  
    
  
    
}
