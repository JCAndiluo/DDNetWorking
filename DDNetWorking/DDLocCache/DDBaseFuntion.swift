////
////  DDBaseFuntion.swift
////  DDBlueBikeManagerBuild
////
////  Created by Ice on 2018/4/18.
////  Copyright © 2018年 Ice. All rights reserved.
////
//
import Foundation
import PromiseKit
import CoreLocation
//

let kSerInfoData = "ServiceInfoData"
@MainActor 
class DDBaseFuntion: NSObject {
    let sver = RetResultManager.shareInstance()
    //二维码解析
    func handelTheResult(_ metadataObjectString: String) -> Promise<DDBikeQRCode>{
        return Promise{ seal in
            let qrcodeResult = DDBikeQRCode.init(initString: metadataObjectString)
            if qrcodeResult?.isValid_ == true {
                seal.fulfill(qrcodeResult!)
            } else {
                seal.reject(Err.get("030", detial: "扫描的二维码不正确"))
            }
        }
        
        
    }

    //
    /// 获取验证码
    ///
    /// - Parameters:
    ///   - phoneNumber: 手机号
    ///   - channel: 1 为短信验证码 2 语音
    ///   - getVCodeResoult: 获取结果
    func getVcode( _ phoneNumber:String, _ channel:String, appId: String) -> Promise<ITReturnInfo>{
        return Promise{ seal in
            
            sver.getVCode(phoneNumber, channel,  appId: appId).done { (result) in
                if result.retcode == "0" {
                    seal.fulfill(Err.get("0", detial: "获取成功"))
                }else{
                    seal.reject(Err.get(result.retcode, detial: result.retmsg))
                }
                }.catch { (error) in
                    seal.reject(error as! ITReturnInfo)
            }
        }
        
    }

    //获取城市信息
    func getLocInfo(_ coordinate: String, serviceId: String = "") -> Promise<BizlocRetGetServiceInfo>{
        return Promise{ seal in
            
            sver.queryLocalInfo(coordinate, "2", serviceId).done({ (locinfo) in
                if locinfo.retcode == "0" {
                    _ =  DDLocCacheUtils.saveData(locinfo, kSerInfoData)
                    seal.fulfill(locinfo)
                }else {
                    if DDLocCacheUtils.readData(kSerInfoData, "BizlocRetGetServiceInfo") != nil {
                        let serinfo = DDLocCacheUtils.readData(kSerInfoData, "BizlocRetGetServiceInfo") as! BizlocRetGetServiceInfo
                        seal.fulfill(serinfo)
                    } else {
                        seal.reject(Err.get(locinfo.retcode, detial: locinfo.retmsg))
                    }
                }
            }).catch({ (error) in
                let err = error as! ITReturnInfo
                seal.reject(Err.get(err.retCode, detial: err.retMsg))
            })
        }
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
    func uploadInf(type:String,serId:String,title:String,content:String,media1:String,media2:String,media3:String, faultPart: String, faultDetail: String , bikeType: String = "") ->Promise<ITReturnInfo>{
        return Promise{ seal in
           
            sver.createActivity(type: type, serid: serId, title: title, content: content, media1: media1, media2: media2, media3: media3, faultPart: faultPart, faultDetail: faultDetail, bikeType: bikeType).done({ (result) in
                if result.retcode == "0" {
                    seal.fulfill(Err.get("0", detial: "上报成功"))
                } else {
                    seal.reject(Err.get(result.retcode, detial: result.retmsg))
                }
            }).catch({ (error) in
                seal.reject(error as! ITReturnInfo)
            })
        }
    }

//    //图片上传
//    func uploadImageinfo(data: [Data], serviceId: String)->Promise<[String]>{
//        return Promise{ seal in
//            var urls = [String]()
//            if data.count == 0 {
//                seal.fulfill(urls)
//            }
//            sver.getAccessKey(serId: serviceId).done({ (retAccesskey) in
//                if retAccesskey.retcode == "0"{
//              
//                    let clien = DDOSSTool.OSSconfigClient(endpoint: retAccesskey.endPoint!, plainTextAccessKey: retAccesskey.accessKeyID!, secretKey: retAccesskey.accessKeySecret!)
//                    for i in 0..<data.count {
//                        DDOSSTool.OSSupload(clien: clien, bucketName: retAccesskey.bucketName!, objcetKey: DDOSSTool.getObjcetKey(), data: data[i] as Data, complete: { (url, isSuccess) in
//                            DDLog(clien)
//                            if isSuccess {
//                                DDLog("上传成功")
//                                urls.append(url)
//                                if urls.count == data.count {
//                                    seal.fulfill(urls)
//                                }
//                            } else {
//                                 DDLog("上传失败")
//                            }
//                        })
//                    }
//                   
//                } else {
//                    DDLog("获取getAccessKey错误"+retAccesskey.retmsg!+retAccesskey.retcode!)
//                    seal.reject(Err.get(retAccesskey.retcode, detial: retAccesskey.retmsg))
//                }
//            }).catch({ (error) in
//                
//                let err = error as! ITReturnInfo
//                DDLog("获取rror错误"+err.retCode+err.detail!+"--"+err.retMsg)
//                seal.reject(Err.get(err.retCode, detial: "上传失败"))
//            })
//        }
//    }
    
    
    /// 附近站点
    ///
    /// - Parameters:
    ///   - type: 类型
    ///   - coordinate: 经纬度
    ///   - serviceId: 服务ID
    /// - Returns: 
    func queryNearStation(type: String, coordinate: CLLocationCoordinate2D, serviceId: String, range: String) -> Promise<[BikeStation]> {
        if serviceId != "120" && serviceId != "241" && serviceId != "263" {
            return Promise<[BikeStation]>.init(error: Err.get("当前城市未开通服务", detial: ""))
        }
            if type == "1" {
                return getNearStationCa(coordinate: coordinate, serviceId: serviceId, range: range)
            } else if type == "2" {
                return getNearStationBht(coordinate: coordinate, serviceId: serviceId, range: range, stationType: "0")
            }else if type == "3" {
                return getNearStationBht(coordinate: coordinate, serviceId: serviceId, range: range, stationType: "1")
            } else if type == "MSC"{
                return queryNearStaion(coordinate: coordinate, range: range, serviceId: serviceId)
            } else{
                return Promise<[BikeStation]>.init(error: Err.get("type类型错误", detial: ""))
        }
    }
    
    /// 搜索站点
    ///
    /// - Parameters:
    ///   - serviceId: 服务ID
    ///   - keyword: 关键词
    /// - Returns:
    func searchStation(serviceId: String, keyword: String) -> Promise<[BikecaRetQueryDevicesDetail]> {
        return Promise{ seal in
            sver.queryStationsCa(name: keyword, serviceid: serviceId).done({ (stationArray) in
                seal.fulfill(stationArray)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }

    
    //获取有桩附近站点信息
    func getNearStationCa(coordinate: CLLocationCoordinate2D, serviceId: String, range: String, keyword: String = "") -> Promise<[BikeStation]>{
        return Promise{ seal in
            let lat =  String.init(format: "%f", coordinate.latitude)
            let lon = String.init(format: "%f", coordinate.longitude)
            sver.queryNearStationsCa(lat: lat, lon: lon, range: range, type: "1", serviceid: serviceId, keyword: keyword).done({ (deviceArray) in
                
                var result = [BikeStation]()
                for data in deviceArray {
                    let coordinateArr = data.coordinate?.components(separatedBy: ",")
                    
                    var mylat = ""
                    var mylon = ""
                    if (coordinateArr?.count)! > 1 {
                        mylat = (coordinateArr?[1])!
                        mylon = (coordinateArr?[0])!
                    }
                    
                    let bikeStation = BikeStation(
                        name: data.deviceName.toString()!,
                        number:data.deviceId.toString()!,
                        lat:mylat,
                        lon:mylon
                    )
                    bikeStation.deviceId = data.deviceId
                    bikeStation.deviceName = data.deviceName
                    bikeStation.address = data.address
                    bikeStation.status = data.status
                    bikeStation.updatetime = data.updatetime
                    bikeStation.totalCount = data.totalcount
                    bikeStation.rentCount = data.rentcount
                    bikeStation.restoreCount = data.restorecount
                    bikeStation.type = data.type
                    bikeStation.coordinateCa = data.coordinate
                    bikeStation.redpacPileFlag = data.redpacPileFlag
                    result.append(bikeStation)
                }
                seal.fulfill(result)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    //获取无桩站点
    func getNearStationBht(coordinate: CLLocationCoordinate2D, serviceId: String, range: String, stationType: String = "") -> Promise<[BikeStation]> {
        return Promise{ seal in
            let lat =  String.init(format: "%f", coordinate.latitude)
            let lon = String.init(format: "%f", coordinate.longitude)
            sver.queryNearStationsBht(lat: lat, lon: lon, range: range, type: "0", serviceid: serviceId, stationType: stationType).done({ (resultDevices) in
                var result = [BikeStation]()
                for data in resultDevices.getBikebhtRetBHTQueryDevicesDetail() {
                    
                    let coordinateArr = data.coordinate?.components(separatedBy: ",")
                    
                    var mylat = ""
                    var mylon = ""
                    if (coordinateArr?.count)! > 1 {
                        mylat = (coordinateArr?[1])!
                        mylon = (coordinateArr?[0])!
                    }
                    
                    let bikeStation = BikeStation(
                        name: data.deviceName.toString()!,
                        number:data.deviceId.toString()!,
                        lat:mylat,
                        lon:mylon
                    )
                    bikeStation.cityCode = data.cityCode
                    bikeStation.deviceId = data.deviceId
                    bikeStation.deviceName = data.deviceName
                    bikeStation.address = data.address
                    bikeStation.status = data.status
                    bikeStation.updatetime = data.updatetime
                    bikeStation.totalCount = data.totalcount
                    bikeStation.rentCount = data.rentcount
                    bikeStation.restoreCount = data.restorecount
                    bikeStation.type = data.type
                    bikeStation.coordinateCa = data.coordinate
                    bikeStation.stationType = data.stationType
                    result.append(bikeStation)
                }
                seal.fulfill(result)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    // 获取电动助力车
    func getEletricStation(coordinate: CLLocationCoordinate2D, serviceId: String,range: String) -> Promise<[BikeStation]>{
        return Promise{ seal in
            sver.mopedQueryDevicesRequest(serviceId: serviceId, keyword: "", coordinate: String.init(format: "%.f,%.f", coordinate.longitude, coordinate.latitude), range: range, type: "6").done({ (resultArray) in
                var result = [BikeStation]()
                for data in resultArray {
                    
                    let coordinateArr = data.coordinate?.components(separatedBy: ",")
                    
                    var mylat = ""
                    var mylon = ""
                    if (coordinateArr?.count)! > 1 {
                        mylat = (coordinateArr?[1])!
                        mylon = (coordinateArr?[0])!
                    }
                    
                    let bikeStation = BikeStation(
                        name: data.deviceName.toString()!,
                        number:data.deviceId.toString()!,
                        lat:mylat,
                        lon:mylon
                    )
                    bikeStation.deviceId = data.deviceId
                    bikeStation.deviceName = data.deviceName
                    
                    bikeStation.address = data.address
                    bikeStation.status = data.status
                    bikeStation.updatetime = data.updatetime
                    bikeStation.totalCount = data.totalcount
                    bikeStation.rentCount = data.rentcount
                    bikeStation.restoreCount = data.restorecount
                    bikeStation.type = data.type
                    bikeStation.coordinateCa = data.coordinate
                    result.append(bikeStation)
                }
                seal.fulfill(result)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    //码上充站点
    func queryNearStaion(coordinate: CLLocationCoordinate2D, range: String = "1000", serviceId: String) -> Promise<[BikeStation]> {
        return Promise { seal in
            RetResultManager.shareInstance().queryNewNearStations(coordinate: String.init(format: "%f,%f", coordinate.longitude, coordinate.latitude), range: range, serviceId: serviceId).done({ (response) in
                if response.getData().count > 0 {
                    var stationArray = [BikeStation]()
                    for item in response.getData() {
                        let coor = item.coordinate?.components(separatedBy: ",")
                        let station: BikeStation = BikeStation.init(name: item.deviceName!, number: "0", lat: coor![1], lon: coor![0])
                        station.type = "MSC"
                        station.deviceId = item.deviceId
                        station.mscRentCount = item.rentcount
                        stationArray.append(station)
                    }
                    seal.fulfill(stationArray)
                    
                } else {
                    seal.reject(ITReturnInfo.init("801", "附近暂无租电网点"))
                }
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
//    获取app信息
    func getSystemInfo() -> Promise<retSysInfo> {
        return Promise{ seal in
            sver.getAppInfo().done({ (appinfo) in
                seal.fulfill(appinfo)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
 
    func getCurrentCityRateInformationList(serviceId: String) -> Promise<[BikecaPriceRecord]>{
        return Promise{ seal in
            sver.getCurrentCityRateInformationList(serviceId: serviceId).done({ (result) in
                seal.fulfill(result)
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
    
    func sercrutyMf(content: String) -> String {
        var secureKeys = [String:ITSecureKey]()
        secureKeys[ITAESSecureKey(kSecureKey).name] = ITAESSecureKey(kSecureKey)
        return secureKeys["AES"]?.encrypt(original: content) ?? ""
    }
    
    
    ///获取用户协议状态
    
    func getProtocolStatus() -> Promise<(Bool,Bool,Bool, Bool, String)>{
        return Promise { seal in
            RetResultManager.shareInstance().queryBizagree().done({ (response) in
                var mscStatus = false
                var yjStatus = false
                var cpStatus = false
                let rentFlag = response.rentFlag == "true"
                var baseExtra = ""
                if response.baseExtra != "null" && (response.baseExtra?.count)! > 0 {
                    baseExtra = response.baseExtra!
                }
                if response.agreeExtra != "" {
                    DDLog(response.agreeExtra)
                    
                    var string = response.agreeExtra
                    string = string?.replacingOccurrences(of: "\\", with: "")
                    let data = string?.data(using: String.Encoding.utf8)
                    let jsonArr = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    
                    var cp = String(describing: jsonArr["CP"])
                    if cp.contains("Optional(") && cp.contains(")"){
                        cp = cp.replacingOccurrences(of: "Optional(", with: "")
                        cp = cp.replacingOccurrences(of: ")", with: "")
                    }
                    var msc = String(describing: jsonArr["MSC"])
                    if msc.contains("Optional(") && msc.contains(")"){
                        msc = msc.replacingOccurrences(of: "Optional(", with: "")
                        msc = msc.replacingOccurrences(of: ")", with: "")
                    }
                    var yj = String(describing: jsonArr["YJ"])
                    if yj.contains("Optional(") && yj.contains(")"){
                        yj = yj.replacingOccurrences(of: "Optional(", with: "")
                        yj = yj.replacingOccurrences(of: ")", with: "")
                    }
                    if msc.contains("Optional(") && msc.contains(")"){
                        msc = msc.replacingOccurrences(of: "Optional(", with: "")
                        msc = msc.replacingOccurrences(of: ")", with: "")
                    }
                    if msc == "1" {
                        mscStatus = true
                    }
                    if yj == "1" {
                        yjStatus = true
                    }
                    if cp == "1" {
                        cpStatus = true
                    }
                }
                seal.fulfill((mscStatus, yjStatus, cpStatus, rentFlag, baseExtra))
            }).catch({ (error) in
                seal.reject(error)
            })
        }
    }
}
