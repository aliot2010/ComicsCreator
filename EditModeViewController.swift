//
//  EditModeViewController.swift
//  ComicsCreator
//
//  Created by alex L on 22.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class EditModeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    let imagePicker = UIImagePickerController()
 
    var pageIndex = 1
    var comicsIndex = 1
    
    var ind = 0
    
    var viewInEditPlace:ImagePageView? = nil
    @IBOutlet weak var editPlace: UIView!
    var viewEditPlaceholder:UIView?
    
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
     
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
