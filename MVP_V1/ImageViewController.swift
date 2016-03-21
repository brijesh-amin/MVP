//
//  ImageViewController.swift

import UIKit
import ImageWebShareFramework

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    var image: Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image.image
        title = image.title
        if let url = image.url {
            urlLabel.text = url.absoluteString
        }
    }
    
    
    
}