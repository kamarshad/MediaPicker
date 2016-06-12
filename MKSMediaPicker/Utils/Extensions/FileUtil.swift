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
        let documentsPath:String? = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0]
        return documentsPath
        
    }
    
    static func savedImageDirPath(imageName:String)->String?{
        let imagesDirPath:String? = self.documentsDirectoryPath()
        let yourContentsDirPath = imagesDirPath!.stringByAppendingString("CapturedImages")
        let imageAbsolutePath = yourContentsDirPath.stringByAppendingString(imageName)
        return imageAbsolutePath

    }

   static func getNoOfFilesInDirectoryInDirectory(directory:String)->Int?
    {
        var numberOfContentsInDirectory:Int?
        
        let docsDirPath:String? = self.documentsDirectoryPath()
        
        let yourContentsDirPath = docsDirPath!.stringByAppendingString(docsDirPath!)
        
        var error:NSErrorPointer?
        
        var filelist:AnyObject?
        do {
            filelist = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(yourContentsDirPath)
        } catch let error1 as NSError {
            error!.memory = error1
            filelist = nil
        }
        
        if ((error) != nil) {
            NSLog("Error in getNoOfFilesInDirectoryInDirectory method");
            
        }
        
        numberOfContentsInDirectory = filelist!.count
        
        return numberOfContentsInDirectory;
    }
    
    static func createImageDirectoryIfNeedWithCompletion(folderName folderName :String, completionBlock:(directoryPath:String, fileCount:Int)->Void)
    {
        let docsDirPath:String = self.documentsDirectoryPath()!
        let yourContentsDirPath = (docsDirPath as NSString).stringByAppendingPathComponent(folderName)
        var isDir : ObjCBool = true
        var error: NSError? = nil
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(yourContentsDirPath, isDirectory: &isDir)  {
            do {
                try fileManager.createDirectoryAtPath(yourContentsDirPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error1 as NSError {
                error = error1
            }
        }
        
        if (error != nil) {
            
            NSLog("Error in creating directory");
            
        }
        
        let contents: [AnyObject]?
        do {
            contents = try fileManager.contentsOfDirectoryAtPath(yourContentsDirPath)
        } catch let error1 as NSError {
            error = error1
            contents = nil
        }

        if(contents != nil){
            completionBlock(directoryPath:yourContentsDirPath,fileCount:contents!.count );

        }
        else
        {
            completionBlock(directoryPath:yourContentsDirPath,fileCount:0);
            
        }
        
        
    }
    
    
    static  func getContentsOfDirectoryAtPath(path: String, block: (filenames: [String], error: NSError?) -> ()) {
        let docsDirPath:String = self.documentsDirectoryPath()!
        let yourContentsDirPath = (docsDirPath as NSString).stringByAppendingPathComponent(path)
            var error: NSError? = nil
            let fileManager = NSFileManager.defaultManager()
            let contents: [AnyObject]?
            do {
                contents = try fileManager.contentsOfDirectoryAtPath(yourContentsDirPath)
            } catch let newError as NSError {
                error = newError
                contents = nil
            }

           if contents != nil {
                let filenames = contents as! [String]
                NSLog("Contet count is \(filenames.count)")
                block(filenames: filenames, error: nil)
            }
    }
    
    
    
    //MARK: Add skip to resource.
    
    /*
    static func addSkipBackupAttributeToPath(path:String) {
        let fileURL = NSURL(fileURLWithPath: path)
        self.addSkipBackupAttributeToPath(fileURL);
    }
    
    static func addSkipBackupAttributeToPath(URL:NSURL) ->Bool{
        
        let fileManager = NSFileManager.defaultManager()
        var isFileExist = fileManager.fileExistsAtPath(URL.absoluteString)
        if isFileExist {
        var error:NSError?
    do {
        let success =  try URL.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey)

        if !success{
            print("Error excluding \(URL.lastPathComponent) from backup \(error)")
        }
            return success;
        }
    catch {
        print(error)
    }
    }
    }
        else
        {
            return false;
        
        }
      }
*/
}