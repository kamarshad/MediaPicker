//
//  ViewController.swift
//  MKSMediaPicker
//
//  Created by Kamar Shad on 07/12/14.
//  Copyright (c) 2014 KSMobileSoft. All rights reserved.
//

import UIKit

class MKSLandingViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var capturedImages:NSArray?
    var mediaPicker :ImageVideoPicker?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        self.updateDataSource()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: CollectionView
    
    func configureCollectionView(){
        var cellNib:UINib = UINib(nibName: "LXMBottomCollectionViewStatusCell", bundle: NSBundle.mainBundle());
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.capturedImages != nil){
            return capturedImages!.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        

        
        var collectionViewCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("DisplayCapturedImageCell", forIndexPath: indexPath) as UICollectionViewCell;
        
        
        var statusImageView:UIImageView = collectionViewCell.viewWithTag(11) as UIImageView;
        var imagePath =  self.capturedImages!.objectAtIndex(indexPath.row)as String
        var absoluteImagePath:String = String.savedImageDirPath(imagePath)!

        statusImageView.image  = UIImage(contentsOfFile:absoluteImagePath)
        
        return collectionViewCell;
        
        
    }
    
    
    //MARK: Capture Image
    
    func intializePhotoPicker(sender:AnyObject){
       
        if(self.mediaPicker == nil){
            
        self.mediaPicker = ImageVideoPicker(frame: self.view.frame, superVC: self, completionBlock: { (isFinshed) -> Void in
           
            if(isFinshed != nil){
                NSLog("Image captured properly")
                self.updateDataSource()
            }
            else
            {
                NSLog("Failure in image capturing")

            }
        })
        }
        
        self.mediaPicker?.showImagePickerActionSheet(sender)
        
    }

    @IBAction func takeMedia(sender: AnyObject) {
        intializePhotoPicker(sender)

    }
    
    func updateDataSource(){
        
        String.getContentsOfDirectoryAtPath("CapturedImages", block: { (filenames, error) -> () in
            self.capturedImages = filenames
            self.imagesCollectionView.reloadData()
            
        })
    }

    
  }

