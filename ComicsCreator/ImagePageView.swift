//
//  DualImagePageView.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class ImagePageView: UIView {

    var numberOfImage = 0
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    
    
    
    
    var imageViewList = [UIImageView]()
    var currentImageViewList = [UIImageView]()
    let namesOfNib: [String: Int] = ["DualImagePageView":2, "SingleImagePageView":1, "DualImagePageView1":2 ]
    
    func getImage(fromImageView byIndex:Int)->UIImage?{
        if (byIndex <= numberOfImage){
            return currentImageViewList[byIndex].image
        }else{ return nil}
    }
    
    func setImage(toImageView image:UIImage, toIndex:Int){
        if (toIndex <= numberOfImage){
            currentImageViewList[toIndex].image = image
        }
    }
    
    
    
    
  required init(coder aDecoder: NSCoder) {
   
       
     
     super.init(coder: aDecoder)!
       // initSubviews()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
       // initSubviews()
    }
    
    
    func initSubviews(nibName:String) {
       
        let nib = UINib(nibName: nibName, bundle: nil)
      
        
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        createImageViewList()
        setNumberOfImageView(nibName: nibName)
    }
    
    private func createImageViewList(){
        imageViewList.append(imageView1)
        if (imageView2 != nil){
            imageViewList.append(imageView2)
        }
    }
    
    private func setNumberOfImageView(nibName:String){
        numberOfImage = Int(namesOfNib[nibName]!)
        for i in 0 ..< Int(namesOfNib[nibName]!){
            currentImageViewList.append(imageViewList[i])
            imageViewList[i].contentMode = UIViewContentMode.scaleAspectFill
        }
    }
    

}
