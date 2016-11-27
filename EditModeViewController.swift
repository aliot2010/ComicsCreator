//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var boomView: UIView!
    
    let boomImages = [UIImage(named: "bang"), UIImage(named: "boom-copy"), UIImage(named: "wow")]
    
    var boomViewList = [BoomView]()
    
    
    let imagePicker = UIImagePickerController()
 
    var pageIndex = 1
    var comicsIndex = 1
    
    var ind = 0
    
    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
    func updateBoomViews(){
        for i in 0..<Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.count{
            let testFrame : CGRect = CGRect(x: 30, y: 30, width: 70, height: 50)
            
            let caboomView = BoomView(frame: testFrame) as BoomView
            
            caboomView.initSubviews(nibName: "Boom")
            boomViewList.append(caboomView)
            
            
            caboomView.image.image = UIImage(named: Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].imageName)
            
            let x = Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].boomX
            let y = Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].boomY
                
            let scaleX = Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleX
            let scaleY = Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleY
            
            boomViewList[i].transform = (boomViewList[i] as UIView).transform.scaledBy(x: CGFloat(scaleX), y: CGFloat(scaleY))
            
            
            boomViewList[i].center = CGPoint(x:x, y:y)
            
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchRecognizer(_:)))
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGestRecognizer(_:)))
            
            caboomView.isUserInteractionEnabled = true
            caboomView.isMultipleTouchEnabled = true
            caboomView.addGestureRecognizer(pinch)
            caboomView.addGestureRecognizer(pan)
            
            
            
            editPlace.addSubview(caboomView)
            
            
        }
    }
    
    
    
    @IBAction func bommButtonClicked(_ sender: Any) {
        boomView.isHidden = false
    }
    
    
    @IBAction func boomBackButtonClicked(_ sender: UIButton) {
        boomView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        
        
        viewInEditPlace = ImagePageView() as ImagePageView
        (viewInEditPlace)?.initSubviews(nibName:Tools.comicsPatternsById[Storage.common.comicsList[comicsIndex].pages[pageIndex].pattern] , comicsIndex: comicsIndex, pageIndex: pageIndex)
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        updateBoomViews()//
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func setImageButtonClicked(_ sender: UIButton) {
        ind = (viewInEditPlace?.getSelectedViewIndex())!
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //imageView.contentMode = .scaleAspectFit
            viewInEditPlace?.imageViewList[ind].image = pickedImage
            viewInEditPlace?.imageViewList[ind].contentMode = UIViewContentMode.scaleAspectFill
            try! Storage.common.realm.write {
                Storage.common.comicsList[comicsIndex].pages[pageIndex].images[(viewInEditPlace?.getSelectedViewIndex())!].imagePath = Storage.common.saveImage(image: pickedImage)
                
            }
           // currentImageViewList[i].image = Storage.common.loadImage(imageName: img)
            
     
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boomImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        let imageView = cell.viewWithTag(_ :1) as! UIImageView
        imageView.image = boomImages[indexPath.row]

        return cell
    }
    
    let namesOfBoomsImages : [Int : String] = [0:"bang", 1:"boom-copy", 2:"wow"]
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       let testFrame : CGRect = CGRect(x: 30, y: 30, width: 70, height: 50)
        
        let caboomView = BoomView(frame: testFrame) as BoomView
        
        caboomView.initSubviews(nibName: "Boom")
        
        caboomView.image.image = UIImage(named: namesOfBoomsImages[indexPath.row]!)
        
        boomViewList.append(caboomView)
        
        try! Storage.common.realm.write {
 
            Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.append(Boom())
            Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.count - 1].imageName = namesOfBoomsImages[indexPath.row]!
        }
        
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchRecognizer(_:)))
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGestRecognizer(_:)))
        
        caboomView.isUserInteractionEnabled = true
        caboomView.isMultipleTouchEnabled = true
        caboomView.addGestureRecognizer(pinch)
        caboomView.addGestureRecognizer(pan)
        
        editPlace.addSubview(caboomView)
        
     
        
    }


    
    func panGestRecognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }

        sender.view?.isUserInteractionEnabled = true
        sender.view?.isMultipleTouchEnabled = true
        sender.setTranslation(CGPoint.zero, in: self.view)
      
        
    }
    
     func pinchRecognizer(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
  
        }
        sender.view?.isUserInteractionEnabled = true
        sender.view?.isMultipleTouchEnabled = true
         sender.scale = 1
    }
    
 

}
