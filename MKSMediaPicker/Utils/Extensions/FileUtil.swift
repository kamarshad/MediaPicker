//
//  String+Directory.swift
//  HelloSwift
//
//  Created by Mohd Kamarshad on 01/09/14.
//  Copyright (c) 2014 Mohd Kamarshad. All rights reserved.
//

import Foundation


extension String{
    
    static func documentsDirectoryPath()->String?{
        var documentsPath:String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as? String
        return documentsPath
        
    }
    
    static func savedImageDirPath(imageName:String)->String?{
        var imagesDirPath:String? = self.documentsDirectoryPath()
        var yourContentsDirPath = imagesDirPath?.stringByAppendingPathComponent("CapturedImages")
        var imageAbsolutePath = yourContentsDirPath?.stringByAppendingPathComponent(imageName)
        return imageAbsolutePath

    }

   static func getNoOfFilesInDirectoryInDirectory(directory:String)->Int?
    {
        var numberOfContentsInDirectory:Int?
        
        var docsDirPath:String? = self.documentsDirectoryPath()
        
        var yourContentsDirPath = docsDirPath?.stringByAppendingPathComponent(docsDirPath!)
        
        var error:NSErrorPointer?
        
        var filelist:AnyObject? =  NSFileManager.defaultManager().contentsOfDirectoryAtPath(yourContentsDirPath!, error:error!)
        
        if ((error) != nil) {
            NSLog("Error in getNoOfFilesInDirectoryInDirectory method");
            
        }
        
        numberOfContentsInDirectory = filelist!.count
        
        return numberOfContentsInDirectory;
    }
    
    static func createImageDirectoryIfNeedWithCompletion(#folderName :String, completionBlock:(directoryPath:String, fileCount:Int)->Void)
    {
        var docsDirPath:String = self.documentsDirectoryPath()!
        var yourContentsDirPath = docsDirPath.stringByAppendingPathComponent(folderName)
        var isDir : ObjCBool = true
        var error: NSError? = nil
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(yourContentsDirPath, isDirectory: &isDir)  {
            fileManager.createDirectoryAtPath(yourContentsDirPath, withIntermediateDirectories: false, attributes: nil, error:&error)
        }
        
        if (error != nil) {
            
            NSLog("Error in creating directory");
            
        }
        
        let contents = fileManager.contentsOfDirectoryAtPath(yourContentsDirPath, error: &error)

        if(contents != nil){
            completionBlock(directoryPath:yourContentsDirPath,fileCount:contents!.count );

        }
        else
        {
            completionBlock(directoryPath:yourContentsDirPath,fileCount:0);
            
        }
        
        
    }
    
    
    static  func getContentsOfDirectoryAtPath(path: String, block: (filenames: [String], error: NSError?) -> ()) {
        var docsDirPath:String = self.documentsDirectoryPath()!
        var yourContentsDirPath = docsDirPath.stringByAppendingPathComponent(path)
            var error: NSError? = nil
            let fileManager = NSFileManager.defaultManager()
            let contents = fileManager.contentsOfDirectoryAtPath(yourContentsDirPath, error: &error)

           if contents != nil {
                let filenames = contents as [String]
                NSLog("Contet count is \(filenames.count)")
                block(filenames: filenames, error: nil)
            }
    }
    
    
    
    static func addSkipBackupAttributeToPath(path:String) {
        var fileURL = NSURL(fileURLWithPath: path)
       // self.addSkipBackupAttributeToPath(fileURL!);
    }
    
//    static func addSkipBackupAttributeToPath(URL:NSURL) ->Bool{
//        
//        let fileManager = NSFileManager.defaultManager()
//        var isFileExist = fileManager.fileExistsAtPath(URL.absoluteString!)
//        if isFileExist {
//        var error:NSError?
//        let success:Bool = URL.setResourceValue(NSNumber.numberWithBool(true),forKey: NSURLIsExcludedFromBackupKey, error: &error)
//         if !success{
//            
//            println("Error excluding \(URL.lastPathComponent) from backup \(error)")
//        }
//            return success;
//        }
//        else
//        {
//            return false;
//        
//        }
//      }
}