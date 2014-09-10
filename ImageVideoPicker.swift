//
//  ImageVideoPicker.swift
//  HelloSwift
//
//  Created by Mohd Kamarshad on 10/09/14.
//  Copyright (c) 2014 Mohd Kamarshad. All rights reserved.
//

import UIKit


class ImageVideoPicker: UIView,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //MARK:- PROPERTIES
    
    var originVC:UIViewController?
    
    //Closure to callback captured image     
    typealias imageCaptureClosure = (capturedImage:UIImage?)->Void
    var imageCompletionClosure:imageCaptureClosure?
    
    
    //MARK: - View Life Cycle Methods
    init(originVC:UIViewController, completionBlock:imageCaptureClosure){
        self.originVC = originVC
        self.imageCompletionClosure = completionBlock
        super.init()
        
        //Display Capture Options to the User....
        self.showImagePickerActionSheet()
    }
    
    
    required init(coder aDecoder: NSCoder) {
        self.originVC = nil
        self.imageCompletionClosure = nil
        super.init(coder: aDecoder)
        
    }
    
    
    //MARK:- Private Methods
    
    func showImagePickerActionSheet(){
        var actionSheet = UIAlertController(title: " ", message:"Take Pic", preferredStyle: UIAlertControllerStyle.Alert)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancelAction))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:handleCameraAction))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.Destructive, handler:handlePhotoLibAction))

        self.originVC!.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    private func handleCancelAction(alertAction:UIAlertAction!){
        self.imageCompletionClosure!(capturedImage:nil)
        self.originVC!.dismissViewControllerAnimated(true, completion:nil)
        
    }
    
    private func handleCameraAction(alertAction:UIAlertAction!){
        
        self.startCameraControllerFromViewController(self.originVC, usingDelegate:self)
    }

    private func handlePhotoLibAction(alertAction:UIAlertAction!){
        self.startPhotoLibraryControllerFromViewController(self.originVC, usingDelegate:self)
    }

    private func startPhotoLibraryControllerFromViewController<T where T: UINavigationControllerDelegate,T: UIImagePickerControllerDelegate>(controller:UIViewController?,
        usingDelegate delegate: T?)->Bool{
            
            if((UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) == false)||(controller == nil)||(delegate == nil)){
                return false
                
            }
            
            var libraryUI = UIImagePickerController()
            libraryUI.delegate = delegate
            controller!.presentViewController(libraryUI, animated: true, completion:nil)
            
            return true
    }
    
    
    
    private func startCameraControllerFromViewController<T where T: UINavigationControllerDelegate,T: UIImagePickerControllerDelegate>(controller:UIViewController?, usingDelegate delegate:T?)->Bool
    {
        if((UIImagePickerController.isSourceTypeAvailable(.Camera) == false)||(controller == nil)||(delegate == nil)){
            return false
            
        }
        
        var cameraUI = UIImagePickerController()
        cameraUI.delegate = delegate
        cameraUI.sourceType = .Camera;
        // Displays a control that allows the user to choose picture or
        // movie capture, if both are available:
        cameraUI.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.Camera)
        
        // Hides the controls for moving & scaling pictures, or for
        // trimming movies. To instead show the controls, use YES.
        cameraUI.allowsEditing = false;
        cameraUI.delegate = delegate;
      
        controller!.presentViewController(cameraUI, animated: true, completion:nil)
        
        return true;
    }
    
    //MARK: - UIImagePickerControllerDelegate delegate methods
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!)
    {
        
        let tempImage = info[UIImagePickerControllerOriginalImage] as UIImage
        
        if (self.imageCompletionClosure != nil)
        {
            self.imageCompletionClosure!(capturedImage: tempImage);
            
        }
        picker.dismissViewControllerAnimated(true,completion:nil);
        
    }
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        if (self.imageCompletionClosure != nil)
        {
            self.imageCompletionClosure!(capturedImage: nil);
        }
        
        picker.dismissViewControllerAnimated(true,completion:nil);
    }
}
