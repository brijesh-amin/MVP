//
//  ImageCache.swift
//  MVP_V1
//
//  Copyright © 2016 MVP. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    private var inMemoryCache = NSCache()
    
    //MARK:- Retrieving Images
    
    func imageWithIdentifier(identifier:String?) -> UIImage? {
        if identifier == nil || identifier! == "" {
            return nil
        }
        
        let path = pathForIdentifier(identifier!)
        
        // Memory Cache
        if let image = inMemoryCache.objectForKey(path) as? UIImage {
            return image
        }
        
        //if not in Memory cache, then in Hard drive
        if let data = NSData(contentsOfFile: path) {
            return UIImage(data: data)
        }
        return nil
        
    }
    
    //MARK: Saving Images
    
    func storeImage(image:UIImage?, withIdentifier identifier:String) {
        
        let path = pathForIdentifier(identifier)
        print(path)
        
        //If the image is nil, remove images from cache and hard disk
        if image == nil {
            inMemoryCache.removeObjectForKey(path)
            do {
                try NSFileManager.defaultManager().removeItemAtPath(path)
            } catch _ {
            }
            return
        }
        
        //Otherwise keep image in memory
        inMemoryCache.setObject(image!, forKey: path)
        
        // And add in documents directory
        let data = UIImagePNGRepresentation(image!)
        if  data!.writeToFile(path, atomically: true) {
            print("***** Data Written to file *****")
        }
    }
    
    
    
    //MARK:- Imagepath based on Id
    
    func pathForIdentifier(identifier:String) -> String {
        let documentsDirectoryURL: NSURL =  NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first!
        
        let fullPathURL = documentsDirectoryURL.URLByAppendingPathComponent(identifier)
        return fullPathURL.path!
    }
    
}