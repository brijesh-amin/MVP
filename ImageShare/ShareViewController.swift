//
//  ShareViewController.swift
//  MyClipper
//
//  Created by Sébastien Lorber on 15/10/2015.
//
//

import UIKit
import Social
import MobileCoreServices
import ImageWebShareFramework

@available(iOSApplicationExtension 8.0, *)
class ShareViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    let contentTypeList = kUTTypePropertyList as String
    let contentTypeTitle = "public.plain-text"
    let contentTypeUrl = "public.url"
    
    var images:[Image] = [Image]() //ImageService.sharedService.extensionImages

    //SLComposeServiceViewController
    @IBAction func luanchApp(sender: AnyObject) {
       // self.launchContainingApplication()
       // cancel()
         self.extensionContext!.completeRequestReturningItems(nil, completionHandler: nil)
    }
    
    //Layout collection view
    override func viewWillAppear(animated: Bool) {
        //self.view.hidden = true
       // self.cancel()
        super.viewWillAppear(animated)
        //print("Hi")
       // self.doClipping()
        //self.launchContainingApplication()
       
        //self.doOpenUrl("MVP_V1://")
    }
    
    
    func launchContainingApplication() {
//        NSURL *url = [NSURL URLWithString:@"floblog://"];
//        [self.extensionContext openURL:url completionHandler:nil];
//        
        let url = NSURL(string: "MVP_V1://")
        
        if let appURL = url {
            //self.extensionContext?.openURL(appURL, completionHandler: nil)
            var responder: UIResponder? = self
            while let r = responder {
                if r.respondsToSelector("openURL:") {
                    r.performSelector("openURL:", withObject: appURL)
                    break
                }
                responder = r.nextResponder()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item: AnyObject in self.extensionContext!.inputItems {
            
            let inputItem = item as! NSExtensionItem
            
            for provider: AnyObject in inputItem.attachments! {
                
                let itemProvider = provider as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
                    
                    itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (data, error) -> Void in
                        //print (data)
                        let imageService = ImageService.sharedService
                        
                        if let resultDict = data as? NSDictionary {
                            
                            if let urlDictionary = resultDict[NSExtensionJavaScriptPreprocessingResultsKey] as? [String:AnyObject] {
                                
                                var stringArray = [String]()
                                
                                var titleOfImage:String = urlDictionary["title"] as! String
                                let baseUrl:String = urlDictionary["base_url"] as! String
                                //let masurl = "http://www.marksandspencer.com/"
                                var imageDictionary = [String:String]()
                                
                                for (keys,values) in urlDictionary {
                                    if keys == "title" {
                                        titleOfImage = values as! String
                                    } else if keys == "base_url" {
                                        //baseUrl =  values as! String
                                    }
                                    else {
                                       // if baseUrl == masurl {
                                            if let toBeFormattedURL = values as? String {
                                                if (toBeFormattedURL.lowercaseString as NSString).substringToIndex(2) == "//" {
                                                    
                                                    imageDictionary[keys] = "http:" + toBeFormattedURL
                                                    
                                                }else if (toBeFormattedURL.lowercaseString as NSString).substringToIndex(1) == "/" {
                                                    
                                                   // imageDictionary[keys] = "http://www.marksandspencer.com" + toBeFormattedURL
                                                    
                                                    imageDictionary[keys] = baseUrl + toBeFormattedURL
                                                    
                                                }
                                                else {
                                                    imageDictionary[keys] = values as? String
                                                }
                                            }
                                            
//                                        } else {
//                                            imageDictionary[keys] = values as? String
//                                        }
                                    }
                                    
                                    if let url = NSURL(string: values as! String) {
                                        stringArray.append(values as! String)
                                        
                                    }
                                }
                                
                                dispatch_async(dispatch_get_main_queue()) {
                                    imageService.saveImagesURL(stringArray, title: titleOfImage,urlDict: imageDictionary)
                                    imageService.loadImageURL()
                                    self.images = imageService.extensionImages
                                    self.photoCollectionView.reloadData()
                                }
                                
                              
                            }
                        }
                        
                    })
                                       
                }
            }
        }
    }
    
    //MARK:- UICollectionView
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCellWithReuseIdentifier("photoCollectionViewCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // This method will download the image and display as soon  as the imgae is downloaded
    func configureCell(cell:ImageCollectionViewCell, atIndexPath indexPath:NSIndexPath) {
        
        // Show the placeholder image till the time image is being downloaded
        
        let photo:Image = images[indexPath.row]
        var cellImage = UIImage(named: "imagePlaceholder")
        cell.photoImageView.image = nil
        
        //cell.photoImageKeywords.text = photo.id!
        // Set the  image if already available (from hard disk or image cache)
        
        if photo.image != nil {

            cellImage = photo.image
            
        } else {
            
            //If image is not available, download the  image
            //Start the task that will eventually download the image

            cell.activityIndicator.startAnimating()
            
            let task = NetworkClient.sharedInstance().taskForImage(photo.url!) {
                data, error in
                if let downloaderror = error {
                    print("image download error: \(downloaderror.localizedDescription)", terminator: "")
                    cell.activityIndicator.stopAnimating()
                }
                if let imageData = data {
                    
                    // Create the image
                    let image = UIImage(data: imageData)
                    // Update the model so that information gets cached
                    photo.image = image
                    
                    // update the cell later, on the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        //photo.downloadStatus = true
                        cell.photoImageView.image = image
                        cell.activityIndicator.stopAnimating()
                    }
                } else {
                    print("Data is not convertible to Image Data.")

                        cell.activityIndicator.stopAnimating()
                    
                }
            }
            cell.taskToCancelifCellIsReused = task
        }
        
        cell.photoImageView.image = cellImage
    }
    
    // We directly forward all the values retrieved from Action.js to our app
    private func doClipping() {
        self.loadJsExtensionValues { dict in
                        let url = "myAppScheme://MVP_V1?" + self.dictionaryToQueryString(dict)
            //            print(url);
                        self.doOpenUrl(url)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    private func dictionaryToQueryString(dict: Dictionary<String,String>) -> String {
        return dict.map({ entry in
            let value = entry.1
            let valueEncoded = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
            return entry.0 + "=" + valueEncoded!
        }).joinWithSeparator("&")
    }
    
    // See https://github.com/extendedmind/extendedmind/blob/master/frontend/cordova/app/platforms/ios/extmd-share/ShareViewController.swift
    private func loadJsExtensionValues(f: Dictionary<String,String> -> Void) {
        print("Hello")
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        if (self.hasAttachmentOfType(content, contentType: contentTypeList)) {
            self.loadJsDictionnary(content) { dict in
                f(dict)
            }
        } else {
            self.loadUTIDictionnary(content) { dict in
                // 2 Items should be in dict to launch clipper opening : url and title.
                if (dict.count==2) { f(dict) }
            }
        }
    }
    
    private func hasAttachmentOfType(content: NSExtensionItem,contentType: String) -> Bool {
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                return true;
            }
        }
        return false;
    }
    
    private func loadJsDictionnary(content: NSExtensionItem,f: Dictionary<String,String> -> Void)  {
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentTypeList) {
                attachment.loadItemForTypeIdentifier(contentTypeList, options: nil) { data, error in
                    if ( error == nil && data != nil ) {
                        let jsDict = data as! NSDictionary
                        if let jsPreprocessingResults = jsDict[NSExtensionJavaScriptPreprocessingResultsKey] {
                            let values = jsPreprocessingResults as! Dictionary<String,String>
                            f(values)
                        }
                    }
                }
            }
        }
    }
    
    
    private func loadUTIDictionnary(content: NSExtensionItem,f: Dictionary<String,String> -> Void) {
        var dict = Dictionary<String, String>()
        loadUTIString(content, utiKey: contentTypeUrl   , handler: { url_NSSecureCoding in
            let url_NSurl = url_NSSecureCoding as! NSURL
            let url_String = url_NSurl.absoluteString as String
            dict["url"] = url_String
            f(dict)
        })
        loadUTIString(content, utiKey: contentTypeTitle, handler: { title_NSSecureCoding in
            let title = title_NSSecureCoding as! String
            dict["title"] = title
            f(dict)
        })
    }
    
    
    private func loadUTIString(content: NSExtensionItem,utiKey: String,handler: NSSecureCoding -> Void) {
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(utiKey) {
                attachment.loadItemForTypeIdentifier(utiKey, options: nil, completionHandler: { (data, error) -> Void in
                    if ( error == nil && data != nil ) {
                        handler(data!)
                    }
                })
            }
        }
    }
    
    
    // See http://stackoverflow.com/a/28037297/82609
    // Works fine for iOS 8.x and 9.0 but may not work anymore in the future :(
    private func doOpenUrl(url: String) {
        let urlNS = NSURL(string: url)!
        var responder = self as UIResponder?
        while (responder != nil){
            if responder!.respondsToSelector(Selector("openURL:")) == true{
                responder!.callSelector(Selector("openURL:"), object: urlNS, delay: 0)
            }
            responder = responder!.nextResponder()
        }
    }
}

// See http://stackoverflow.com/a/28037297/82609
extension NSObject {
    func callSelector(selector: Selector, object: AnyObject?, delay: NSTimeInterval) {
        let delay = delay * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            NSThread.detachNewThreadSelector(selector, toTarget:self, withObject: object)
        })
    }
}





