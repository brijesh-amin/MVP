//
//  Image.swift
//  ImgurShare
//
//

import Foundation
import UIKit

public class Image: NSObject {
    
    public var id:String?
    public var title: String? // from js - title of web site
    public var url: NSURL? //final url (after processing)
    
    public init(imgTitle: String?,imgId:String?, imgUrl:NSURL?) {
        title = imgTitle
        url = imgUrl
        id = imgId
        super.init()
    }
    
    // Download image to documents directory and retrieve it using image identifier
    public var image: UIImage? {
        get {
            return NetworkClient.Caches.imageCache.imageWithIdentifier(id!)
        }
        set {
            NetworkClient.Caches.imageCache.storeImage(newValue, withIdentifier: id!)
        }
    }
    
    
}
