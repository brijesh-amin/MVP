//
//  ImageCollectionViewCell.swift
//  MVP_V1
//
//  Created by Shruti Pawar on 27/03/16.
//  Copyright © 2016 Brijesh Amin. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photoImageView: UIImageView!
    
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
        photoImageView.layer.borderColor = UIColor.blackColor().CGColor
        photoImageView.layer.cornerRadius = 5
        photoImageView.layer.borderWidth = 1
    }

}
