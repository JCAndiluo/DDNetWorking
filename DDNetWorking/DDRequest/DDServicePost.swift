//
//  DDServicePost.swift
//  DDBlueBikeManagerBuild
//
//  Created by Ice on 2018/4/16.
//  Copyright © 2018年 Ice. All rights reserved.
//

@MainActor var kSecureKey = "e1780b101e0e075c"
let kAccessTokenKey = "AccessToken"           // 登录成功后的accessToken，所有接口访问都需要使用

let kCurrentAppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
@MainActor public var kIsTest = false          //测试标识  2018-9-19 jc add

struct UserDefaultKeys {
    
    static let timeout = 10.0
    static let userTokenKey = "com.7itop.ebike.UserToken"
    static let userVodeTokenKey = "com.7itop.ebike.UserVodeToken"
    static let mtmQueue = "com.7itop.ebike.MTManagerQueue"
    static let logoutKeyWord = "/clientlogout"
    
}

import PromiseKit
import Foundation
import Alamofire

//MARK: 服务接口管理器(Singleton) ============================================================================
@MainActor
open class MTManager {
    let queue = DispatchQueue(label: UserDefaultKeys.mtmQueue, attributes: DispatchQueue.Attributes.concurrent)

    fileprivate let factory = MtWebAPIContext()
    fileprivate var started = false
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }

    static fileprivate var mtm:MTManager = MTManager()
    class func getInstance() -> MTManager{ return mtm }

    fileprivate func processPrepare(_ requestMapping:String,message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>

        promise = processRequest(requestMapping, message)
        return promise
    }

    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{

         message.printAllProList(kRootUrl + requestMapping+" 入参")
        return Promise{ seal in
            https()
            Alamofire.request(
                kRootUrl + requestMapping,
                method: .post,
                parameters: [:],
                encoding: ITWebAPIBodyEncoding(body : message)
                ).response(queue:queue,completionHandler: { (respon) in
                    let data = respon.data
                    let error = respon.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }

    func https(){

        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)

        }
    }
}

//MARK: uum服务
//SystemCenter   系统服务接口
//UserCenter     用户服务接口
@MainActor
class BikeUum {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){}
    fileprivate var started = false
    static fileprivate var uum:BikeUum = BikeUum()
    class func getInstance() -> BikeUum{ return uum }
    
    fileprivate let factory = UumWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        var promise:Promise<ITWebAPIBody>
        if let accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey) {   // 为了换头像业务
            message.accessToken = accessToken
        }
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        return Promise { seal in
            https()
            Alamofire.request(
                kRootUrl + requestMapping,
                method: .post,
                parameters: [:],
                encoding: ITWebAPIBodyEncoding(body : message)
                ).response(queue:queue,completionHandler: { (respon) in
                    let data = respon.data
                    let error = respon.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    func startup() -> Void{
        if started {
            return
        }
        systemCenter.startup()
        userCenter.startup()
        started = true
    }
    
    lazy var systemCenter = SystemCenter()
    lazy var userCenter = UserCenter()
}

// MARK:SystemCenter  ============================================================================
@MainActor
class SystemCenter{
    
    fileprivate var mtm = MTManager.getInstance()
    fileprivate init(){}
    func startup() -> Void{
    }
    
    /**
     系统基本信息
     - Parameter appid App唯一标识
     */
    func sysinfo() -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikemt/manager/sysinfo"
        
        let postMessage = mtm.factory.createRequestBody(requestMapping) as! postSysInfo
        postMessage.appid = kAppId
        return mtm.processPrepare(requestMapping, message: postMessage)
    }
    //获取城市列表
    func getCitylist() -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikemt/business/citylistinfo"
        
        let postMessage = mtm.factory.createRequestBody(requestMapping) as! MtpostCityListInfo
        postMessage.appid = kAppId
        postMessage.businesstype = "1"
        
        return mtm.processPrepare(requestMapping, message: postMessage)
    }
}


//Mark: 蓝牙服务 ============================================================================
@MainActor
class BikeBht {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var bht:BikeBht = BikeBht()
    class func getInstance() -> BikeBht{ return bht }
    
    fileprivate let factory = BikebhtWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        
    // DDLog("accessToken:"+UserDefaults.standard.string(forKey: kAccessTokenKey)!)
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody> {
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        return Promise { seal in
            https()
            Alamofire.request(
                kRootUrl + requestMapping,
                method: .post,
                parameters: [:],
                encoding: ITWebAPIBodyEncoding(body : message)
                ).response(queue:queue,completionHandler: { (respon) in
                    let data = respon.data
                    let error = respon.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                    
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /**
     蓝牙租车请求
     */
    
    func postBltoothRequest(serviceId:String,deviceId:String,parkNum:String,bizType:String,cityCode:String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikebht/business/bhtrequest"
        let postMessage = factory.createRequestBody(requestMapping) as! BikebhtPostBhtRequest
        postMessage.terminalType = "11"
        postMessage.requestType = "0"
        postMessage.DeviceId = deviceId  //网点编号
        postMessage.parkNum = parkNum
        postMessage.bizType = bizType
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.version = currentVersion
        postMessage.cityCode = cityCode
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     蓝牙租车上报
     */
    func postBltoothUpload(dataType: String, cityCode: String, deviceId: String, deviceType: String, terminalType: String, lockStatus: String, coordinate: String, coordType: String, batteryLevel: String, operId: String, deviceStakeId: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bikebht/device/bhttrip"
        let postMessage = factory.createRequestBody(requestMapping) as! BikebhtPostBHTTrip
        postMessage.dataType = dataType
        postMessage.cityCode = cityCode
        postMessage.deviceId = deviceId
        postMessage.deviceType = deviceType
        postMessage.terminalType = terminalType
        postMessage.lockStatus = lockStatus
        postMessage.coordinate = coordinate
        postMessage.coordType = coordType
        postMessage.batteryLevel = batteryLevel
        postMessage.operId = operId
        postMessage.deviceStakeId = deviceStakeId
        postMessage.version = currentVersion
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     查询周边蓝牙车
     */
    func postNearStataionBht(serviceId: String, lat: String, lon: String, range: String, type: String, stationType: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bikebht/business/bhtquerydevices"
        let postMessage = factory.createRequestBody(requestMapping) as! BikebhtPostBHTQueryDevices
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId //"40"
        postMessage.coordinate = lon + "," + lat
        postMessage.coordType = "2"  // 1是百度   2是高德
        postMessage.range = range
        postMessage.type = type //type 0 所有 4 蓝牙 8 cp2
        postMessage.stationType = stationType
        
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取蓝牙信息二维码获取方式
    func postBhtLockInfo(serviceId: String, qrCode: String, deviceId: String, cityCode: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/bikebht/device/getbhtlockinfo"
        let postMessage = factory.createRequestBody(requestMapping) as! BikebhtPostBhtLockInfo
        postMessage.serviceId = serviceId
        postMessage.qrCode = qrCode
        postMessage.cityCode = cityCode
        postMessage.version = currentVersion
        postMessage.deviceId = ""
        return processPrepare(requestMapping, postMessage)
    }
    
    
    //获取蓝牙
    func postBhtLock(deviceId: String,cityCode: String, deviceType: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/bikebht/device/getbhtlock"
        let postMessage = factory.createRequestBody(requestMapping) as! BikebhtPostBhtDevBasicInfo
        postMessage.deviceId = deviceId
        postMessage.cityCode = cityCode
        postMessage.version = currentVersion
        postMessage.deviceType = deviceType  // 1是百度   2是高德
        return processPrepare(requestMapping, postMessage)
    }
}


//MARK: 运营服务 ============================================================================
@MainActor
class Bikeom {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var bom:Bikeom = Bikeom()
    class func getInstance() -> Bikeom{ return bom }
    
    fileprivate let factory = BizomWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
     
        return Promise{ seal in
            
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /*
     type  活动类型
     appid 应用id
     serid 服务id
     title 标题
     content 活动内容
     media1 图片1
     media2 图片2
     media3 图片3
     */
    //创建活动
    func postCreateAcitvity(type:String,serId:String,title:String,content:String,media1:String,media2:String,media3:String, faultPart: String, faultDetail: String, bikeType: String = "") -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bizom/activity/createActivity"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostCreateAcitvity
        postMessage.type = type
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.content = content
        postMessage.title = title
        postMessage.faultPart = faultPart
        postMessage.faultDetail = faultDetail
        postMessage.bikeType = bikeType
        postMessage.media1 = media1
        postMessage.media2 = media2
        postMessage.media3 = media3
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     type 活动类型
     appid 应用id
     serid 服务id
     title 标题
     start 起始数
     limit 限制条数
     */
    
    func postGetActivities(type:String,serId:String,title:String,start:Int = 0,limit:Int = 10) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bizom/activity/getActivities"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetActivities
        postMessage.type = type
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.title = title
        postMessage.start = String(start)
        postMessage.limit = String(limit)
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     获取阿里云的Key
     appid 应用id
     serid 服务id
     */
    func posGetOssAccessKey(serId: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bizom/oss/getOssAccessKey"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostAccessKey
        postMessage.appId = kAppId
        postMessage.serId = serId
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取公告
    func posGetNotices(serId: String, start:Int = 0,limit:Int = 10, virStatus:String, openChannel:String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bizom/activity/getNotices"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetNotices
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.start = String(start)
        postMessage.limit = String(limit)
        postMessage.virStatus = virStatus
        postMessage.openChannel = openChannel
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取妙趣馆游戏链接
    func posGetJoyList(serId: String, start:Int = 0, limit:Int = 10, type: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bizom/games/getGamesLists"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetGamesLists
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.start = String(start)
        postMessage.limit = String(limit)
        postMessage.type = type
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取3秒开机广告
    func postGetAppAds(serId: String, type: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bizom/activity/getAPPAds"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetAPPAdss
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.type = type
        DDLog("参数"+type)
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取故障上报历史
    func postGetUserActivities(type:String,serId:String,title:String,start:Int = 0,limit:Int = 10) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bizom/activity/getUserActivities"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetUserActivities
        postMessage.type = type
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.title = title
        postMessage.start = String(start)
        postMessage.limit = String(limit)
        return processPrepare(requestMapping, postMessage)
    }
    
    //举报
    func reportHand(type: String, serId: String, title: String, content: String, lonlat: String, media1: String = "", media2: String = "", media3: String = "") -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bizom/activity/createActivity"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostCreateAcitvity
        postMessage.type = type
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.title = title
        postMessage.content = content
        postMessage.lonLat = lonlat
        postMessage.media1 = media1
        postMessage.media2 = media2
        postMessage.media3 = media3
        return processPrepare(requestMapping, postMessage)
    }
    
    //首页浮条动态广告
    func postGetDynamicAds(serId: String, start: String, limit: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bizom/activity/getDynamicAds"
        let postMessage = factory.createRequestBody(requestMapping) as! BizomPostGetDynamicAds
        postMessage.appId = kAppId
        postMessage.serId = serId
        postMessage.start = start
        postMessage.limit = limit
        return processPrepare(requestMapping, postMessage)
    }
}

//MARK: 支付服务 ============================================================================
@MainActor
class Bizpay {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:Bizpay = Bizpay()
    class func getInstance() -> Bizpay{ return pay }
    
    fileprivate let factory = BizpayWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        NSLog(requesturl)
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /**
     获取订单支付凭证 pay
     - Parameter serviceInfo 服务
     - Parameter orderId 订单ID
     - Parameter channel 支付渠道 wx=微信,alipay=支付宝,bfb=百度支付,jdpay_wap=京东支付,upacp=银联支付
     */
    func postOrderChargeCa(orderId:String,channel:String, appChannel: String,money:String,couponId:String = "")-> Promise<ITWebAPIBody>{
        let requestMapping = "/bizpay/payment/getCharge"
        let postMessage = factory.createRequestBody(requestMapping) as! BizpayPostGetCharge
        postMessage.orderId = orderId
        postMessage.channel = channel
        postMessage.money = money
        postMessage.couponId = couponId
        postMessage.appChannel = appChannel
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     订单状态查询 列表 pay ca
     - Parameter serviceInfo 服务
     - Parameter orderType 订单类型 1=开通租车,2=租车超时,3=退款
     - Parameter orderStatus 订单状态 1=新建,2=已提交,3=已完成,4=已取消
     - Parameter start 记录开始位置
     - Parameter limit 记录数
     */
    func postQueryOrdersCa(orderType:String?,orderStatus:String?,start:Int=0,limit:Int=10) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bizpay/payment/getOrders"
        let postMessage = factory.createRequestBody(requestMapping) as! BizpayPostGetOrders
        postMessage.orderStatus = orderStatus
        postMessage.ordertype = orderType       //订单
        postMessage.start = String(start)
        postMessage.limit = String(limit)
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     * 金额查询
     */
    func postQueryMoney(orderId:String?) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bizpay/payment/getOrder"
        let postMessage = factory.createRequestBody(requestMapping) as! BizpayPostGetOrder
        postMessage.orderId = orderId
        return processPrepare(requestMapping, postMessage)
    }
}


//MARK :N2 服务 ============================================================================
@MainActor
class BikeIot {
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var Iot:BikeIot = BikeIot()
    class func getInstance() -> BikeIot{ return Iot }
    
    fileprivate let factory = IotcaWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody> {
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping     // "http://101.37.202.111:7080"
        NSLog(requesturl)
        return Promise { seal in
            
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                   responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    //Iotca租车请求
    func postIotcaBikeRequest(serviceId:String,deviceId:String, requestType: String ,parkNum:String,bizType:String,cityCode:String, deviceStakeId:String , coordinate: String, coordType: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/iotca/business/hirerequest"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostIotHireRequest
        postMessage.terminalType = "11"  //叮嗒type 类型 9为武汉测试
        postMessage.requestType = "0"
        postMessage.DeviceId = deviceId  //网点编号
        postMessage.parkNum = parkNum
        postMessage.bizType = bizType
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.requestType = requestType
        postMessage.cityCode = cityCode
        postMessage.deviceStakeId = deviceStakeId
        postMessage.coordinate = coordinate
        postMessage.coordType = coordType
        postMessage.version = kCurrentAppVersion
        return processPrepare(requestMapping, postMessage)
        
    }
    
    //Iotca周边站点
    func postQureyDevicesIotca(serviceId: String, lat: String, lon: String, range: String, type: String, keyword: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/iotca/business/querydevices"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostQueryIotDevices
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId //"40"
        postMessage.coordinate = lon + "," + lat
        postMessage.coordType = "2"   // 1是百度   2是高德
        postMessage.range = range
        postMessage.type = type
        postMessage.keyword = keyword
        
        return processPrepare(requestMapping, postMessage)
    }
    
    //Iotca数据上送
    func postIotCaUpload(dataType: String, cityCode: String, deviceId: String, deviceType: String, terminalType: String, lockStatus: String, coordinate: String, coordType: String, batteryLevel: String, operId: String, deviceStakeId: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/iotca/business/iottrip"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostIotTrip
        postMessage.dataType = dataType
        postMessage.deviceId = deviceId
        postMessage.deviceType = deviceType
        postMessage.lockStatus = lockStatus
        postMessage.coordinate = coordinate
        postMessage.coordType = coordType
        postMessage.batteryLevel = batteryLevel
        postMessage.deviceStakeId = deviceStakeId
        let time = String(Int(Date.init().timeIntervalSince1970)*1000)
        postMessage.DataTime = time
        DDLog("datatime==========="+time)
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询N3锁开关锁密码
    func postGetLockPwd(deviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/iotca/business/getLockPwd"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostGetLockPwd
        postMessage.deviceId = deviceId
        postMessage.devType = "5"
        return processPrepare(requestMapping, postMessage)
    }
    //还车请求   暂时没有用到
//    func postRestoreIotCaRequest(deviceId: String, deviceType: String, lockStatus: String, bizExtra: String, DataTime: String) -> Promise<ITWebAPIBody> {
//
//        let requestMapping = "/iotca/business/restorerequest"
//        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostIotRestoreRequest
//        postMessage.deviceId = deviceId
//        postMessage.deviceType = deviceType
//        postMessage.lockStatus = lockStatus
//        postMessage.bizExtra = bizExtra
//        postMessage.DataTime = DataTime
//
//        return processPrepare(requestMapping, postMessage)
//
//    }
    
    //开锁请求  暂时没有用到
//    func postIotcaUnLockRequest(deviceId: String, cmdTime: String) -> Promise<ITWebAPIBody> {
//
//        let requestMapping = "/iotca/business/unlock"
//        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostIotUnlock
//        postMessage.deviceId = deviceId
//        postMessage.cmdTime = cmdTime
//
//        return processPrepare(requestMapping, postMessage)
//    }
    
    //站点车辆
    func postIotCurrentAmount( deviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/iotca/business/currentAmount"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostCurrentAmount
        postMessage.deviceId = deviceId
        
        return processPrepare(requestMapping, postMessage)
    }
    
    //故障检测
    func postRentBikeFault( bikeId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/iotca/business/rentBikeFault"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostRentBikeFault
        postMessage.bikeId = bikeId
        return processPrepare(requestMapping, postMessage)
    }
    
    //开头盔锁
    func openHelmetLock( tripId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/iotca/business/openHelmetLock"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostOpenHelmetLock
        postMessage.tripId = tripId
        return processPrepare(requestMapping, postMessage)
    }
    
    //叮嗒助力车还车
    func appReturnBike( bikeId: String, operationId: String, lat: String, lng: String, angle: String, lngLatList: String, checkDispatchFee: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/iotca/business/appReturnBike"
        let postMessage = factory.createRequestBody(requestMapping) as! IotcaPostAppReturnBike
        postMessage.bikeId = bikeId
        postMessage.coordinateType = "2"
        postMessage.operationId = operationId
        postMessage.lat = lat
        postMessage.lng = lng
        postMessage.angle = angle
        postMessage.handleType = "multi"
        postMessage.lngLatList = lngLatList
        if checkDispatchFee.count > 0 {
            postMessage.checkDispatchFee = checkDispatchFee
        }
        return processPrepare(requestMapping, postMessage)
    }
    
}


//MARK: 电动助力车服务 ============================================================================
@MainActor
class MopedCa {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var moped:MopedCa = MopedCa()
    class func getInstance() -> MopedCa{ return moped }
    
    fileprivate let factory = MopedcaWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody> {
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        NSLog(requesturl)
        return Promise{ seal in
            
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /*
     * 电动助力车租车请求
     */
    func postMopedRequest(serviceId: String, requestType: String, siteNum: String, parkNum: String, deviceId: String, dateTime: String, cityCode: String, bizType: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/mopedca/business/request"
        let postMessage = factory.createRequestBody(requestMapping) as! MopedcaPostMopedRequest
        postMessage.serviceId = serviceId
        postMessage.requestType = requestType
        postMessage.siteNum = siteNum
        postMessage.parkNum = parkNum
        postMessage.deviceId = deviceId
        postMessage.dateTime = dateTime
        postMessage.cityCode = cityCode
        postMessage.bizType = bizType
        postMessage.terminalType = "11"
        postMessage.appId = kAppId
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     * 电动助力车周边网点请求
     */
    func postMopedQuertDevicesReuqest(serviceId: String, keyword: String, coordinate: String, range: String, type: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/mopedca/business/querydevices"
        let postMessage = factory.createRequestBody(requestMapping) as! MopedcaPostQueryMopedDevices
        postMessage.serviceId = serviceId
        postMessage.keyword = keyword
        postMessage.coordinate = coordinate
        postMessage.range = range
        postMessage.type = type
        postMessage.appId = kAppId
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     * 助力车设备状态查询
     */
    func postMopedGetdevicestatus(serviceId: String, deviceId: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/mopedca/business/getdevicestatus"
        let postMessage = factory.createRequestBody(requestMapping) as! MopedcaPostGetMopedStatus
        postMessage.serviceId = serviceId
        postMessage.deviceId = deviceId
        postMessage.type = "4"
        postMessage.appId = kAppId
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     * 助力车租车状态检查
     */
    func postMopedCheckRequest(serviceId: String, siteNum: String, parkNum: String, bizType: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/mopedca/business/checkRequest"
        let postMessage = factory.createRequestBody(requestMapping) as! MopedcaPostCheckRequest
        postMessage.serviceId = serviceId
        postMessage.siteNum = siteNum
        postMessage.parkNum = parkNum
        postMessage.bizType = bizType
        postMessage.appId = kAppId
        return processPrepare(requestMapping, postMessage)
    }
}

//MARK: 优惠券服务  ============================================================================
@MainActor
class BikeCou {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var cou:BikeCou = BikeCou()
    class func getInstance() -> BikeCou{ return cou }
    
    fileprivate let factory = BizcoupWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise { seal in
            
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
         }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    // 查询优惠券业务
    func postQueryCoupons(couponType: String, cycleType: String, orderType: String, beginindex: Int=0, retcount: Int=10, couponClass: String = "1") -> Promise<ITWebAPIBody> {
        let requestMapping = "/coupon/business/percouponlist"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostPerCouponList
        postMessage.couponType = couponType
        postMessage.cycleType = cycleType
        postMessage.orderType = orderType
        postMessage.beginindex = String(beginindex)
        postMessage.retcount = String(retcount)
        postMessage.couponClass = couponClass
        return processPrepare(requestMapping, postMessage)
    }
    
    /*
     * 使用优惠券
     */
    func postUseCoupons(id: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/coupon/business/updateCoupStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUpdateCoupStatus
        postMessage.id = id
        return processPrepare(requestMapping, postMessage)
    }
    /**
     *  分享获得一次抽奖机会
     * channel:获得机会的渠道   分享为0,骑行为1
     */
    func postUserOtherChance(channel: String, type: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/coupon/activity/userOtherChance"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUserOtherChance
        postMessage.channl = channel
        postMessage.activityType = type
        return processPrepare(requestMapping, postMessage)
    }
    //领取红包
    func postRedPacket() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/business/hzActivity"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostHzActivity
        
        return processPrepare(requestMapping, postMessage)
    }
    
    ///查询用户钱包
    func postQueryUserWallet(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/wallet/queryUserWallet"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostQueryUserWallet
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    /// 钱包套餐列表  返回钱包基本套餐
    func postQueryWalletConfigList(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/wallet/queryWalletConfigList"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostQueryWalletConfigList
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    ///查询用户钱包充值记录列表
    func postGetWalletBuyRecord(beginindex: String, retcount: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/wallet/getWalletBuyRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostGetWalletBuyRecord
        postMessage.beginindex = beginindex
        postMessage.retcount = retcount
        return processPrepare(requestMapping, postMessage)
    }
    
    ///查询用户钱包消费记录列表
    func postUserWalletConsumeRecord(beginindex: String, retcount: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/wallet/userWalletConsumeRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUserWalletConsumeRecord
        postMessage.beginindex = beginindex
        postMessage.retcount = retcount
        return processPrepare(requestMapping, postMessage)
    }
    
    //签到
    func postUserSign(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/sign/signForDD"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostSignForDD
        postMessage.serviceId = serviceId
        postMessage.signId = "10001"
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取签到记录
    func postUserSignInfo() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/sign/getSignListAndStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostSignListAndStatus
        postMessage.signId = "10001"
        return processPrepare(requestMapping, postMessage)
    }
    
    //个人红包查询
    func postUserRedpac(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/userRedpac"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUserRedpac
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    //个人红包获取记录列表
    func postGetRedpacObtainRecord(beginindex: String, retcount: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/getRedpacObtainRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostGetRedpacObtainRecord
        postMessage.beginindex = beginindex
        postMessage.retcount = retcount
        return processPrepare(requestMapping, postMessage)
    }
    
    //个人红包使用记录列表
    func postUseRedpacRecord(beginindex: String, retcount: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/useRedpacRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUseRedpacRecord
        postMessage.beginindex = beginindex
        postMessage.retcount = retcount
        return processPrepare(requestMapping, postMessage)
    }
    
    //红包转入余额
    func postShiftToBanlance(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/shiftToBanlance"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostShiftToBanlance
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    //红包提现
    func postRedpacWithdraw(serviceId: String, money: String, withdrawAccount: String, userName: String,accountFalg: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/redpacWithdraw"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostRedpacWithdraw
        postMessage.serviceId = serviceId
        postMessage.money = money
        postMessage.withdrawAccount = withdrawAccount
        postMessage.userName = userName
        postMessage.accountFalg = accountFalg
        return processPrepare(requestMapping, postMessage)
    }
    
    //红包领取
    func postReceiveRedpac(serviceId: String, obtainChannel: String, redpacPerc: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/redpac/receiveRedpac"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostReceiveRedpac
        postMessage.serviceId = serviceId
        postMessage.obtainChannel = obtainChannel
        postMessage.redpacPerc = redpacPerc
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询等级列表
    func postGetMemberLevel() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/points/getMemberLevel"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostMemberLevel
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询用户等级和积分
    func postGetMemberPoints() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/points/getMemberPoints"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostMemberPoints
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询积分增减记录
    func postGetMemberPointsRecord(addOrSubtract: String,start: String, limit: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/points/getMemberPointsRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostMemberPointsRecord
        postMessage.addOrSubtract = addOrSubtract
        postMessage.start = start
        postMessage.limit = limit
        return processPrepare(requestMapping, postMessage)
    }
    
    //年卡剩余时间
    func postQueryYearCardDaysRemaining() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/business/queryYearCardDaysRemaining"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostQueryYearCardDaysRemaining
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询年卡详情列表
    func postGetYearCardDetailList(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/purchase/getYearCardDetailList"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostGetYearCardDetailList
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询用户年卡购买记录列表
    func postGetUserBuyYearCardList(start: String, limit: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/purchase/getUserBuyYearCardList"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostGetUserBuyYearCardList
        postMessage.beginindex = start
        postMessage.retcount = limit
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询用户年卡状态
    func postQueryUserYearCardStatus() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/purchase/queryUserYearCardStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostUserYearCardStatus
        return processPrepare(requestMapping, postMessage)
    }
    
    //悦时积分免登地址获取
    func postGetYueShiUrl(redirect: String, vip: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/points/yueshi/getURL"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostYueshiGetURLRecord
        postMessage.redirect = redirect
        postMessage.vip = vip
        return processPrepare(requestMapping, postMessage)
    }
    
    //用户登陆送券
    func postLoginSendCoup(serviceId: String, sendType: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/activity/loginSendCoup"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostLoginSendCoup
        postMessage.serviceId = serviceId
        postMessage.loginType = "1"
        postMessage.sendType = sendType
        return processPrepare(requestMapping, postMessage)
    }
    
    //兑换码兑换
    func postQueryExchangeCoupon(serviceId: String, command: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/coupon/wallet/exchangeCoupon"
        let postMessage = factory.createRequestBody(requestMapping) as! BizcoupPostExchangeCoupon
        postMessage.serviceId = serviceId
        postMessage.command = command
        postMessage.channel = "1"
        return processPrepare(requestMapping, postMessage)
    }
}

//MARK: ca 服务 开通租车业务  ============================================================================
@MainActor
class Bikeca {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var ca:Bikeca = Bikeca()
    class func getInstance() -> Bikeca{ return ca }
    
    fileprivate let factory = BikecaWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
          }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /**
     获取BizInfo
     */
    func postBizInfoCa(serviceId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/bizinfo"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostBizinfo
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     开通租车业务
     - Parameter serviceInfo    服务
     - bizType 1:自行车业务 2:便民充电业务
     */
    func postEnabletradeCa(serviceId:String,biztype:String = "1", certMode: String = "" , certParams: String = "") -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/enabletrade"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostEnableTrade
        postMessage.bizType = "1" //
        postMessage.serviceId = serviceId //40
        postMessage.appId = kAppId
        postMessage.certMode = certMode
        postMessage.certParams = certParams
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     注销租车业务
     - Parameter serviceInfo    服务
     */
    func postDisabletradeCa(serviceId:String, refReason:String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/disabletrade"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostDisableTrade
        postMessage.bizType = "1"
        postMessage.serviceId = serviceId
        postMessage.refReason = refReason
        postMessage.appId = kAppId
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     检查订单状态 ca
     - Parameter serviceInfo 服务
     - Parameter orderId 订单ID
     */
    func postCheckOrderCa(orderId:String, serviceId: String, coupUsedId:String="", coupId:String="", finalPayMoney:String="", coupType:String="")-> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/checkOrderStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostCheckOrderStatus
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.orderId = orderId
        postMessage.coupUsedId = coupUsedId
        postMessage.coupId = coupId
        postMessage.finalPayMoney = finalPayMoney
        postMessage.coupType = coupType
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     租车请求 ca
     - Parameter serviceInfo    服务
     - Parameter terminalType   终端类型 1:支付宝 2:微信 3:APP
     - Parameter requestType    请求类型 0:正常 2:续租 3:异常
     - Parameter DeviceId     网点编号  siteNumber
     - Parameter parkNumber     车位编号
     - Parameter bizType        租车类型 0:全部 1:有桩 2: 无桩
     */
    func postRentalRequestCa(serviceId:String,deviceId:String,parkNum:String,bizType:String,cityCode:String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/request"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostRequest
        postMessage.terminalType = "11"  //叮嗒type 类型 9为武汉测试
        postMessage.requestType = "0"
        postMessage.DeviceId = deviceId  //网点编号
        postMessage.parkNum = parkNum
        postMessage.bizType = bizType
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.cityCode = cityCode
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     租车记录查询 ca
     - Parameter serviceInfo 服务
     - Parameter orderId 订单ID
     */
    func postRentalRecordersCa(start:Int=0,limit:Int=10,startTime:Date?,endTime:Date?)-> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/pertrips"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostPerTripRecords
        postMessage.beginindex = String(start)
        postMessage.retcount = String(limit)
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     周边网点查询 ca
     - Parameter serviceInfo 服务
     - Parameter lat 搜索起始点纬度 30
     - Parameter lon 搜索起始点经度 114
     - Parameter range 搜索起范围
     - Parameter type 0:所有 1:有桩站 2:GPRS锁车 3:智能锁车  默认为0
     */
    func postNearStataionCa(serviceId: String, lat: String, lon: String, range: String, type: String, keyword: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/querydevices"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostQueryDevices
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.coordinate = lon + "," + lat
        postMessage.coordType = "2"  // 1是百度   2是高德
        postMessage.range = range
        postMessage.type = type
        postMessage.keyword = keyword
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     网点查询 ca
     - Parameter serviceInfo 服务
     - Parameter name   网点名称或网点编号
     */
    func postQueryStationCa(serviceId:String,name:String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/querydevices"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostQueryDevices
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.keyword = name
        postMessage.coordType = "2"   // 1是百度   2是高德
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     查询服务信息 获取我的押金金额 ca
     - Parameter serviceInfo 服务
     - serviceId   服务id
     - bizType    业务类型1：自行车 2:便民充电
     */
    func postUserBusinessQueryServiceInfo(serviceId:String,bizType:String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/business/serviceInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostServiceinfo
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId //"40"
        postMessage.bizType = bizType
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取站点详情
    func postDevicestatus(serviceId:String, deviceId:String, type:String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/business/getdevicestatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetDeviceStatus
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.deviceId = deviceId
        postMessage.type = type
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取续租列表
    func postUserreletPriceList(serviceId:String, bikeType: String, userId: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bikeca/business/reletPriceList"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostReletPriceList
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.bikeType = bikeType
        postMessage.userId = userId
        return processPrepare(requestMapping, postMessage)
    }
    
    //续租请求
    func postTripContinueRent(tripId: String, reletPrice: String, reletHour: String, bikeType: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bikeca/business/insertReletRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostInsertReletRecord
        postMessage.tripId = tripId
        postMessage.reletPrice = reletPrice
        postMessage.bikeType = bikeType
        postMessage.reletHour = reletHour
        return processPrepare(requestMapping, postMessage)
    }
    
    //身份证数据上传check
    func checkCertifyStatus(channelType: String,serviceId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/checkCertifyStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostCheckCertifyStatus
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.channelType = channelType
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     * 获取当前城市费率信息列表
     * serviceId   服务id
     * Parameter appid App 唯一标识
     */
    func getCurrentCityRateInformationList(serviceId: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/bikeca/business/getPriceList"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetPriceList
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     * 获取出行总数
     * tripTotalNum 出行总数
     * rideRange 骑行总数
     */
    func getTripOverView(serviceId: String) -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bikeca/business/tripOverView"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostTripOverView
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }

    // 取消退款
    func cancleRefund() -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bikeca/business/revokeRefund"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostRevokeRefund
        return processPrepare(requestMapping, postMessage)
    }
    
    /**
     * 退款进度查询
     */
    func getQueryProgress() -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bikeca/business/queryProgress"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostQueryProgress
        return processPrepare(requestMapping, postMessage)
    }
    
    //月卡可购买列表
    func postRetShoudBuyMCList(serviceId: String, grade: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/card/getCardDetailList"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetCardDetailList
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.grade = grade
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询月卡剩余天数
    func postRetDaysRemaining(grade: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/card/queryCardDaysRemaining"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostQueryCardDaysRemainingd
        postMessage.grade = grade
        return processPrepare(requestMapping, postMessage)
    }
    
    //生成月卡/钱包订单
    func postCreateCardOrederId(serviceId: String, cardId: String, walletConfigId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/card/userBuyCard"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostUserBuyCard
        postMessage.cardId = cardId
        postMessage.serviceId = serviceId
        postMessage.walletConfigId = walletConfigId
        postMessage.appId = kAppId
        return processPrepare(requestMapping, postMessage)
    }
    
    //月卡记录
    func getUserBuyCardList(beiginindex: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/card/getUserBuyCardList"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetUserBuyCardList
        postMessage.beginindex = beiginindex
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取体验状态信息
    func getInvitationInfo() -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/extra/getInvitationInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetInvitationInfo
        return processPrepare(requestMapping, postMessage)
    }
    
    //亲密账户绑定
    func postIntimateBind( reqType: String, intimatePhone: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/extra/intimateBind"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostIntimateBind
        postMessage.reqType = reqType
        postMessage.intimatePhone = intimatePhone
        return processPrepare(requestMapping, postMessage)
    }
    
    //执行体验
    func postInviteCode(vcode: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/extra/inviteExpr"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostInviteExpr
        postMessage.inviteCode = vcode
        postMessage.inviteType = "3"
        return processPrepare(requestMapping, postMessage)
    }
    
    // 获取全部费率接口
    func postCommonConfigList(serId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/bikeca/config/getCommonConfigList"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetCommonConfigList
        postMessage.appId = kAppId
        postMessage.serviceId = serId
        return processPrepare(requestMapping, postMessage)
    }
    
    //check云Pos
    func postCheckPosOrderStatsu(type: String = "9",orderId: String,serviceId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/checkCloudPosOrderStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostCheckCloudPosOrderStatus
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.orderId = orderId
        postMessage.type = type
        return processPrepare(requestMapping, postMessage)
    }
    
    ///使用钱包支付超时费、月卡、云pos、移动联名卡（叮嗒卡）、IC卡绑卡等费用
    func postUseWalletForBusiness(orderId: String,serviceId: String,usedChannel: String, coupUsedId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/bikeca/business/useWalletForBusiness"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostUseWalletForBusiness
        postMessage.orderId = orderId
        postMessage.serviceId = serviceId
        postMessage.usedChannel = usedChannel
        postMessage.coupUsedId = coupUsedId
        return processPrepare(requestMapping, postMessage)
    }
    
    ///购买月卡等的时候  检查订单状态信息 APP支付完毕,则调用；或者在APP弹出的支付异常提示框中,用户点击已支付,APP对订单状态的检查
    func postCheckBuyOrderStatus(orderId: String,serviceId: String,type: String, cardId: String, walletConfigId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/bikeca/business/checkBuyOrderStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostCheckBuyOrderStatus
        postMessage.appId = kAppId
        postMessage.orderId = orderId
        postMessage.serviceId = serviceId
        postMessage.type = type
        postMessage.cardId = cardId
        postMessage.walletConfigId = walletConfigId
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取拓展业务协议状态
    func postQueryOtherBiz() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/business/getBizAgree"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetBizAgree
        return processPrepare(requestMapping, postMessage)
    }
    
    //同意业务协议
    func postAgree(bizType: String, pamrams: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/business/openBizAgree"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostOpenBizAgree
        postMessage.bizType = bizType
        postMessage.version = currentVersion
        postMessage.terminalType = "11"
        postMessage.pamrams = pamrams
        return processPrepare(requestMapping, postMessage)
    }
    
    //根据id获取行程
    func postGetTripInfo(tripId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/business/getTripInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostGetTripInfo
        postMessage.tripId = tripId
        return processPrepare(requestMapping, postMessage)
    }
    
    //检查年卡订单状态
    func postCheckYearCardOrder(yearCardId: String, serviceId: String, orderId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/purchase/checkYearCardOrder"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostCheckYearCardOrder
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.orderId = orderId
        postMessage.yearCardId = yearCardId
        return processPrepare(requestMapping, postMessage)
    }
    
    //检查用户有无剩余月卡
    func postQueryUserCard() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/card/queryUserCard"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostQueryUserCard
        return processPrepare(requestMapping, postMessage)
    }
    
    // 实名认证免押
    func postRealNameFreeBet(serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/bikeca/business/realNameFreeBet"
        let postMessage = factory.createRequestBody(requestMapping) as! BikecaPostRealNameFreeBet
        postMessage.serviceId = serviceId
        return processPrepare(requestMapping, postMessage)
    }
}

//MARK: 定位服务  ============================================================================
@MainActor
class LocalInfo {
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:LocalInfo = LocalInfo()
    class func getInstance() -> LocalInfo{ return pay }
    
    fileprivate let factory = BizlocWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
          }
    }
    
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    /**
     获取定位服务
     **/
    func postLocalInfo(_ coordinate: String, _ coordType: String, _ serviceId: String = "") -> Promise<ITWebAPIBody> {
        
        let requestMapping = "/bizloc/service/getServiceInfo"
        
        let postMessage = BizlocWebAPIContext().createRequestBody(requestMapping) as! BizlocPostGetServiceInfo
        postMessage.coordinate = coordinate
        postMessage.coordType = coordType
        postMessage.serviceId = serviceId
        postMessage.type = ""
        return processPrepare(requestMapping, postMessage)
    }
}

// MARK:UserCenter 用户中心  ============================================================================
@MainActor
class UserCenter {

    fileprivate var uum = BikeUum.getInstance()
    var localUserPhone:String? { get { return currentUserToken?.userName } }
    var localUserId:String? { get { return currentUserToken?.userId } }
    var localUsetToken:String? {get { return currentUserToken?.token }}
    fileprivate var currentUserToken: UserToken?
    fileprivate init(){}

    func startup() -> Void{
        currentUserToken = UserToken.VcodetokenObtainFromUserDefault()
    }

    //  获取验证码和登录的post方法

    // 获取验证码
    func postGetVcode(_ phoneNumber: String, _ channel: String, appId: String) -> Promise<ITWebAPIBody>{

        let requestMapping = "/uum/security/getVcode"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostGetVcode
        postMessage.appId = appId
        postMessage.phoneNO = phoneNumber
        postMessage.channel = channel
        return uum.processPrepare(requestMapping, postMessage)

    }

    // 用验证码登录
    func postVCodeLogin(_ loginName: String, _ vcode: String, _ userToken: String) -> Promise<ITWebAPIBody> {

        let requestMapping = "/uum/security/vcodeLogin"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostVCodeLogin
        postMessage.loginName = loginName
        postMessage.vcode = vcode
        postMessage.userToken = userToken
        postMessage.registerChannel = "02"
        return uum.processPrepare(requestMapping, postMessage)
    }

    // 更换用户头像
    func postChangeAvatar(avatarURL: String) -> Promise<ITWebAPIBody> {

        let requestMapping = "/uum/member/updateAvatar"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostUpdateAvatar
        postMessage.avatarURL = avatarURL
        return uum.processPrepare(requestMapping, postMessage)

    }

    /*
     * 第三方登陆是否已绑定
     * bindId  第三方账号唯一标识
     * thirdBindType  第三方登陆类型
     * requestType 请求类型 1：登录页面 2: 主页面
     **/
    func postIsThirdBind(bindId: String, thirdBindType: String, requestType: String, memberPhone: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/uum/member/isThirdBind"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostIsThirdBind
        postMessage.bindId = bindId
        postMessage.thirdBindType = thirdBindType
        postMessage.requestType = requestType
        postMessage.memberPhone = memberPhone
        return uum.processPrepare(requestMapping, postMessage)
    }

    /*
     * 第三方登陆解绑与绑定
     * memberPhone  用户手机号
     * thirdBindType  第三方登陆类型
     * bindId 绑定Id
     * switchType 1绑定 2解绑
     **/

    func postThirdSwitchBind(memberPhone: String, thirdBindType: String, bindId: String, switchType: String, loginId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/uum/member/ThirdSwitchBind"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostThirdSwitchBind
        postMessage.memberPhone = memberPhone
        postMessage.thirdBindType = thirdBindType
        postMessage.bindId = bindId
        postMessage.switchType = switchType
        postMessage.loginId = loginId
        return uum.processPrepare(requestMapping, postMessage)
    }

    /*
     * 第三方登陆绑定
     * memberName  第三方用户昵称
     * avatarURL  第三方用户头像
     * bindId  第三方账号唯一标识
     * thirdBindType  第三方绑定类型  微信:wx
     * userPhone   用户手机号
     * vcode  验证码
     **/
    func postThirdBindLogin(memberName: String, avatarURL: String, bindId: String, thirdBindType: String, userPhone: String, vcode: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/uum/security/thirdBindLogin"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostThirdBindLogin
        postMessage.memberName = memberName
        postMessage.avatarURL = avatarURL
        postMessage.bindId = bindId
        postMessage.thirdBindType = thirdBindType
        postMessage.userPhone = userPhone
        postMessage.vcode = vcode
        return uum.processPrepare(requestMapping, postMessage)
    }
    
    func postGetMemberInfo() -> Promise<ITWebAPIBody> {
        let requestMapping = "/uum/member/getMemberInfo"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostGetMemberInfo
        return uum.processPrepare(requestMapping, postMessage)
    }
    
    func postUpdateMemberInfo(nickName: String, avatarURL: String, memberAlias: String, memberSex: String, memberBirthday: String, memberIndustry: String, memberTags: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/uum/member/updateMemberInfo"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostUpdateMemberInfo
        postMessage.nickName = nickName
        postMessage.avatarURL = avatarURL
        postMessage.memberAlias = memberAlias
        postMessage.memberSex = memberSex
        postMessage.memberBirthday = memberBirthday
        postMessage.memberIndustry = memberIndustry
        postMessage.memberTags = memberTags
        return uum.processPrepare(requestMapping, postMessage)
    }

    //退出
    func postLogout() {
        self.currentUserToken = nil
    }
    
    //用户登录日志记录
    func postMemLoginLog(phonemodel: String, phoneVersion: String, appVersion: String, ipAdd: String, serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/uum/security/memLoginLog"
        let postMessage = uum.factory.createRequestBody(requestMapping) as! UumPostMemLoginLog
        postMessage.terminaltype = "2"
        postMessage.phoneFirm = "苹果"
        postMessage.phonemodel = phonemodel
        postMessage.phoneVersion = phoneVersion
        postMessage.appVersion = appVersion
        postMessage.ipAdd = ipAdd
        postMessage.serviceId = serviceId
        return uum.processPrepare(requestMapping, postMessage)
    }
}

//MARK: 公交云POS服务 ============================================================================
@MainActor
class CloidPosServer {
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:CloidPosServer = CloidPosServer()
    class func getInstance() -> CloidPosServer{ return pay }
    
    fileprivate let factory = CloudposWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
          }
    }
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    //请求支付二维码
    func requestQRCode(serviceId: String,QRCodeType: String = "1")-> Promise<ITWebAPIBody>{
        let requestMapping = "/cloudpos/business/qrcoderequest"
        let postMessage = factory.createRequestBody(requestMapping) as! CloudposPostQRCodeRequest
        postMessage.appId = kAppId
        postMessage.QRCodeType = QRCodeType
        postMessage.serviceId = serviceId
        
        return processPrepare(requestMapping, postMessage)
    }
    
    //同意公交协议
    func agreeRquest()-> Promise<ITWebAPIBody>{
        let requestMapping = "/cloudpos/business/agree"
        let postMessage = factory.createRequestBody(requestMapping) as! CloudposPostAgree
        postMessage.agree = "1"
        return processPrepare(requestMapping, postMessage)
    }
}

//MARK: 用户认证服务 ============================================================================
@MainActor
class Certification{
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:Certification = Certification()
    class func getInstance() -> Certification{ return pay }
    
    fileprivate let factory = CertifyWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
          }
    }
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    //提交身份认证
    func postCertification(serviceId: String, userId: String, realName: String, phoneNo: String, idCard: String, params: String, channel: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/certification/user/certify"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostCertify
        postMessage.appId = kAppId
        postMessage.phoneNo = phoneNo
        postMessage.serviceId = serviceId
        postMessage.userId = userId
        postMessage.realName = realName
        postMessage.idCard = idCard
        postMessage.params = params
        postMessage.channel = channel
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取用户认证信息、叮嗒卡信息
    func postCerInformation(serviceId: String, channel: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/certification/user/getCertInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostGetCertInfo
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.channel = channel
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询认证状态
    func postCheckCerStatus(channel: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/certification/user/isCertified"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostIsCertified
        postMessage.channel = channel
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询白名单状态
    func postCheckMobileCard(channel: String) -> Promise<ITWebAPIBody>{
        
        let requestMapping = "/certification/user/whiteListStatus"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostWhiteListStatus
        postMessage.channel = channel
        return processPrepare(requestMapping, postMessage)
    }
    
    //查询城市租车IC卡绑定费率
    func postListCertConfig(serId:String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/certification/config/listCertConfig"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostListCertConfig
        postMessage.appId = kAppId
        postMessage.serviceId = serId
        return processPrepare(requestMapping, postMessage)
    }
    
    //苏宁贷授权信息接口
    func postSuningAuthorizedlogin() -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/certification/user/authorizedlogin"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostAuthorizedlogin
        return processPrepare(requestMapping, postMessage)
    }
    
    //护照认证
    func passport(serviceId: String, userId: String, passport: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/certification/user/passport"
        let postMessage = factory.createRequestBody(requestMapping) as! CertifyPostPassport
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.userId = userId
        postMessage.passport = passport
        return processPrepare(requestMapping, postMessage)
    }
}

@MainActor
class ThirdPartService{
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:ThirdPartService = ThirdPartService()
    class func getInstance() -> ThirdPartService{ return pay }
    
    fileprivate let factory = ThirdpartyWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    //永久租、还、临时、继续车 验证
    func hirebike(serviceId: String,DeviceId: String, qR: String, electricity: String, cityCode: String, biztype: String, hireStationName: String, rentflag: String, deviceStakeId: String, coordinate: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/hirerequest"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostThirdPartyHireRequest
        postMessage.appId = kAppId
        postMessage.hireType = "yj"
        postMessage.serviceId = serviceId
        postMessage.terminalType = "11"
        postMessage.DeviceId = DeviceId
        postMessage.qR = qR
        postMessage.electricity = electricity
        postMessage.cityCode = cityCode
        postMessage.bizType = biztype
        postMessage.rentflag = rentflag
        postMessage.deviceStakeId = deviceStakeId
        postMessage.hireStationName = hireStationName
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        return processPrepare(requestMapping, postMessage)
    }
    
    //还车关锁请求
    func restoreBike(deviceId: String, cityCode: String, deviceType: String, lockStatus: String, coordinate: String, electricity: String, rentflag: String, deviceStakeId: String, restoreStationName: String, flag: String, operId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/thirdparty/business/restorerequest"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostThirdPartyTrip
        postMessage.deviceId = deviceId
        postMessage.cityCode = cityCode
        postMessage.deviceType = deviceType
        postMessage.lockStatus = lockStatus
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        postMessage.electricity = electricity
        postMessage.deviceStakeId = deviceStakeId
        postMessage.rentflag = rentflag
        postMessage.restoreStationName = restoreStationName
        postMessage.flag = flag
        postMessage.operId = operId
        return processPrepare(requestMapping, postMessage)
    }
    //永久车辆故障还车
    func errorHire(operId: String, deviceId: String, coordinate: String, electricity: String, deviceStakeId: String, restoreStationName: String, failBody: String, failType: String, kindId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/hireerror"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostThirdPartyHireError
        postMessage.operId = operId
        postMessage.deviceId = deviceId
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        postMessage.electricity = electricity
        postMessage.restoreStationName = restoreStationName
        postMessage.failBody = failBody
        postMessage.failType = failType
        postMessage.kindId = kindId
        return processPrepare(requestMapping, postMessage)
    }
    //永久附近站点
    func postNearStations(serviceId: String, coordinate: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/getStations"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostGetStations
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        return processPrepare(requestMapping, postMessage)
    }
    
    //永久行车区域
    func postDriveSpace(cityCode: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/businessScopes"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostGetScopes
        postMessage.cityCode = cityCode
        return processPrepare(requestMapping, postMessage)
    }
    
    //new 永久行车区域
    func postBusinessScopesNew(cityCode: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/businessScopesNew"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostGetScopesNew
        postMessage.cityCode = cityCode
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取车辆信息
    func postBikeInfo(bikeCode: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/getBikeInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostGetBike
        postMessage.code = bikeCode
        return processPrepare(requestMapping, postMessage)
    }
    
    //永久骑行轨迹
    func postTrip(operId: String, points: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/tripPath"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostTripPath
        postMessage.operId = operId
        postMessage.points = points
        return processPrepare(requestMapping, postMessage)
    }
    
    //永久周边车辆
    func postNearbike(coordinate: String, serviceId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/thirdparty/business/getBikes"
        let postMessage = factory.createRequestBody(requestMapping) as! ThirdpartyPostGetBikes
        DDLog("参数附近车辆"+coordinate)
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.coordType = "2"
        postMessage.coordinate = coordinate
        return processPrepare(requestMapping, postMessage)
    }
    
}
@MainActor 
class MscService{
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var pay:MscService = MscService()
    class func getInstance() -> MscService{ return pay }
    
    fileprivate let factory = MscWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        DDLog("错误码---"+String(errorr.code))
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    //获取用户码上充业务信息
    func posMscBizInfo(serviceId: String)->Promise<ITWebAPIBody> {
        let requestMapping = "/api/msc/business/getMscBizInfo"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostMscBizInfo
        postMessage.appId = kAppId
        postMessage.serviceId = serviceId
        postMessage.version = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //周边MSC网点
    func postNearStation(coordinate: String, range: String = "1000", serviceId: String, keyword: String = "") -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/queryMscDevices"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostQueryMscDevices
        postMessage.serviceId = serviceId
        postMessage.keyword = keyword
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        postMessage.range = range
        postMessage.version = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //new 周边MSC网点
    func postNewNearStation(coordinate: String, range: String = "1000", serviceId: String, keyword: String = "") -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/queryMscStation"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostQueryMscStation
        postMessage.serviceId = serviceId
        postMessage.keyword = keyword
        postMessage.coordinate = coordinate
        postMessage.coordType = "2"
        postMessage.range = range
        postMessage.version = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //msc站点详情
    func postStationDetailed(serviceId: String, stationId: String) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/stationDetailed"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostStationDetailed
        postMessage.serviceId = serviceId
        postMessage.stationId = stationId
        return processPrepare(requestMapping, postMessage)
    }
    
    //MSC检查订单
    func postCheckMscOrder(serviceId: String, orderId: String, isNew: Bool) -> Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/checkMscOrder"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostCheckMscOrder
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.type = "11"
        postMessage.orderId = orderId
        postMessage.version = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        if isNew {
            postMessage.isNew = "1"
        }
        return processPrepare(requestMapping, postMessage)
    }
    
    //MSC租电请求 new
    func postNewRequestRent(serviceId: String, deviceId: String, priceConfigId: String, portId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/msc/business/requestRent"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostRequestRent
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.deviceId = deviceId
        postMessage.priceConfigId = priceConfigId
        postMessage.version = currentVersion
        postMessage.portId = portId
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //MSC租电请求 old
    func postRequestRent(serviceId: String, deviceId: String, priceConfigId: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/msc/business/requestCharge"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostRequestCharge
        postMessage.serviceId = serviceId
        postMessage.appId = kAppId
        postMessage.deviceId = deviceId
        postMessage.priceConfigId = priceConfigId
        postMessage.version = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取MSC记录
    func postMscRecord(start: String, limit: String)->Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/getChargeRecord"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostGetChargeRecord
        postMessage.version = currentVersion
        postMessage.start = start
        postMessage.limit = limit
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        return processPrepare(requestMapping, postMessage)
    }
    
    //获取选租时间列表
    func postMSCRentList(serviceId: String, deviceId: String, isNew: Bool)->Promise<ITWebAPIBody> {
        let requestMapping = "/api/msc/business/getMscPriceConfig"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostMscPriceConfig
        postMessage.serviceId = serviceId
        postMessage.version = currentVersion
        postMessage.deviceId = deviceId
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "11"
        if isNew {
             postMessage.isNew = "1"
        }
        return processPrepare(requestMapping, postMessage)
    }
    
    //MSC钱包check
    func postUseWalletPay(orderId: String, usedChannel: String, serviceId: String, isNew: Bool)->Promise<ITWebAPIBody>{
        let requestMapping = "/api/msc/business/useWalletPay"
        let postMessage = factory.createRequestBody(requestMapping) as! MscPostUseWalletPay
        postMessage.orderId = orderId
        postMessage.usedChannel = usedChannel
        postMessage.serviceId = serviceId
        postMessage.appversion = currentVersion
        DDLog("app版本"+currentVersion)
        postMessage.terminalType = "2"
        if isNew {
            postMessage.isNew = "1"
        }
        return processPrepare(requestMapping, postMessage)
    }
    
}
@MainActor 
class DingdaWeb{
    
    let queue = DispatchQueue(label: "com.7itop.ebike.Bikeom", attributes: DispatchQueue.Attributes.concurrent)
    fileprivate init(){
        _ = factory.setSecureKey(ITAESSecureKey(kSecureKey))
    }
    static fileprivate var ding:DingdaWeb = DingdaWeb()
    class func getInstance() -> DingdaWeb{ return ding }
    
    fileprivate let factory = DingdWebAPIContext()
    
    fileprivate func processPrepare(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        var promise:Promise<ITWebAPIBody>
        message.accessToken = UserDefaults.standard.string(forKey: kAccessTokenKey)
        promise = processRequest(requestMapping, message)
        return promise
    }
    
    fileprivate func processRequest(_ requestMapping:String, _ message:ITWebAPIBody) -> Promise<ITWebAPIBody>{
        
        message.printAllProList(kRootUrl + requestMapping+" 入参")
        let requesturl = kRootUrl + requestMapping
        return Promise{ seal in
            https()
            Alamofire.request(
                requesturl,
                method: .post,
                parameters: [:],
                encoding:ITWebAPIBodyEncoding(body:message)
                )
                .response(queue: queue, completionHandler: { (resopnse) -> Void in
                    let data = resopnse.data
                    let error = resopnse.error
                    var responseMessage:ITWebAPIBody
                    if error == nil {
                        responseMessage = self.factory.createResponseBody(requestMapping,content: String(data: data!, encoding: String.Encoding.utf8))
                        
                    } else {
                        responseMessage = self.factory.createResponseBody(requestMapping)
                        responseMessage.retcode = Err.REQUEST_ERR
                        responseMessage.retmsg = error.toString()!
                        
                        let errorr = error! as NSError //获取网络请求失败码 超时 断网 code
                        switch errorr.code {
                        case -1009:
                            responseMessage.retcode = Err.NotConnectedToInternet
                            responseMessage.retmsg = "断网啦！请检查网络设置"
                            break
                        case -1001:
                            responseMessage.retmsg = "请求超时！请再次尝试"
                            break
                        default:
                            break
                        }
                    }
                    responseMessage.printAllProList(kRootUrl + requestMapping+" 出参")
                    seal.fulfill(responseMessage)
                })
        }
    }
    func https(){
        
        //认证相关设置
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            return (.useCredential, credential)
        }
    }
    
    func postNewRedpacWd(serviceId: String, money: String, withdrawAccount: String, userName: String,accountFalg: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/dingd/redpac/redpacWdraw"
        let postMessage = factory.createRequestBody(requestMapping) as! DingdPostRedpacWdraw
        postMessage.serviceId = serviceId
        postMessage.money = money
        postMessage.withdrawAccount = withdrawAccount
        postMessage.userName = userName
        postMessage.accountFalg = accountFalg
        return processPrepare(requestMapping, postMessage)
    }
    
    func postNewUserRecCoupon(serviceId: String, couponType: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/dingd/business/newUserRecCoupon"
        let postMessage = factory.createRequestBody(requestMapping) as! DingdPostNewUserRecCoupon
        postMessage.serviceId = serviceId
        postMessage.couponType = couponType
        return processPrepare(requestMapping, postMessage)
    }
    
    //用户购买年卡获取orderid
    func postUserBuyYearCard(yearCardId: String, serviceId: String, walletConfigId:String, bizType: String) -> Promise<ITWebAPIBody> {
        let requestMapping = "/api/dingd/purchase/userBuyYearCard"
        let postMessage = factory.createRequestBody(requestMapping) as! DingdPostUserBuyYearCard
        postMessage.appId = kAppId
        postMessage.yearCardId = yearCardId
        postMessage.serviceId = serviceId
        postMessage.bizType = bizType
        postMessage.terminalType = "11"
        postMessage.walletConfigId = walletConfigId
        return processPrepare(requestMapping, postMessage)
    }
}

@MainActor
class UserToken {
    
    var userId:String
    var userName:String
    var token :String
    var tokenSaveTime : String
    
    init(userId:String,loginname:String,token:String,tokenSaveTime:String){
        self.userId = userId
        self.userName = loginname
        self.token = token
        
        self.tokenSaveTime = tokenSaveTime
    }
    
    class func VcodetokenObtainFromUserDefault() -> UserToken?{
        if let array = UserDefaults.standard.object(forKey: UserDefaultKeys.userVodeTokenKey) as? [String]{
            if array.count == 3 {
                return UserToken(userId: "u0000****", loginname: array[0], token:  array[1], tokenSaveTime:  array[2])
            } else if array.count == 4{
                return UserToken(userId:array[0],loginname: array[1],token: array[2],tokenSaveTime:array[3])
            }
        }
        return nil
    }
    
    func VcodetokenSaveToUserDefault() -> UserToken{
        UserDefaults.standard.set([self.userId,self.userName,self.token,self.tokenSaveTime], forKey: UserDefaultKeys.userVodeTokenKey)
        return self
    }
}


// MARK:ITWebAPIBodyEncoding ============================================================================
@MainActor
class ITWebAPIBodyEncoding:@preconcurrency ParameterEncoding {

    let body:ITWebAPIBody
    init(body:ITWebAPIBody,clientId:String? = nil) {
        self.body = body
        if(clientId != nil){
            self.body.clientid = clientId
        }
    }

    func encode(_ urlRequest: Alamofire.URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlrequest = urlRequest.urlRequest!
        urlrequest.allHTTPHeaderFields = ["Content-Type":"text/xml"]
        urlrequest.timeoutInterval = UserDefaultKeys.timeout
        urlrequest.httpBody = self.body.encode()?.data(using: String.Encoding.utf8)
        return urlrequest
    }
}

@MainActor 
extension ITWebAPIBody {
    func printAllProList(_ map: String) {
        if !kIsTest {
            return
        }
        print("\n")
        DDLog(map+"====")
        let morror = Mirror.init(reflecting: self)
        for (name, value) in (morror.children) {
            print("属性:\(String(describing: name)) 值: \(value)")
        }
        print("\n")
    }
}
