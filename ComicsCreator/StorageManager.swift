//
//  StorageManager.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift

class Storage{
    
    public static let common    = Storage()
    public let realm            = try! Realm()
    public let documentsDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    public var comicsList : Results<Comics>
    
    required init() {
        comicsList = realm.objects(Comics.self)
       
    }
  
    func addNewComix(comix : Comics){
        try! realm.write {
            realm.add(comix)
        }
    }
    func deleteAny(object:Object){
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func deleteComix(comix : Comics){
        try! realm.write {
            realm.delete(comix)
        }
    }
    
    func saveImage(image : UIImage)->String{
        let IMGName = Tools.getTimeAsString()
        let photoURL = NSURL(fileURLWithPath: documentsDirPath).appendingPathComponent(IMGName)
        let data = UIImagePNGRepresentation(image)
        try! data?.write(to: photoURL!, options: Data.WritingOptions.atomic)
        return IMGName
    }
    
    func loadImage(imageName: String) -> UIImage? {
        var image = UIImage()
        let photoURL = NSURL(fileURLWithPath: documentsDirPath).appendingPathComponent(imageName)
        let data = try? Data (contentsOf: photoURL!)
        if data != nil {
            image = UIImage(data:data!)!
        }
        return image
    }
}
