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

@available(iOSApplicationExtension 8.0, *)
class ShareViewController: SLComposeServiceViewController {
    
    let contentTypeList = kUTTypePropertyList as String
    let contentTypeTitle = "public.plain-text"
    let contentTypeUrl = "public.url"
    
    // We don't want to show the view actually
    // as we directly open our app!
    override func viewWillAppear(animated: Bool) {
        self.view.hidden = true
        self.cancel()
        print("Hi")
        self.doClipping()
    }
    
    // We directly forward all the values retrieved from Action.js to our app
    private func doClipping() {
        self.loadJsExtensionValues { dict in
            let url = "myAppScheme://mobileclipper?" + self.dictionaryToQueryString(dict)
            print(url);
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