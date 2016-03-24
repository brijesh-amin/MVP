//
//  ImagesTableViewController.swift
//


import UIKit
import ImageWebShareFramework

class ImagesTableViewController: UITableViewController {
    
    var imagesURL:[NSURL] = ImageService.sharedService.imagesURL
    var images:[Image] = ImageService.sharedService.extensionImages
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        // tableView.reloadData()
    }
    
    func refreshTable() {
        tableView.reloadData()
        //print(ImageService.sharedService.imagesURL)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let image = images[indexPath.row]
        
        //        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell")
        //        cell!.textLabel?.text = image.title
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("imageTableViewCell") as! ImageTableViewCell
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    // This method will download the image and display as soon  as the imgae is downloaded
    func configureCell(cell:ImageTableViewCell, atIndexPath indexPath:NSIndexPath) {
        
        // Show the placeholder image till the time image is being downloaded
        
        let photo:Image = images[indexPath.row]
        var cellImage = UIImage(named: "imagePlaceholder")
        cell.photoImage.image = nil
        cell.photoImageKeywords.text = photo.id!
        // Set the  image if already available (from hard disk or image cache)
        if photo.image != nil {
            cellImage = photo.image
        } else {
            
            //If image is not available, download the  image
            //Start the task that will eventually download the image
            
            cell.photoDownloadActivityIndicator.startAnimating()
            
            let task = NetworkClient.sharedInstance().taskForImage(photo.url!) {
                data, error in
                if let downloaderror = error {
                    print("image download error: \(downloaderror.localizedDescription)", terminator: "")
                    cell.photoDownloadActivityIndicator.stopAnimating()
                }
                if let imageData = data {
                    
                    // Create the image
                    let image = UIImage(data: imageData)
                    // Update the model so that information gets cached
                    photo.image = image
                    
                    // update the cell later, on the main thread
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        //photo.downloadStatus = true
                        cell.photoImage.image = image
                        cell.photoDownloadActivityIndicator.stopAnimating()
                        
                        // Update the state of the image that it is downloaded
                        // CoreDataStackManager.sharedInstance().saveContext()
                        
                        //self.updateToolbarButton()
                    }
                } else {
                    print("Data is not convertible to Image Data.")
                    cell.photoDownloadActivityIndicator.stopAnimating()
                }
            }
            cell.taskToCancelifCellIsReused = task
        }
        
        cell.photoImage.image = cellImage
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showImageSegue") {
            let indexPath: NSIndexPath = tableView.indexPathForSelectedRow!
            //let image = ImageService.sharedService.images[indexPath.row]
            
           // let destViewController = segue.destinationViewController as! ImageViewController
            //destViewController.image = image
        }
        
    }
    
}
