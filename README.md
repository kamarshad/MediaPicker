MediaPicker
===========

This is a Sample to capture image or video from iOS device. write it has only capability to capture the image but very soon will update it with video shooting feature too

To Integrate this just drag and drop that single file ImageVideoPicker.swift into your project and make a call as below.

        var imagePicker:ImageVideoPicker? = ImageVideoPicker(originVC: self) { (capturedImage) -> Void in
            //
            
            //use the returned image  |capturedImage|
        }
