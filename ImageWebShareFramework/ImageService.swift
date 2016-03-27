//
//  ImageService.swift
//  ImgurShare
//
//
//

import Foundation
import UIKit

public class ImageService {
    
    
    public var imagesURL:[NSURL] = [NSURL]()
    
    public var extensionImages:[Image] = [Image]()
    
    // Save  using NSKeyedArchiver
    
    var imageFilePath: String {
        let manager = NSFileManager.defaultManager()
        
        let url = manager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).first! as NSURL!
        print(url)
        return url.URLByAppendingPathComponent("imageArchive").path!
    }
    
    public class var sharedService: ImageService {
        struct Singleton {
            static let instance = ImageService()
        }
        return Singleton.instance
    }
    
    init() {
        let queue = NSOperationQueue.mainQueue()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        self.loadImageURL()
        notificationCenter.addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: queue) { _ in
            
        }
        
        notificationCenter.addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: queue) { _ in
        }
        
        
    }
    
    func removeImages() {
        if extensionImages.count > 0 {
            for image in extensionImages {
                image.image = nil
            }
        }
        
        extensionImages = [Image]()
    }
    public func loadImageURL() -> [NSURL] {
        
        
        var loadedImageURL:[NSURL] = []
        
        let userDefaults = NSUserDefaults(suiteName: "group.com.brij.web")
        var titleOfImage:String? = nil
        if let imageTitle = userDefaults?.objectForKey("title") as? String {
            titleOfImage = imageTitle
        }
        
        //urlDictionary
        if let imagesDictionary = userDefaults?.objectForKey("urlDictionary") as? [String:String] {
            for (key,values) in imagesDictionary {
                if let url = NSURL(string: values) {
                    addImageURL(url)
                    let image = Image(imgTitle: titleOfImage, imgId:key, imgUrl: url)
                    extensionImages.append(image)
                }
            }
        }
        
        return loadedImageURL
    }
    
    func getFileUrl() -> NSURL {
        if let containerUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.brij.web") {
            return containerUrl.URLByAppendingPathComponent("Uploads")
        } else {
            fatalError("Error obtaining shared container URL. Check your App Group configuration.")
        }
    }
    
   
    public func addImageURL(imageURL: NSURL) {
        imagesURL.append(imageURL)
    }
    
    
    
    public func saveImagesURL(urlArray:[String], title:String, urlDict:[String:String]) {
        //  let imagesData = NSKeyedArchiver.archivedDataWithRootObject(imagesURL)
        //        print(imagesData)
        //NSKeyedArchiver.archiveRootObject(imagesURL, toFile: imageFilePath)
        let userDefaults = NSUserDefaults(suiteName: "group.com.brij.web")
        userDefaults!.setObject(urlArray, forKey: "storeImageURLS")
        userDefaults!.setObject(title, forKey: "title")
        userDefaults!.setObject(urlDict, forKey: "urlDictionary")
        userDefaults!.synchronize()
    }
    
}
