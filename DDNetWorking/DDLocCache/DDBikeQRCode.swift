////
////  DDBikeQRCode.swift
////  DDBlueBikeManagerBuild
////
////  Created by Ice on 2018/4/18.
////  Copyright © 2018年 Ice. All rights reserved.
////
//
import Foundation
protocol QRCode {
    func isValid() -> Bool
}
/*自行车二维码*/
public class DDBikeQRCode: QRCode{
    
    open var cityId: String? //城市编号
    open var bikeId: String? //车辆编号
    open var parkingId: String? //桩编号
    open var siteId: String? //站点编号
    open var isValid_: Bool = false
    open var bizType: String?
    open var datetime: String?
    open var qrcode: String?
    
    
    func isValid() -> Bool {
        return isValid_
    }
    func getValueFromScanResult(scanResult: String, key: String) -> String {
        
        let str: String = scanResult.components(separatedBy: "?").last!
        let arr = str.components(separatedBy: "&")
        var dic = Dictionary<String, Any>()
        for str: String in arr {
            let arr = str.components(separatedBy: "=")
            dic.updateValue(arr.last ?? String(), forKey: arr.first!)
        }
        if dic[key] != nil {
            return dic[key] as! String
        } else {
            return ""
        }
        
        
    }
    //助力车扫码解析
    func parseMopedCodeResult(_ result: String) -> [String] {
        if result.contains("&") {
            let arr = result.components(separatedBy: "&")
            if arr.count == 4 {
                return arr
            }
            return []
        }
        return []
    }
    
    //MARK: ---匹配字符串中所有的URL
     func getUrls(str:String) -> [String] {
        var urls = [String]()
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str,
                                           options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                           range: NSMakeRange(0, str.count))
            // 取出结果
            for checkingRes in res {
                urls.append((str as NSString).substring(with: checkingRes.range))
            }
        }
        catch {
            
        }
        return urls
    }
    
    
    init?(initString: String){
        
        qrcode = initString
        let urls = getUrls(str: initString)
        let resultArr = parseMopedCodeResult(initString)
        
        if urls.count > 0 {
            DDLog(urls)
            if initString.contains("cabId") {
                bikeId = self.getValueFromScanResult(scanResult: initString, key: "cabId")
                bizType = "zb"
                isValid_ = true
            } else if initString.contains("sn") && initString.contains("?") && initString.contains("&") && initString.contains("="){
                bizType = self.getValueFromScanResult(scanResult: initString, key: "biztype")
                cityId = self.getValueFromScanResult(scanResult: initString, key: "citycode")
                let scanName: String = self.getValueFromScanResult(scanResult: initString, key: "sn")
                if bizType == "1" {
                    siteId = scanName.substring(to: (scanName.index((scanName.startIndex), offsetBy: (scanName.count)-3)))
                    parkingId = scanName.substring(from: (scanName.index((scanName.endIndex), offsetBy: -3)))
                } else {
                    bikeId = scanName
                }
                if bizType == "10" && initString.contains("sequence") {
                    bizType = "MSC"
                    siteId = self.getValueFromScanResult(scanResult: initString, key: "sequence")
                }
                if bizType == "MSC" {
                    isValid_ = true
                }else {
                    if bikeId == "" || cityId == "" || bizType == "" {
                        return nil
                    } else {
                        isValid_ = true
                    }
                }
            } else if initString.contains("bikeCode") && initString.contains("=") && initString.contains("?") {
                bikeId = self.getValueFromScanResult(scanResult: initString, key: "bikeCode")
                bizType = "YJ"
                if bikeId == "" {
                    return nil
                } else {
                    isValid_ = true
                }
            } else if initString.contains("?") && initString.contains("=") && initString.contains("jiqi_code") {
                bizType = "10"
                bikeId = self.getValueFromScanResult(scanResult: initString, key: "jiqi_code")
                if bikeId == "" {
                    return nil
                } else {
                    isValid_ = true
                }
            }
            
        } else if resultArr.count > 0 {
        
            bikeId = resultArr[2]
            parkingId = resultArr[1]
            siteId = resultArr[0]
            datetime = resultArr[3]
            bizType = "ZLC"
            isValid_ = true
        } else {
            if String.isEmpty(initString) || initString.trim().count != 11{
                return nil
            }

            cityId = Int.init(initString[ initString.startIndex..<initString.index(initString.startIndex, offsetBy: 4)], radix: 36).toString()!
            
            siteId = Int.init(initString[initString.index(initString.startIndex, offsetBy: 4) ..< initString.index(initString.startIndex, offsetBy: 8)], radix: 36).toString()!
            
            parkingId = Int.init(initString[initString.index(initString.startIndex, offsetBy: 8) ..< initString.index(initString.startIndex, offsetBy: 10)], radix: 36).toString()!
            
            if String.isEmpty(cityId) || String.isEmpty(siteId) || String.isEmpty(parkingId){
               
                return nil
            }
            bizType = "1"
           
            isValid_ = true
        }

    }
}
