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
    
    
    let imagePicker = UIImagePickerController()
 
    var pageIndex = 1
    var comicsIndex = 1
    
    var ind = 0
    
    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
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
        (viewInEditPlace)?.initSubviews(nibName:Tools.comicsPatternsById[Storage.common.comicsList[comicsIndex].pages[pageIndex].pattern] , comicsIndex: comicsIndex, pageIndex: pageIndex)//
        viewInEditPlace?.frame = editPlace.bounds
        editPlace.addSubview(viewInEditPlace!)
        
        
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
    
    
    

}
