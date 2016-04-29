//
//  NetworkClient.swift
//  MVP_V1
//
//  Copyright © 2016 MVP. All rights reserved.
//

import UIKit

public class NetworkClient: NSObject {
    
    var session: NSURLSession
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }

    
    /// Data task to download  image
   public func taskForImage(filePath:NSURL, completionHandler :(imageDate:NSData?, error:NSError?) -> Void)-> NSURLSessionTask {
        
        //  image URL
        let request = NSURLRequest(URL: filePath)
        
        // Make the request
        let task = session.dataTaskWithRequest(request) {
            data, response, downloadError in
            
            if let error = downloadError {
                let newError = NetworkClient.errorForData(data, response: response, error: error)
                completionHandler(imageDate: data, error: newError)
            } else {
                completionHandler(imageDate: data, error: nil)
            }
        }
        task.resume()
        return task
        
    }
    
    // Display error
    class func errorForData(data:NSData?, response:NSURLResponse?, error:NSError) -> NSError {
        
        if let data = data {
            if let parsedResult = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)) as? [String:AnyObject] {
                
                if let errorMessage = parsedResult["message"] as? String {
                    let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                    return NSError(domain: "ImageShare Error", code: 1, userInfo: userInfo)
                }
            }
        }
        
        return error
    }
    
    //MARK:- SharedInstance
    
   public class func sharedInstance()-> NetworkClient {
        struct Singleton {
            static var sharedInstance = NetworkClient()
        }
        return Singleton.sharedInstance
    }
    
    //MARK:- Shared Image Cache
    
    struct Caches {
        static let imageCache = ImageCache()
    }

}
