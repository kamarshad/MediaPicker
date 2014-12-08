MediaPicker
===========

This is a Demo app to to capture image/video from iOS device.As of now it is only capable to capture the image
As i will done with the Video recording will update it.


To Integrate this just drag and drop that single file ImageVideoPicker.swift into your project and make a call as below.

define Property of ImageVideoPicker from where you want ot use it..

      func intializePhotoPicker(sender:AnyObject){
       
        if(self.mediaPicker == nil){
            
        self.mediaPicker = ImageVideoPicker(frame: self.view.frame, superVC: self, completionBlock: { (isFinshed) ->           Void in
            if(isFinshed != nil){
                NSLog("Image captured properly")
            //Update the data Source
            }
            else
            {
                NSLog("Failure in image capturing")

            }
           })
        self.mediaPicker?.showImagePickerActionSheet(sender)
         
    }


