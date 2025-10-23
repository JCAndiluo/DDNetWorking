////
////  DDLocCacheUtils.swift
////  DingDa
////
////  Created by 邹建敏 on 2017/5/20.
////  Copyright © 2017年 DingDa Inc. All rights reserved.
////
//
import UIKit

let cachePath =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)[0]

class DDLocCacheUtils: NSObject {
    
    class func saveData(_ object: NSObject, _ filename : String) -> Bool {
        let fileName = filename
     
        let dic = NSMutableDictionary()
        let path = cachePath.appending(fileName.appending(".plist"))
        let aMirror = Mirror(reflecting: object)
        for case let (label?, value) in aMirror.children {
            dic.setValue(value, forKey: label)
        }
        return dic.write(toFile: path, atomically: true)
    }
    class func readData(_ filename: String , _ className: String) -> NSObject?{
        
        let fileName = filename
        let path = cachePath.appending(fileName.appending(".plist"))
        let filemanager = FileManager.default
        if !filemanager.fileExists(atPath: path) {
            DDLog("文件不存在")
            return nil
        }
        let dic = NSDictionary.init(contentsOfFile: path)
        let classType = NSClassFromString(className) as? NSObject.Type
        if let type = classType {
            let resultobject = type.init()
            let aMirror = Mirror(reflecting: resultobject)
            for case let (label?, _) in aMirror.children {
                resultobject.setValue(dic?[label], forKey: label)
            }
            return resultobject
        }
        return nil
    }
    
    class func deleteData(_ filename: String)-> Bool{
        let fileName = filename
        let path = cachePath.appending(fileName.appending(".plist"))
        let filemanager = FileManager.default
        if filemanager.fileExists(atPath: path){
            return  filemanager.isDeletableFile(atPath: path)
        }else {
            return true
        }
    }
}
