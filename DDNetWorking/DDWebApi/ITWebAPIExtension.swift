//
//  ITWebAPIExt.swift
//  ITWebAPI
//
//  Created by 吴知洋 on 16/2/25.
//  Copyright © 2016年 杭州艾拓. All rights reserved.
//

import Foundation
import CommonCrypto
public extension String  {
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        
        return String(format: hash as String)
    }
    
    func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    static func isEmpty(_ str:String?) -> Bool{
        if let str_ = str{
            let trimString = str_.trim()
            return trimString == "" || trimString.caseInsensitiveCompare("null") == ComparisonResult.orderedSame
        }
        return true
    }
    
    static func isEmptyReplace(_ checkStr:String?,replace:String) -> String{
        return (String.isEmpty(checkStr)) ? replace : checkStr!
    }
    
}

public extension Date {
    static func stringToDate(_ dateString:String,format:String = "yyyy-MM-dd HH:mm:ss") -> Date?{
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: dateString)
    }
    
    func toString(_ format:String = "yyyy-MM-dd HH:mm:ss") -> String{
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    static func timeIntervalSince1970(_ timeStamp:String) -> Date?{
        if let timeDouble = Double(timeStamp){
            return Date(timeIntervalSince1970: timeDouble/1000)
        }
        return nil
    }
}

public extension Optional {
    
    func toString(_ def:String = "") -> String?{
        switch(self){
        case .none:
            return def
        case .some:
            return String(describing: self!)
        }
    }
}
