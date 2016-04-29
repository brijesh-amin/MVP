//
//  ImageTableViewCell.swift
//  MVP_V1
//
//  Copyright © 2016 Brijesh Amin. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var photoImageKeywords: UILabel!
    @IBOutlet weak var photoDownloadActivityIndicator: UIActivityIndicatorView!
    
    // Cancel download task when collection view cell is reused
    var taskToCancelifCellIsReused: NSURLSessionTask? {
        
        didSet {
            if let taskToCancel = oldValue {
                taskToCancel.cancel()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.borderColor = UIColor.blackColor().CGColor
        photoImage.layer.cornerRadius = 10
        photoImage.layer.borderWidth = 1
    }

}
