//
//  DualImagePageView.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift
class ImagePageView: UIView {

    var numberOfImage = 0
    @IBOutlet var contentView: UIView!
    
    var selectedIndex = 0
    
    
    @IBOutlet weak var eeditView1: UIView!
    @IBOutlet weak var editView2: UIView!
    
    
    
    
    
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    var comicsIndex:Int = -1
    var pageIndex:Int = -1
    
    
    var editViewList = [UIView]()
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
    
    func updateImages(){//
        for i in 0..<numberOfImage{
        
            let img =  Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].imagePath
            currentImageViewList[i].image = Storage.common.loadImage(imageName: img)//
            
            let x = Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].imageX
            let y = Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].imageY

            
            currentImageViewList[i].transform = (currentImageViewList[i] as UIView).transform.rotated(by: CGFloat(Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].rotation))
                print(Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].rotation)
            
            if (x > -1000.0 && y > -1000.0){
                currentImageViewList[i].center = CGPoint(x:x, y:y)
            }
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
        updateImages()
    }
    
    func  getSelectedViewIndex()->Int{
        return selectedIndex
    }
    
    private func createImageViewList(){
        imageViewList.append(imageView1)
        editViewList.append(eeditView1)
        eeditView1.backgroundColor = UIColor.orange
        if (imageView2 != nil){
            imageViewList.append(imageView2)
            editViewList.append(editView2)
        }
    }
    
    private func setNumberOfImageView(nibName:String){
        numberOfImage = Int(namesOfNib[nibName]!)
        for i in 0 ..< Int(namesOfNib[nibName]!){
            currentImageViewList.append(imageViewList[i])
            imageViewList[i].contentMode = UIViewContentMode.scaleAspectFill
            //print(imageViewList[i].center.x)
             //print(imageViewList[i].center.y)
            //imageViewList[i].center = CGPoint(x:-1000, y:-1000)//
        }
    }
    
    
    @IBAction func tapRecognizer(_ sender: UITapGestureRecognizer) {
        for i in 0..<numberOfImage{
           
            
            if(sender.view?.isEqual(editViewList[i]))!{
                editViewList[selectedIndex].backgroundColor = UIColor.black
                editViewList[i].backgroundColor = UIColor.orange
                selectedIndex = i
                break
            }
        }
        //editViewList[1].backgroundColor = UIColor.blue
    }
    
    
    
    
    @IBAction func panGestRecognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: sender.view)
        if let view = sender.view {
           
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            for i in 0..<numberOfImage{
                if(currentImageViewList[i].isEqual(view)){
                    try! Storage.common.realm.write {
                        Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].imageX = Double(view.center.x) + Double(translation.x)
                        Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].imageY = Double(view.center.y) + Double(translation.y)
                    }
                    break
                }
            }
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
            
            for i in 0..<numberOfImage{
                if(currentImageViewList[i].isEqual(sender.view)){
                    try! Storage.common.realm.write {
                        Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].rotation = Double(Storage.common.comicsList[comicsIndex].pages[pageIndex].images[i].rotation + Double(sender.rotation))
                    }
                    break
                }
            }
           
            sender.rotation = 0
        }
        
    }

    

}
