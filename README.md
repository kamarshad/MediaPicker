MediaPicker
===========

This is a Sample to capture image or video from iOS device.Right now it is capable to capture the image but very soon will update it with video shooting feature too


To Integrate this just drag and drop that single file ImageVideoPicker.swift into your project and make a call as below.

define Property of ImageVideoPicker from where you want ot use it..

      var imagePicker:ImageVideoPicker?
      
      self.imagePicker = ImageVideoPicker(frame: self.view.frame, superVC: self) { (capturedImage) -> Void in
                ///
                
                if let captureImage = capturedImage{
                //you did it.....
                
                }
                
            }

