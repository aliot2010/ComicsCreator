//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var boomView: UIView!
    @IBOutlet weak var textInBubble: UITextField!
    
    let boomImages = [UIImage(named: "bang"), UIImage(named: "boom-copy"), UIImage(named: "wow")]
    
    let  bubbleImages = [UIImage(named: "buble0"), UIImage(named: "buuble2"), UIImage(named: "bubble3") , UIImage(named: "bubble4")]
    
    var boomViewList = [BoomView]()
    var bubbleViewList = [BubbleView]()
    
    
    let imagePicker = UIImagePickerController()
 
    var pageIndex = 1
    var comicsIndex = 1
    
    
    
    var ind = 0
    
    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
    func updateBoomViews(){
        for i in 0..<Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.count{
            let testFrame : CGRect = CGRect(x: 30, y: 30, width: 100, height: 70)
            
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

            
            updateRecognizers(from: caboomView)
            editPlace.addSubview(caboomView)
            
            
        }
    }
    func updateBubblesViews(){
        for i in 0..<Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles.count{
           
            
            let testFrame : CGRect = CGRect(x: 30, y: 30, width: 120, height: 80)
            let bubView = BubbleView(frame: testFrame) as BubbleView
            bubView.initSubviews(nibName: "Bubble")
            bubbleViewList.append(bubView)
            
            
          
            
            
            bubView.label.text = Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].text
            
            bubView.imageView.image = UIImage(named: Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].imageName)
            
            let x = Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].boomX
            let y = Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].boomY
            
            let scaleX = Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleX
            let scaleY = Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleY
            
            
            bubbleViewList[i].transform = (bubbleViewList[i] as UIView).transform.scaledBy(x: CGFloat(scaleX), y: CGFloat(scaleY))
            
            bubbleViewList[i].center = CGPoint(x:x, y:y)
            updateRecognizers(from: bubView)
            
            editPlace.addSubview(bubView)
            
        }
    }
    
    func updateRecognizers(from view:UIView){
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchRecognizer(_:)))
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGestRecognizer(_:)))
        
        view.isUserInteractionEnabled = true
        view.isMultipleTouchEnabled = true
        view.addGestureRecognizer(pinch)
        view.addGestureRecognizer(pan)
        
    }
    
    @IBAction func bommButtonClicked(_ sender: Any) {
        boomView.isHidden = false
        
    }
    
    
    @IBAction func boomBackButtonClicked(_ sender: UIButton) {
        boomView.isHidden = true
        
    }
    
    @IBAction func bubbleButtonClicked(_ sender: UIButton) {
        bubbleView.isHidden = false
        
    }
    
    @IBAction func bubbleBackButtonClicked(_ sender: UIButton) {
        bubbleView.isHidden = true
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        viewInEditPlace = ImagePageView() as ImagePageView
        (viewInEditPlace)?.initSubviews(nibName:Tools.comicsPatternsById[Storage.common.comicsList[comicsIndex].pages[pageIndex].pattern] , comicsIndex: comicsIndex, pageIndex: pageIndex)
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        updateBoomViews()
        updateBubblesViews()
        
        
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
        
        
       let testFrame : CGRect = CGRect(x: 30, y: 30, width: 100, height: 70)
        
        let caboomView = BoomView(frame: testFrame) as BoomView
        
        caboomView.initSubviews(nibName: "Boom")
        
        caboomView.image.image = UIImage(named: namesOfBoomsImages[indexPath.row]!)
        
        boomViewList.append(caboomView)
        
        try! Storage.common.realm.write {
 
            Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.append(Boom())
            Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[Storage.common.comicsList[comicsIndex].pages[pageIndex].booms.count - 1].imageName = namesOfBoomsImages[indexPath.row]!
        }
        
        

        updateRecognizers(from: caboomView)
        
        editPlace.addSubview(caboomView)
        
     
        
    }
    
    
    @IBAction func onBubbleClicked(_ sender: UIButton) {
        let testFrame : CGRect = CGRect(x: 30, y: 30, width: 120, height: 80)
        //let bubView = BubbleView() as BubbleView
        let bubView = BubbleView(frame: testFrame) as BubbleView
        
        bubView.initSubviews(nibName: "Bubble")
     
        
        
        bubView.imageView.image = UIImage(named: sender.restorationIdentifier!)
        bubView.label.text = textInBubble.text
        
        bubbleViewList.append(bubView)
        
        try! Storage.common.realm.write {
            Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles.append(Bubble())
            Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles.count - 1].imageName = sender.restorationIdentifier!
                Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles.count - 1].text = textInBubble.text!
            
        }
        
        updateRecognizers(from: bubView)
        
        editPlace.addSubview(bubView)
    }

////////////
    
    func panGestRecognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        if(sender.view is BoomView){
            panRecognizeBoom(sender)
        } else if (sender.view is BubbleView){
            panRecognizeBubble(sender)
        }
      
        
      
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func panRecognizeBoom(_ sender: UIPanGestureRecognizer ){
        let translation = sender.translation(in: self.view)
        for i in 0..<boomViewList.count{
            if(boomViewList[i].isEqual(sender.view)){
                try! Storage.common.realm.write {
                    
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].boomX = Double((sender.view?.center.x)!) + Double(translation.x)
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].boomY  = Double((sender.view?.center.y)!) + Double(translation.y)
                }
                break
            }
        }
    }
    func panRecognizeBubble(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        for i in 0..<bubbleViewList.count{
            if(bubbleViewList[i].isEqual(sender.view)){
                try! Storage.common.realm.write {
                    
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].boomX = Double((sender.view?.center.x)!) + Double(translation.x)
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].boomY  = Double((sender.view?.center.y)!) + Double(translation.y)
                }
                break
            }
        }
    }
    
    
     func pinchRecognizer(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            view.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
  
        }//
        if(sender.view is BoomView){
            pinchRecognizeBoom(sender)
        } else if(sender.view is BubbleView){
            pinchRecognizeBubble(sender)
        }
         sender.scale = 1
    }
    
    func pinchRecognizeBoom(_ sender: UIPinchGestureRecognizer){
        for i in 0..<boomViewList.count{
            if(boomViewList[i].isEqual(sender.view)){
                try! Storage.common.realm.write {
                
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleX = Double(Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleX * Double(sender.scale))
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleY = Double(Storage.common.comicsList[comicsIndex].pages[pageIndex].booms[i].scaleY * Double(sender.scale))
                }
                break
            }
        }

    }
    func pinchRecognizeBubble(_ sender: UIPinchGestureRecognizer){
        for i in 0..<bubbleViewList.count{
            if(bubbleViewList[i].isEqual(sender.view)){
                try! Storage.common.realm.write {
                    
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleX = Double(Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleX * Double(sender.scale))
                    Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleY = Double(Storage.common.comicsList[comicsIndex].pages[pageIndex].bubbles[i].scaleY * Double(sender.scale))//
                }
                break
            }
        }
        
    }
    
 

}
