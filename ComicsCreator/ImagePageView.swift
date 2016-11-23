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
    var comicsIndex:Int = -1
    var pageIndex:Int = -1
    
    
    
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
    
    
    func initSubviews(nibName:String, comicsIndex:Int, pageIndex:Int) {
        self.comicsIndex = comicsIndex
        self.pageIndex = pageIndex
        
        
        
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
    
    
    @IBAction func panGestRecognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        if let view = sender.view {
            
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: sender.view)
    }
    
    @IBAction func pinchRecognizer(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1
        }
    }
    
    @IBAction func rotationRecognizer(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }

    

}
