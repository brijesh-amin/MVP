//
//  ImageService.swift
//  ImgurShare
//
//
//

import Foundation
import UIKit

public class ImageService {
    
    public lazy var images: [Image] = ImageService.sharedService.loadImages()
    
    public class var sharedService: ImageService {
        struct Singleton {
            static let instance = ImageService()
        }
        return Singleton.instance
    }
    
    init() {
        let queue = NSOperationQueue.mainQueue()
        let notificationCenter = NSNotificationCenter.defaultCenter()
        
        notificationCenter.addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: queue) { _ in
            self.saveImages()
        }
        
        notificationCenter.addObserverForName(UIApplicationWillEnterForegroundNotification, object: nil, queue: queue) { _ in
            self.images = self.loadImages()
        }
    }
    
    public func loadImages() -> [Image] {
        var loadedImages: [Image] = []
        if (NSFileManager.defaultManager().fileExistsAtPath(getFileUrl().path ?? "")) {
            var loadError: NSError?
            let imagesData: NSData?
            do {
                imagesData = try NSData(contentsOfFile: getFileUrl().path!, options: .DataReadingUncached)
            } catch var error as NSError {
                loadError = error
                imagesData = nil
            }
            if loadError != nil {
                print("Loading Error: \(loadError!)")
            } else {
                let unarchivedImages: [Image]! = NSKeyedUnarchiver.unarchiveObjectWithData(imagesData!) as! Array
                if unarchivedImages != nil {
                    loadedImages = unarchivedImages
                }
            }
        }
        
        return loadedImages
    }
    
    func tempContainerURL(image: UIImage, name: String) -> NSURL? {
        if let containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.brij.web") {
            let contairURLWithName = containerURL.URLByAppendingPathComponent(name)
            if !NSFileManager.defaultManager().fileExistsAtPath(contairURLWithName.path!) {
                do {
                    try NSFileManager.defaultManager().createDirectoryAtPath(containerURL.path!, withIntermediateDirectories: false, attributes: nil)
                } catch _ {
                }
            }
            
            var imageDirectoryURL = containerURL
            imageDirectoryURL = imageDirectoryURL.URLByAppendingPathComponent(name)
            imageDirectoryURL = imageDirectoryURL.URLByAppendingPathExtension("jpg")
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            let saved = imageData!.writeToFile(imageDirectoryURL.path!, atomically: true)
            return imageDirectoryURL
        } else {
            return nil
        }
    }
    
    func getFileUrl() -> NSURL {
        if let containerUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.brij.web") {
            return containerUrl.URLByAppendingPathComponent("Uploads")
        } else {
            fatalError("Error obtaining shared container URL. Check your App Group configuration.")
        }
    }
    
    public func saveImages() {
        let imagesData = NSKeyedArchiver.archivedDataWithRootObject(images)
        var saveError: NSError?
        do {
            try imagesData.writeToURL(getFileUrl(), options: NSDataWritingOptions.AtomicWrite)
        } catch let error as NSError {
            saveError = error
        }
        if saveError != nil {
            print("Saving Error: \(saveError!)")
        }
    }
    
    public func addImage(image: Image) {
        images.insert(image, atIndex: 0)
    }
    
}
