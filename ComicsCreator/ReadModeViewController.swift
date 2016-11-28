//
//  ReadModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 28.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class ReadModeViewController: UIViewController {
    
    var pageIndex:Int=0
    var comicsIndex:Int=0
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var readPlace: UIView!
    
    let boomImages = [UIImage(named: "bang"), UIImage(named: "boom-copy"), UIImage(named: "wow")]
    
    let  bubbleImages = [UIImage(named: "buble0"), UIImage(named: "buuble2"), UIImage(named: "bubble3") , UIImage(named: "bubble4")]
    
    var boomViewList = [BoomView]()
    var bubbleViewList = [BubbleView]()
    
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
            
            
           
            readPlace.addSubview(caboomView)
            
            
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
            
            
            readPlace.addSubview(bubView)
            
        }
    }
    
    var viewInEditPlace:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInEditPlace = ImagePageView() as ImagePageView
        (viewInEditPlace as! ImagePageView).initSubviews(nibName:Tools.comicsPatternsById[Storage.common.comicsList[comicsIndex].pages[pageIndex].pattern] , comicsIndex: comicsIndex, pageIndex: pageIndex)
        (viewInEditPlace as! ImagePageView).setClickedDesebled()
        
        viewInEditPlace?.frame = readPlace.bounds
        readPlace.addSubview(viewInEditPlace!)
        
        updateBoomViews()
        updateBubblesViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func nextPageClicked(_ sender: UIButton) {
        if (pageIndex + 1 < Storage.common.comicsList[comicsIndex].pages.count ){
            pageIndex += 1
            boomViewList = [BoomView]()
            bubbleViewList = [BubbleView]()
            self.viewDidLoad()
            
        }
    }
 
    @IBAction func previosButtonClicked(_ sender: UIButton) {
        if (pageIndex  != 0){
            pageIndex -= 1
            boomViewList = [BoomView]()
            bubbleViewList = [BubbleView]()
            self.viewDidLoad()
            
        }
    }

}
