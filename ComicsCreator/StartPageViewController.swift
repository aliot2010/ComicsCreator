//
//  StartPageViewController.swift
//  ComicsCreator
//
//  Created by alex L on 17.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {//
        super.viewDidLoad()
        imagePicker.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rozhicy_cherno_beloe_nadpisi_1920x1200" )!)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    @IBAction func buttonAddClicked(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func createComics(_ sender: UIButton) {
        let text = titleTextField.text
        let comics = Comics()
        comics.title = text!
        Storage.common.addNewComix(comix: comics)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageView.contentMode = UIViewContentMode.scaleAspectFill
            let fileManager = FileManager.default
            let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last! as NSURL
            let fileURL = docsURL.appendingPathComponent("photo")
            let data = UIImageJPEGRepresentation(pickedImage, 0.5)
            do{
                try data?.write(to: fileURL!)
            } catch is Error {
                print("Error in saving image")
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
  

}
