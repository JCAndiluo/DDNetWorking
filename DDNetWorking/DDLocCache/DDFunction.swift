//
//  DDFunction.swift
//  DDFuntion
//
//  Created by Ice on 2018/4/24.
//  Copyright © 2018年 Ice. All rights reserved.
//

import Foundation
import PromiseKit
import CoreLocation

public func DDLog<T>(_ message: T, file: String = #file, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    #endif
}

@MainActor 
public class DDFunction: NSObject {
    let ddbase = DDBaseFuntion()
    public override init() {
        super.init()
    }
     //二维码解析
    public func handelTheResult(_ metadataObjectString: String) -> Promise<DDBikeQRCode>{
        return ddbase.handelTheResult(metadataObjectString)
    }
    

    
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - phoneNumber: 手机号
    ///   - channel: 1 为短信验证码 2 语音
    ///   - appId: 发送渠道id
    ///   - getVCodeResoult: 获取结果
    public func getVcode( _ phoneNumber:String, _ channel:String, appId: String) -> Promise<ITReturnInfo> {
        return ddbase.getVcode(phoneNumber, channel, appId: appId)
    }
    
    //获取城市信息
    public func getLocInfo(_ coordinate: String, serviceId: String = "") -> Promise<BizlocRetGetServiceInfo> {
        return ddbase.getLocInfo(coordinate, serviceId: serviceId)
    }
    
    //故障上报
    ///
    ///
    /// - Parameters:
    ///   - type: 21 车辆故障
    ///   - serId: 城市Id
    ///   - title: 标题
    ///   - content: 内容
    ///   - media1: 图片
    ///   - media2: 图片
    ///   - media3: 图片
    /// - Returns:
    public  func uploadInf(type:String,serId:String,title:String,content:String,media1:String,media2:String,media3:String, faultPart: String, faultDetail: String, bikeType: String = "") ->Promise<ITReturnInfo>{
        return ddbase.uploadInf(type: type, serId: serId, title: title, content: content, media1: media1, media2: media2, media3: media3, faultPart: faultPart,faultDetail: faultDetail, bikeType: bikeType)
    }
    


    
    /// 数据存储
    ///
    /// - Parameters:
    ///   - object: 存储对象
    ///   - filename: 文件名
    /// - Returns:
    public func saveDataLoc(_ object: NSObject, _ filename : String) -> Bool {
        return DDLocCacheUtils.saveData(object, filename)
    }
    
    
    
    /// 读取文件
    ///
    /// - Parameters:
    ///   - filename: 文件名
    ///   - className: 类名（项目名.类名）
    /// - Returns:
    public func readData(_ filename: String , _ className: String) -> NSObject? {
        return DDLocCacheUtils.readData(filename, className)
    }
    
    
    /// 删除数据
    ///
    /// - Parameter filename: 文件名
    /// - Returns:
    public func deleteData(_ filename: String)-> Bool {
        return DDLocCacheUtils.deleteData(filename)
    }
    
    /// 附近站点
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - coordinate: 经纬度
    ///   - serviceId: 服务ID
    /// - Returns:
    public func queryNearStation(type: String, coordinate: CLLocationCoordinate2D, serviceId: String, range: String) -> Promise<[BikeStation]>{
        return ddbase.queryNearStation(type: type, coordinate: coordinate, serviceId: serviceId, range: range)
    }
    
    /// 搜索站点
    ///
    /// - Parameters:
    ///   - serviceId: 服务ID
    ///   - keyword: 关键词
    /// - Returns:
    public func searchStation(keyword: String, serviceId: String) -> Promise<[BikecaRetQueryDevicesDetail]> {
        return ddbase.searchStation(serviceId: serviceId, keyword: keyword)
    }
    
    //获取APP信息
    public func getSystemInfo() -> Promise<retSysInfo> {
        return ddbase.getSystemInfo()
    }
    
    
    /// 获取当前城市费率
    ///
    /// - Parameter serviceId: 服务ID
    /// - Returns: 
    public func getCurrentCityMoneyList(serviceId: String) -> Promise<[BikecaPriceRecord]> {
        return ddbase.getCurrentCityRateInformationList(serviceId:serviceId)
    }
    
    public func sercretM(content: String) -> String {
        return ddbase.sercrutyMf(content: content)
    }
    
    //获取协议状态
    public func getProtocolStatus() -> Promise<(Bool,Bool,Bool, Bool, String)> {
        return ddbase.getProtocolStatus()
    }
}
