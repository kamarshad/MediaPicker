//
//  ViewController.swift
//  MKSMediaPicker
//
//  Created by Kamar Shad on 07/12/14.
//  Copyright (c) 2014 KSMobileSoft. All rights reserved.
//

import UIKit


let kCellIdentifier: String = "CustomCollectionViewCell";

class MKSLandingViewController: UIViewController {

    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var capturedImages:NSArray?
    var mediaPicker :MKSImagePicker?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.updateDataSource()
        self.imagesCollectionView.registerNib(UINib.init(nibName: kCellIdentifier, bundle: nil), forCellWithReuseIdentifier: kCellIdentifier)
        
        
        let flow = self.imagesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = 3
        flow.minimumLineSpacing = 3
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.itemSize = self.appropriateCellSize(6, numberOfItemPerRow:2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let collectionViewCell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(kCellIdentifier, forIndexPath: indexPath) as UICollectionViewCell;
        
        if let statusImageView = collectionViewCell.contentView.viewWithTag(111) as? UIImageView{
            let imageName =  self.capturedImages!.objectAtIndex(indexPath.row)as! String
            let imagePath:String = String.savedImageDirPath(imageName)!
            statusImageView.image  = UIImage(contentsOfFile: imagePath)
        }
        return collectionViewCell;
        
        
    }
    
    /*
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return appropriateCellSize(3);
        
    }
    */
    func  appropriateCellSize(spacing:CGFloat, numberOfItemPerRow: Int)->CGSize{
    
        let width = Int((UIScreen .mainScreen().bounds.size.width - spacing))/numberOfItemPerRow;
    
        print("cell width is \(width)")
        
        return CGSize(width: width, height: width);
        
    }
    
    //MARK: Capture Image
    
    func intializePhotoPicker(sender:AnyObject){
       
        if(self.mediaPicker == nil){
            
        self.mediaPicker = MKSImagePicker(frame: self.view.frame, superVC: self, completionBlock: { (isFinshed) -> Void in
           
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
        
        self.mediaPicker?.showImagePickerActionSheet(sender )
        
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

