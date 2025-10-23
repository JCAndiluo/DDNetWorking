//
//  DDServiceRet.swift
//  DDBlueBikeManagerBuild
//
//  Created by Ice on 2018/4/16.
//  Copyright © 2018年 Ice. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
@MainActor public var kRootUrl = "http://load.dingdatech.com:7080"
@MainActor public var kAppId = "mtafb518ecd5651d136"
let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
@MainActor let singleBS = RetResultManager()

@MainActor
open class RetResultManager : NSObject{
    
    
    public class func shareInstance() -> RetResultManager {
        return singleBS
    }
    
    //用户是否登录
    public func isUserLogin() -> Bool {
        return UserDefaults.standard.object(forKey: UserDefaultKeys.userVodeTokenKey) == nil ? false : true
    }
    
    //清除登录信息
    public func userLoginOut() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.userVodeTokenKey)
        UserDefaults.standard.removeObject(forKey: kAccessTokenKey)
    }
    
//MARK: 蓝牙服务 ============================================================================
    /**
     * 蓝牙租车请求
     */
    public func bluetoothRequest(serviceid:String,deviceId:String,parkNum:String,bizType:String,cityCode:String) -> Promise<BikebhtRetBhtRequest>{
        let bht = BikeBht.getInstance()
        return bht.postBltoothRequest(serviceId: serviceid, deviceId: deviceId, parkNum: parkNum, bizType: bizType, cityCode: cityCode).then(on: bht.queue, { (webAPIRetrun) -> Promise<BikebhtRetBhtRequest> in
            if !webAPIRetrun.successful {
                return Promise<BikebhtRetBhtRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikebhtRetBhtRequest
            return Promise<BikebhtRetBhtRequest>.value(body)
        })
    }
    
    /**
     *  蓝牙租车上报
     */
    public func bluetoothUpload(dataType: String, cityCode: String, deviceId: String, deviceType: String = "1", terminalType: String = "11", lockStatus: String, coordinate: String, coordType: String = "2", batteryLevel: String, operId: String, deviceStakeId: String) -> Promise<BikebhtRetBHTTrip> {
        
        let bht = BikeBht.getInstance()
        return bht.postBltoothUpload(dataType: dataType, cityCode: cityCode, deviceId: deviceId, deviceType: deviceType, terminalType: terminalType, lockStatus: lockStatus, coordinate: coordinate, coordType: coordType, batteryLevel: batteryLevel, operId: operId, deviceStakeId: deviceStakeId).then(on: bht.queue, { (webAPIRetrun) -> Promise<BikebhtRetBHTTrip> in
            if !webAPIRetrun.successful {
                return Promise<BikebhtRetBHTTrip>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BikebhtRetBHTTrip
            return Promise<BikebhtRetBHTTrip>.value(body)
        })
    }
    
    /**
     *  查询周边蓝牙车
     */
    public func queryNearStationsBht(lat:String,lon:String,range:String,type:String,serviceid:String, stationType: String = "") -> Promise<BikebhtRetBHTQueryDevices> {
        let bht = BikeBht.getInstance()
        return bht.postNearStataionBht(serviceId: serviceid,lat: lat,lon: lon,range: range,type: type, stationType: stationType).then(on: bht.queue, { (webAPIRetrun) -> Promise<BikebhtRetBHTQueryDevices> in
            if !webAPIRetrun.successful {
                return Promise<BikebhtRetBHTQueryDevices>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikebhtRetBHTQueryDevices
            return Promise<BikebhtRetBHTQueryDevices>.value(body)
        })
    }
    
    /**
     *  通过二维码获取蓝牙信息
     */
    public func queryBhtlockInfo(serviceId: String, qrCode: String, deviceId: String, cityCode: String)->Promise<BikebhtRetBhtLockInfo>{
        let bht = BikeBht.getInstance()
        return bht.postBhtLockInfo(serviceId: serviceId, qrCode: qrCode, deviceId: deviceId, cityCode: cityCode).then(on: bht.queue, { (webAPIRetrun) -> Promise<BikebhtRetBhtLockInfo> in
            if !webAPIRetrun.successful {
                return Promise<BikebhtRetBhtLockInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikebhtRetBhtLockInfo
            return Promise<BikebhtRetBhtLockInfo>.value(body)
        })
    }

//MARK: 运营服务 ============================================================================
    /*
     运营数据 （活动，消息，故障上报）*/
    /*
     创建运营数据（如：故障上报、图片上传等）
     -parameter type  活动类型 appid 应用id serid 服务id title 标题 content 活动内容 media1 图片1 media2 图片2 media3 图片3
     */
    
    public func createActivity(type:String,serid:String,title:String,content:String,media1:String = "",media2:String = "",media3:String = "", faultPart: String = "", faultDetail: String = "", bikeType: String = "") -> Promise<BizomRetCreateAcitvity>{
        let om = Bikeom.getInstance()
        return om.postCreateAcitvity(type: type, serId: serid, title: title, content: content, media1: media1, media2: media2, media3: media3, faultPart: faultPart, faultDetail: faultDetail,bikeType: bikeType).then(on:om.queue, {
            webAPIRetrun -> Promise<BizomRetCreateAcitvity> in
            if !webAPIRetrun.successful {
                return Promise<BizomRetCreateAcitvity>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizomRetCreateAcitvity
            body.actId = body.actId.toString()!
            return Promise<BizomRetCreateAcitvity>.value(body)
        })
    }
    
    /*
     获取运营数据（如：活动、消息等）
     - Parameter type 活动类型 appid 应用id serid 服务id title 标题 start 起始数 limit 限制条数
     */
    public func getActivities(type:String,serid:String,title:String,start:Int,limit:Int) -> Promise<[BizomRetGetActivitiesDetail]>{
        let om = Bikeom.getInstance()
        return om.postGetActivities(type: type,serId: serid, title: title, start: start, limit: limit).then(on:om.queue, {
            webAPIRetrun -> Promise<[BizomRetGetActivitiesDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[BizomRetGetActivitiesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetActivities
            return Promise<[BizomRetGetActivitiesDetail]>.value(body.data)
        })
    }
    
    /*
     * 获取阿里云的key
     */
    public func getAccessKey(serId:String) -> Promise<BizomRetAccessKey>{
        
        let om = Bikeom.getInstance()
        return om.posGetOssAccessKey(serId: serId).then(on: om.queue, {
            webAPIRetrun -> Promise<BizomRetAccessKey> in
            if !webAPIRetrun.successful {
                return Promise<BizomRetAccessKey>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizomRetAccessKey
            return Promise<BizomRetAccessKey>.value(body)
        })
    }
    
    /*
     * 获取公告数据
     */
    public func getNotices(serid:String,start:Int,limit:Int, virStatus:String, openChannel:String) -> Promise<[BizomRetGetNoticesDetail]>{
        let om = Bikeom.getInstance()
        
        return om.posGetNotices(serId: serid, start: start, limit: limit, virStatus: virStatus, openChannel:openChannel).then(on:om.queue, {
            webAPIRetrun -> Promise<[BizomRetGetNoticesDetail]> in
            
            if !webAPIRetrun.successful {
                return Promise<[BizomRetGetNoticesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetNotices
            return Promise<[BizomRetGetNoticesDetail]>.value(body.data)
        })
    }
    
    /*
     * 获取妙趣馆游戏链接
     */
    public func getJoyList(serid:String,start:Int,limit:Int,type:String) -> Promise<[BizomRetGetGames]>{
        let om = Bikeom.getInstance()
        
        return om.posGetJoyList(serId: serid, start: start, limit: limit, type: type).then(on:om.queue, {
            webAPIRetrun -> Promise<[BizomRetGetGames]> in
            
            if !webAPIRetrun.successful {
                return Promise<[BizomRetGetGames]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetGamesLists
            return Promise<[BizomRetGetGames]>.value(body.data)
        })
    }
    
    /*
     * 获取3秒开机广告
     */
    public func getAppAds(serid:String = "", type: String = "51") -> Promise<BizomRetGetAPPAds>{
        let om = Bikeom.getInstance()
        
        return om.postGetAppAds(serId: serid, type: type).then(on:om.queue, {
            webAPIRetrun -> Promise<BizomRetGetAPPAds> in
            
            if !webAPIRetrun.successful {
                return Promise<BizomRetGetAPPAds>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetAPPAds
            return Promise<BizomRetGetAPPAds>.value(body)
        })
    }
    
    /*
     * 获取故障上报历史
     */
    public func getUserActivities(type:String,serid:String,title:String,start:Int,limit:Int) -> Promise<[BizomRetGetUserActivitiesDetail]>{
        let om = Bikeom.getInstance()
        
        return om.postGetUserActivities(type: type,serId: serid, title: title,start: start,limit: limit).then(on:om.queue, {
            webAPIRetrun -> Promise<[BizomRetGetUserActivitiesDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[BizomRetGetUserActivitiesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetUserActivities
            return Promise<[BizomRetGetUserActivitiesDetail]>.value(body.data)
        })
    }
    
    //举报
    public func reportRetInfo(type: String, serId: String, title: String, content: String, lonlat: String, media1: String = "", media2: String = "", media3: String = "") -> Promise<BizomRetCreateAcitvity> {
        let om = Bikeom.getInstance()
        return om.reportHand(type: type, serId: serId, title: title, content: content, lonlat: lonlat, media1: media1, media2: media2, media3: media3).then(on: om.queue, { (webAPIRetrun) -> Promise<BizomRetCreateAcitvity> in
            if !webAPIRetrun.successful {
                return Promise<BizomRetCreateAcitvity>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetCreateAcitvity
            return Promise<BizomRetCreateAcitvity>.value(body)
            
        })
    }
    
    //首页浮条动态广告
    public func getDynamicAds(serId: String, start: String, limit: String) -> Promise<BizomRetGetDynamicAds> {
        if serId.requireParameterIsEmpty(){
            return Promise<BizomRetGetDynamicAds>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let om = Bikeom.getInstance()
        return om.postGetDynamicAds(serId: serId, start: start, limit: limit).then(on: om.queue, { (webAPIRetrun) -> Promise<BizomRetGetDynamicAds> in
            if !webAPIRetrun.successful {
                return Promise<BizomRetGetDynamicAds>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! BizomRetGetDynamicAds
            return Promise<BizomRetGetDynamicAds>.value(body)
            
        })
    }
    
//MARK: 支付服务 ============================================================================
    /**
     获取订单支付凭证 ca
     - Parameter channel 支付渠道 wx=微信,alipay=支付宝,bfb=百度支付,jdpay_wap=京东支付,upacp=银联支付
     */
    public func queryOrderChargeCa(orderId:String, channel:String, appChannel: String, money:String = "",couponId:String="") -> Promise<BizpayRetGetCharge>{
        if orderId.requireParameterIsEmpty(){
            return Promise<BizpayRetGetCharge>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let pay = Bizpay.getInstance()
        return pay.postOrderChargeCa(orderId: orderId,channel:channel, appChannel: appChannel,money:money,couponId: couponId).then(on:pay.queue, {
            webAPIRetrun -> Promise<BizpayRetGetCharge> in
            if !webAPIRetrun.successful {
                return Promise<BizpayRetGetCharge>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizpayRetGetCharge
            body.chargeStatus = body.chargeStatus.toString()!
            body.chargeData = body.chargeData.toString()!
            return Promise<BizpayRetGetCharge>.value(body)
        })
    }
    
    /**
     订单状态查询 ca
     - Parameter orderType 订单类型 1=开通租车,2=租车超时,3=注销租车退款,4=租车超时退款
     - Parameter orderStatus 订单状态 1=新建,2=已提交,3=已完成,4=已取消
     */
    public func queryPayOrdersCa(orderType:String, orderStatus:String,start:Int = 0,limit:Int = 10) -> Promise<[BizpayPayOrderInfo]> {
        let pay = Bizpay.getInstance()
        return pay.postQueryOrdersCa(orderType: orderType, orderStatus: orderStatus,start: start,limit: limit).then(on:pay.queue, {
            webAPIRetrun -> Promise<[BizpayPayOrderInfo]> in
            if !webAPIRetrun.successful {
                return Promise<[BizpayPayOrderInfo]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizpayRetGetOrders
            
            return Promise<[BizpayPayOrderInfo]>.value(body.data)
        })
    }
    
    /*
     * 查询金额
     */
   public func queryMoney(orderId:String) -> Promise<BizpayRetGetOrder> {
    if orderId.requireParameterIsEmpty(){
        return Promise<BizpayRetGetOrder>(error:Err.get("-1",detial: "必传参数为空"))
    }
        let pay = Bizpay.getInstance()
        
        return pay.postQueryMoney(orderId: orderId).then(on:pay.queue, {
            webAPIRetrun -> Promise<BizpayRetGetOrder> in
            
            if !webAPIRetrun.successful {
                return Promise<BizpayRetGetOrder>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizpayRetGetOrder
            return Promise<BizpayRetGetOrder>.value(body)
        })
    }
    
//MARK: N2服务 IOTCA ============================================================================
    
    /*
     * 租车请求
     */
   public func postIotcaBikeRent(serviceId: String, deviceId: String, requestType: String, parkNum: String = "", bizType: String = "51", cityCode: String,deviceStakeId: String = "", coordinate: String = "", coordType: String = "") -> Promise<IotcaRetIotHireRequest> {
        let iotca = BikeIot.getInstance()
        return iotca.postIotcaBikeRequest(serviceId: serviceId, deviceId: deviceId, requestType: requestType, parkNum: parkNum, bizType: bizType, cityCode: cityCode, deviceStakeId: deviceStakeId, coordinate: coordinate, coordType: coordType).then(on: iotca.queue, { webAPIRetrun -> Promise<IotcaRetIotHireRequest> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetIotHireRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetIotHireRequest
            return Promise<IotcaRetIotHireRequest>.value(body)
        })
    }
    
    /*
     * 附近站点
     */
    public func postQueryDeviceIot(serviceId: String, lat: String, lon: String, range: String, type: String, keyword: String = "") -> Promise<[IotcaRetQueryDevicesDetail]> {
        
        let iotca = BikeIot.getInstance()
        
        return iotca.postQureyDevicesIotca(serviceId: serviceId, lat: lat, lon: lon, range: range, type: type, keyword: keyword).then(on: iotca.queue,  { (webAPIRetrun) -> Promise<[IotcaRetQueryDevicesDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[IotcaRetQueryDevicesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetQueryIotDevices
            
            return Promise<[IotcaRetQueryDevicesDetail]>.value(body.data)
        })
    }
    
    /*
     * 数据上送
     */
   public func iotCaUpLoad(dataType: String, cityCode: String, deviceId: String, deviceType: String, terminalType: String, lockStatus: String, coordinate: String, coordType: String, batteryLevel: String, operId: String, deviceStakeId: String) -> Promise<IotcaRetIotTrip> {
        let iotca = BikeIot.getInstance()
        return iotca.postIotCaUpload(dataType: dataType, cityCode: cityCode, deviceId: deviceId, deviceType: deviceType, terminalType: terminalType, lockStatus: lockStatus, coordinate: coordinate, coordType: coordType, batteryLevel: batteryLevel, operId: operId, deviceStakeId: deviceStakeId).then(on: iotca.queue, { (webAPIRetrun) -> Promise<IotcaRetIotTrip> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetIotTrip>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetIotTrip
            
            return Promise<IotcaRetIotTrip>.value(body)
        })
    }
    
    //查询N3锁开关锁密码
    public func getLockPwd(deviceId: String) -> Promise<IotcaRetGetLockPwd> {
        let iotca = BikeIot.getInstance()
        return iotca.postGetLockPwd( deviceId: deviceId).then(on: iotca.queue, { (webAPIRetrun) -> Promise<IotcaRetGetLockPwd> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetGetLockPwd>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetGetLockPwd
            
            return Promise<IotcaRetGetLockPwd>.value(body)
        })
    }
    
    //站点车辆
    public func currentAmount(deviceId: String) -> Promise<IotcaRetCurrentAmount> {
        let iotca = BikeIot.getInstance()
        return iotca.postIotCurrentAmount( deviceId: deviceId).then(on: iotca.queue, { (webAPIRetrun) -> Promise<IotcaRetCurrentAmount> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetCurrentAmount>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetCurrentAmount
            
            return Promise<IotcaRetCurrentAmount>.value(body)
        })
    }
    
    //故障检测
    public func rentBikeFault( bikeId: String) -> Promise<IotcaRetRentBikeFault> {
        let iotca = BikeIot.getInstance()
        return iotca.postRentBikeFault( bikeId: bikeId).then(on: iotca.queue, { (webAPIRetrun) -> Promise<IotcaRetRentBikeFault> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetRentBikeFault>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetRentBikeFault
            
            return Promise<IotcaRetRentBikeFault>.value(body)
        })
    }
    
    
//MARK: 电动助力车服务 ============================================================================
    /*
     * 电动助力车租车请求
     */
   public func mopedRequest(serviceId: String, requestType: String, siteNum: String, parkNum: String, deviceId: String, dateTime: String, cityCode: String, bizType: String) -> Promise<MopedcaRetMopedRequest> {
        
        let moped = MopedCa.getInstance()
        return moped.postMopedRequest(serviceId: serviceId, requestType: requestType, siteNum: siteNum, parkNum: parkNum, deviceId: deviceId, dateTime: dateTime, cityCode: cityCode, bizType: bizType).then(on:moped.queue, { webAPIRetrun -> Promise<MopedcaRetMopedRequest> in
            
            if !webAPIRetrun.successful {
                return Promise<MopedcaRetMopedRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! MopedcaRetMopedRequest
            return Promise<MopedcaRetMopedRequest>.value(body)
        })
    }
    
    /*
     * 电动助力车周边网点请求
     */
   public func mopedQueryDevicesRequest(serviceId: String, keyword: String, coordinate: String, range: String, type: String) -> Promise<[MopedcaRetQueryDevicesDetail]> {
        let moped = MopedCa.getInstance()
        
        return moped.postMopedQuertDevicesReuqest(serviceId: serviceId, keyword: keyword, coordinate: coordinate, range: range, type: type).then(on:moped.queue, { webAPIRetrun -> Promise<[MopedcaRetQueryDevicesDetail]> in
            
            if !webAPIRetrun.successful {
                return Promise<[MopedcaRetQueryDevicesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! MopedcaRetQueryMopedDevices
            return Promise<[MopedcaRetQueryDevicesDetail]>.value(body.data)
        })
    }
    
    /*
     * 助力车设备状态查询
     */
   public func mopedGetdevicestatus(serviceId: String, deviceId: String) -> Promise<MopedcaRetGetMopedStatus> {
        let moped = MopedCa.getInstance()
        
        return moped.postMopedGetdevicestatus(serviceId: serviceId, deviceId: deviceId).then(on:moped.queue, { webAPIRetrun -> Promise<MopedcaRetGetMopedStatus> in
            
            if !webAPIRetrun.successful {
                return Promise<MopedcaRetGetMopedStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MopedcaRetGetMopedStatus
            return Promise<MopedcaRetGetMopedStatus>.value(body)
        })
    }
    
    /*
     * 助力车租车状态检查
     */
   public func mopedCheckRequest(serviceId: String, siteNum: String , parkNum: String, bizType: String) -> Promise<MopedcaRetCheckRequest> {
        let moped = MopedCa.getInstance()
        
        return moped.postMopedCheckRequest(serviceId: serviceId, siteNum:siteNum, parkNum:parkNum, bizType:bizType).then(on:moped.queue, { webAPIRetrun -> Promise<MopedcaRetCheckRequest> in
            
            if !webAPIRetrun.successful {
                return Promise<MopedcaRetCheckRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! MopedcaRetCheckRequest
            return Promise<MopedcaRetCheckRequest>.value(body)
        })
    }
    
    
//MARK: 优惠券服务  ============================================================================
    
    /*
     * 查询优惠券
     */
   public func queryCoupons(couponType: String="", cycleType: String, orderType: String, beginindex: Int=0, retcount: Int=10, couponClass: String = "1") -> Promise<[BizcoupPerCouponRecord]> {
        
        let cou = BikeCou.getInstance()
        return cou.postQueryCoupons(couponType: couponType, cycleType: cycleType, orderType: orderType, beginindex: beginindex, retcount: retcount,couponClass: couponClass).then(on:cou.queue, {
            webAPIRetrun -> Promise<[BizcoupPerCouponRecord]> in
            if !webAPIRetrun.successful {
                return Promise<[BizcoupPerCouponRecord]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetPerCouponList
            return Promise<[BizcoupPerCouponRecord]>.value(body.data)
        })
    }
  
    /*
     * 使用优惠券
     */
   public func userCoupons(id: String) -> Promise<BizcoupRetUpdateCoupStatus> {
    if id.requireParameterIsEmpty(){
        return Promise<BizcoupRetUpdateCoupStatus>(error:Err.get("-1",detial: "必传参数为空"))
    }
        let cou = BikeCou.getInstance()
        return cou.postUseCoupons(id: id).then(on: cou.queue, { (webAPIRetrun) -> Promise<BizcoupRetUpdateCoupStatus> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUpdateCoupStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUpdateCoupStatus
            return Promise<BizcoupRetUpdateCoupStatus>.value(body)
        })
    }
    
    // 领取红包
    
    public func getRedPacket() -> Promise<BizcoupRetHzActivity> {
        let coupon = BikeCou.getInstance()
        return coupon.postRedPacket().then(on: coupon.queue, { (webAPIRetrun) -> Promise<BizcoupRetHzActivity> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetHzActivity>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetHzActivity
            return Promise<BizcoupRetHzActivity>.value(body)
        })
    }
    
    /**
     *
     * channel: 渠道 1：骑行 0: 分享
     * type  活动类型 1：2017活动  3.2018双旦活动
     */
   public func userOtherChance(channel: String = "0", type: String) -> Promise<BizcoupRetUserOtherChance> {
        let cou = BikeCou.getInstance()
        return cou.postUserOtherChance(channel: channel, type: type).then(on: cou.queue, { (webAPIRetrun) -> Promise<BizcoupRetUserOtherChance> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUserOtherChance>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUserOtherChance
            return Promise<BizcoupRetUserOtherChance>.value(body)
        })
    }
    
//MARK: ca 服务 开通租车业务  ============================================================================
    
    /**
     获取用户租车状态
     */
    public func getBizInfoCa(serviceId: String) -> Promise<BikecaRetBizinfo>{
        
        let ca = Bikeca.getInstance()
        
        return ca.postBizInfoCa(serviceId: serviceId).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetBizinfo>  in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetBizinfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetBizinfo
            return Promise<BikecaRetBizinfo>.value(body)
        })
    }
    
    /**
     开通租车业务
     */
    public func enabletradeCa(serviceid: String, certMode: String = "", certParams: String = "") -> Promise<BikecaRetEnableTrade>{
        let ca = Bikeca.getInstance()
        return ca.postEnabletradeCa(serviceId: serviceid,biztype: "1", certMode: certMode, certParams: certParams).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetEnableTrade> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetEnableTrade>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetEnableTrade
            return Promise<BikecaRetEnableTrade>.value(body)
        })
    }
    
    /**
     注销租车业务
     */
    public func disabletradeCa(serviceid: String, refReason: String) -> Promise<BikecaRetDisableTrade>{
        let ca = Bikeca.getInstance()
        return ca.postDisabletradeCa(serviceId: serviceid, refReason: refReason).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetDisableTrade> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetDisableTrade>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetDisableTrade
            return Promise<BikecaRetDisableTrade>.value(body)
        })
    }
    
    /**
     订单状态查询 通过订单号查询订单状态
     */
    public func checkOrderCa(orderId:String,serviceId:String = "", coupUsedId:String="", coupId:String="", finalPayMoney:String="", coupType:String="") -> Promise<BikecaRetCheckOrderStatus> {
        if orderId.requireParameterIsEmpty(){
            return Promise<BikecaRetCheckOrderStatus>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let ca = Bikeca.getInstance()
        return ca.postCheckOrderCa(orderId: orderId,serviceId:serviceId, coupUsedId: coupUsedId, coupId: coupId, finalPayMoney: finalPayMoney, coupType: coupType).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetCheckOrderStatus> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetCheckOrderStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetCheckOrderStatus
            return Promise<BikecaRetCheckOrderStatus>.value(body)
        })
    }
    
    /**
     租车
     - Parameter siteNumber     网点编号
     - Parameter parkNumber     车位编号
     - Parameter bizType     车位编号
     - Parameter setTerminalType     车位编号
     - Parameter requestType
     
     */
    public func rentalBikeCa(serviceid:String,deviceId:String,parkNum:String,bizType:String,cityCode:String) -> Promise<BikecaRetRequest>{
        
        let ca = Bikeca.getInstance()
        
        return ca.postRentalRequestCa(serviceId: serviceid, deviceId: deviceId, parkNum: parkNum,bizType:bizType, cityCode: cityCode).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetRequest> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetRequest
            return Promise<BikecaRetRequest>.value(body)
        })
    }
    
    /**
     租车记录查询
     - Parameter start 查询起始页
     - Parameter limit 查询数量
     - Parameter startTime 起始日期
     - Parameter endTime 结束日期
     */
    public func queryRentalRecordersCa(start:Int=0,limit:Int=10,startTime:Date? = nil,endTime:Date? = nil) -> Promise<[BikecaPerTripRecord]>{
        let ca = Bikeca.getInstance()
        return ca.postRentalRecordersCa(start: start, limit: limit, startTime: startTime, endTime: endTime).then(on: ca.queue, { (webAPIRetrun) -> Promise<[BikecaPerTripRecord]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaPerTripRecord]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetPerTripRecords
            return Promise<[BikecaPerTripRecord]>.value(body.data)
        })
    }
    
    /**
     周边网点查询
     - Parameter lat 搜索起始点纬度
     - Parameter lon 搜索起始点经度
     - Parameter range 搜索起范围
     */
    public func queryNearStationsCa(lat:String,lon:String,range:String,type:String,serviceid:String, keyword: String) -> Promise<[BikecaRetQueryDevicesDetail]>{
        let ca = Bikeca.getInstance()
        return ca.postNearStataionCa(serviceId: serviceid,lat: lat,lon: lon,range: range,type: type, keyword: keyword).then(on:ca.queue, {
            webAPIRetrun -> Promise<[BikecaRetQueryDevicesDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaRetQueryDevicesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetQueryDevices
            return Promise<[BikecaRetQueryDevicesDetail]>.value(body.data)
        })
    }
    
    /**
     网点查询
     - Parameter name   网点名称或网点编号
     */
    public func queryStationsCa(name:String,serviceid:String) -> Promise<[BikecaRetQueryDevicesDetail]>{
        let ca = Bikeca.getInstance()
        return ca.postQueryStationCa(serviceId: serviceid,name:name).then(on:ca.queue, {
            webAPIRetrun -> Promise<[BikecaRetQueryDevicesDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaRetQueryDevicesDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetQueryDevices
            return Promise<[BikecaRetQueryDevicesDetail]>.value(body.data)
        })
    }
    
    /**
     查询服务信息 ca
     serviceId  服务id
     serviceName 服务名称
     openMoney 服务开通金额
     serviceExtra 服务个性化参数
     */
    public func getUserBusinessQueryServiceInfo(serviceid:String,bizType:String) -> Promise<BikecaRetServiceinfo>{
        let ca = Bikeca.getInstance()
        return ca.postUserBusinessQueryServiceInfo(serviceId: serviceid, bizType: bizType).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetServiceinfo> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetServiceinfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetServiceinfo
            return Promise<BikecaRetServiceinfo>.value(body)
        })
    }
    
    /*
     * 获取站点详情
     */
    public func getDevicestatus(serviceId:String, deviceId:String, type:String = "1") -> Promise<BikecaRetGetDeviceStatus>{
        let ca = Bikeca.getInstance()
        DDLog("请求站点信息")
        return ca.postDevicestatus(serviceId: serviceId, deviceId: deviceId, type: type).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetGetDeviceStatus> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetGetDeviceStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetGetDeviceStatus
            return Promise<BikecaRetGetDeviceStatus>.value(body)
        })
    }
    
    /*
     * 获取续租列表
     */
   public func queryContinueRentList(serviceId:String, bikeType: String, userId: String) -> Promise<BikecaRetReletPriceList>{
        
        let ca = Bikeca.getInstance()
        return ca.postUserreletPriceList(serviceId: serviceId, bikeType: bikeType, userId: userId).then(on: ca.queue, { webAPIRetrun -> Promise<BikecaRetReletPriceList> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetReletPriceList>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetReletPriceList
            return Promise<BikecaRetReletPriceList>.value(body)
        })
    }
    
    /*
     * 续租请求
     */
   public func sendContinueRent(tripId: String, reletPrice: String, reletHour: String, bikeType: String) -> Promise<BikecaRetInsertReletRecord>{
        let ca = Bikeca.getInstance()
        return ca.postTripContinueRent(tripId: tripId, reletPrice: reletPrice, reletHour: reletHour, bikeType: bikeType).then(on: ca.queue,  { webAPIRetrun -> Promise<BikecaRetInsertReletRecord> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetInsertReletRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetInsertReletRecord
            return Promise<BikecaRetInsertReletRecord>.value(body)
        })
    }
    
    /*
     * check认证结果
     */
   public func checkCertifyStatus(channelType: String, serviceId: String) -> Promise<BikecaRetCheckCertifyStatus>{
        let ca = Bikeca.getInstance()
        return ca.checkCertifyStatus(channelType: channelType, serviceId: serviceId).then(on: ca.queue, { webAPIRetrun -> Promise<BikecaRetCheckCertifyStatus> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetCheckCertifyStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetCheckCertifyStatus
            return Promise<BikecaRetCheckCertifyStatus>.value(body)
        })
    }
    
    /**
     * 获取当前城市费率信息列表
     *
     */
   public func getCurrentCityRateInformationList(serviceId: String) -> Promise<[BikecaPriceRecord]>{
        
        let ca = Bikeca.getInstance()
        return ca.getCurrentCityRateInformationList( serviceId: serviceId).then(on: ca.queue, { (webAPIRetrun) -> Promise<[BikecaPriceRecord]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaPriceRecord]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetGetPriceList
            return Promise<[BikecaPriceRecord]>.value(body.data)
        })
    }
    
    /**
     * 获取出行总数
     */
   public func getTripOverView(serviceId: String) -> Promise<BikecaRetTripOverView> {
        
        let ca = Bikeca.getInstance()
        return ca.getTripOverView(serviceId: serviceId).then(on: ca.queue, { webAPIRetrun -> Promise<BikecaRetTripOverView> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetTripOverView>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetTripOverView
            return Promise<BikecaRetTripOverView>.value(body)
        })
    }

    /**
     * 取消退款
     */
   public func cancleRefund() -> Promise<BikecaRetRevokeRefund> {
        let ca = Bikeca.getInstance()
        return ca.cancleRefund().then(on: ca.queue, { webAPIRetrun -> Promise<BikecaRetRevokeRefund> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetRevokeRefund>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetRevokeRefund
            return Promise<BikecaRetRevokeRefund>.value(body)
        })
    }

    /**
     * 退款进度查询
     */
   public func postQueryProgress() -> Promise<BikecaRetQueryProgress> {
        let iotca = Bikeca.getInstance()
        return iotca.getQueryProgress().then(on: iotca.queue, { webAPIRetrun -> Promise<BikecaRetQueryProgress> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetQueryProgress>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetQueryProgress
            return Promise<BikecaRetQueryProgress>.value(body)
        })
    }
    
    /**
     * 获取可购买月卡列表
     */
    public func getMCardList(serviceId: String, grade: String = "0") -> Promise<[BikecaGetCardDetailList]> {
        let ca = Bikeca.getInstance()
    return ca.postRetShoudBuyMCList(serviceId: serviceId, grade: grade).then(on: ca.queue, { (webAPIRetrun) -> Promise<[BikecaGetCardDetailList]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaGetCardDetailList]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetGetCardDetailList
            return Promise<[BikecaGetCardDetailList]>.value(body.data)
        })
    }
    
    /**
    * 获取用户剩余月卡天数
    */
   public func getMCHaceDays(grade: String = "0") -> Promise<BikecaRetQueryCardDaysRemaining>{
        let ca = Bikeca.getInstance()
        return ca.postRetDaysRemaining(grade: grade).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetQueryCardDaysRemaining> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetQueryCardDaysRemaining>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetQueryCardDaysRemaining
            return Promise<BikecaRetQueryCardDaysRemaining>.value(body)
        })
    }
    
    /**
     * 生成月卡，钱包订单
     */
    public func getMCardOrderId(serviceId: String, cardId: String, walletConfigId: String = "") -> Promise<BikecaRetUserBuyCard>{
        let ca = Bikeca.getInstance()
        return ca.postCreateCardOrederId(serviceId: serviceId, cardId: cardId, walletConfigId: walletConfigId).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetUserBuyCard> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetUserBuyCard>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetUserBuyCard
            return Promise<BikecaRetUserBuyCard>.value(body)
        })
    }
    
    /**
     * 月卡记录
     */
   public func queryMouthCardHistory(beginIndx: String) -> Promise<[BikecaGetUserBuyCardList]>{
        let ca = Bikeca.getInstance()
        return ca.getUserBuyCardList(beiginindex: beginIndx).then(on: ca.queue, { (webAPIRetrun) -> Promise<[BikecaGetUserBuyCardList]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaGetUserBuyCardList]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetGetUserBuyCardList
            return Promise<[BikecaGetUserBuyCardList]>.value(body.data)
        })
    }
    
    /**
     * 获取体验状态信息
     */
   public func queryInviateStatus() -> Promise<BikecaRetGetInvitationInfo> {
        let ca = Bikeca.getInstance()
        return ca.getInvitationInfo().then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetGetInvitationInfo> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetGetInvitationInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetGetInvitationInfo
            return Promise<BikecaRetGetInvitationInfo>.value(body)
        })
    }
    
    /**
     * 亲密账户绑定
     */
    public func intimateBind( reqType: String, intimatePhone: String) -> Promise<BikecaRetIntimateBind> {
        let ca = Bikeca.getInstance()
        return ca.postIntimateBind(reqType: reqType, intimatePhone: intimatePhone).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetIntimateBind> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetIntimateBind>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetIntimateBind
            return Promise<BikecaRetIntimateBind>.value(body)
        })
    }
    
    //执行体验
   public func postVCode(vcode: String) -> Promise<BikecaRetInviteExpr>{
        let ca = Bikeca.getInstance()
        return ca.postInviteCode(vcode: vcode).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetInviteExpr> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetInviteExpr>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetInviteExpr
            return Promise<BikecaRetInviteExpr>.value(body)
        })
    }
    
    // 获取全部费率接口
   public func getCommonConfigList(serId: String) -> Promise<[BikecaGetCommonConfig]> {
        
        let ca = Bikeca.getInstance()
        return ca.postCommonConfigList(serId: serId).then(on: ca.queue, { (webAPIRetrun) -> Promise<[BikecaGetCommonConfig]> in
            if !webAPIRetrun.successful {
                return Promise<[BikecaGetCommonConfig]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! BikecaRetGetCommonConfigList
            return Promise<[BikecaGetCommonConfig]>.value(body.data)
        })
    }
    
    //云POS
  public func checkPosOrder(serviceId: String, type: String = "9",orderId: String) -> Promise<BikecaRetCheckCloudPosOrderStatus> {
    if orderId.requireParameterIsEmpty(){
        return Promise<BikecaRetCheckCloudPosOrderStatus>(error:Err.get("-1",detial: "必传参数为空"))
    }
        let pos = Bikeca.getInstance()
        return pos.postCheckPosOrderStatsu(type: type, orderId: orderId, serviceId: serviceId).then(on: pos.queue, { webAPIRetrun -> Promise<BikecaRetCheckCloudPosOrderStatus> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetCheckCloudPosOrderStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetCheckCloudPosOrderStatus
            return Promise<BikecaRetCheckCloudPosOrderStatus>.value(body)
        })
    }
    
//MARK: 定位服务  ============================================================================
    /*
     * 获取定位服务
     */
    public func queryLocalInfo(_ coordinate: String, _ coordType: String, _ serviceId: String = "") -> Promise<BizlocRetGetServiceInfo> {
        
        let loc = LocalInfo.getInstance()
        return loc.postLocalInfo(coordinate, coordType, serviceId).then(on:loc.queue, {
            webAPIRetrun -> Promise<BizlocRetGetServiceInfo> in
            
            if !webAPIRetrun.successful {
                return Promise<BizlocRetGetServiceInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizlocRetGetServiceInfo
            return Promise<BizlocRetGetServiceInfo>.value(body)
        })
    }
    
//MARK: 公交云POS  ============================================================================
    /*
     * 云Pos
     * - Parameter serviceId:
     * - Returns:
     */
   public func postQRCode(serviceId: String) -> Promise<CloudposRetQRCodeRequest>  {
        let pos = CloidPosServer.getInstance()
        return pos.requestQRCode(serviceId: serviceId).then(on: pos.queue, { (webAPIRetrun) -> Promise<CloudposRetQRCodeRequest> in
            if !webAPIRetrun.successful {
                return Promise<CloudposRetQRCodeRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CloudposRetQRCodeRequest
            return Promise<CloudposRetQRCodeRequest>.value(body)
        })
    }
    
     //同意公交协议
   public func postAgree() -> Promise<CloudposRetAgree> {
        let pos = CloidPosServer.getInstance()
        return pos.agreeRquest().then(on: pos.queue, { (webAPIRetrun) -> Promise<CloudposRetAgree> in
            if !webAPIRetrun.successful {
                return Promise<CloudposRetAgree>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CloudposRetAgree
            return Promise<CloudposRetAgree>.value(body)
        })
    }
    
//MARK: 用户认证服务 ============================================================================
    
    //提交身份认证
   public func posCertification(serviceId: String, userId: String, realName: String, phoneNo: String, idCard: String, params: String, channel: String) -> Promise<CertifyRetCertify>{
        
        let cer = Certification.getInstance()
        return cer.postCertification(serviceId: serviceId, userId: userId, realName: realName, phoneNo: phoneNo, idCard: idCard, params: params, channel: channel).then(on: cer.queue, { webAPIRetrun -> Promise<CertifyRetCertify> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetCertify>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CertifyRetCertify
            return Promise<CertifyRetCertify>.value(body)
        })
    }
    
    //获取用户认证信息、叮嗒卡信息
   public func getCerInfo(serviceId: String, channel:String) -> Promise<[CertifyCertInfoDetail]>{
        let cer = Certification.getInstance()
        return cer.postCerInformation(serviceId: serviceId, channel: channel).then(on: cer.queue, { (webAPIRetrun) -> Promise<[CertifyCertInfoDetail]> in
            if !webAPIRetrun.successful {
                return Promise<[CertifyCertInfoDetail]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CertifyRetGetCertInfo
            return Promise<[CertifyCertInfoDetail]>.value(body.data)
        })
    }
    
    //查询用户认证状态
   public func checkCertStatus(channel: String)-> Promise<CertifyRetIsCertified>{
        let cer = Certification.getInstance()
        return cer.postCheckCerStatus(channel: channel).then(on: cer.queue, { (webAPIRetrun) -> Promise<CertifyRetIsCertified> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetIsCertified>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! CertifyRetIsCertified
            return Promise<CertifyRetIsCertified>.value(body)
        })
    }
    
    //查询白名单状态
   public func checkWhiteStatus(channel: String) -> Promise<CertifyRetWhiteListStatus>{
        let cer = Certification.getInstance()
        return cer.postCheckMobileCard(channel: channel).then(on: cer.queue, { (webAPIRetrun) -> Promise<CertifyRetWhiteListStatus> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetWhiteListStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! CertifyRetWhiteListStatus
            return Promise<CertifyRetWhiteListStatus>.value(body)
        })
    }
    
    // 查询城市租车IC卡绑定费率
   public func getListCertConfig(serId: String) -> Promise<CertifyRetListCertConfig> {
    if serId.requireParameterIsEmpty(){
        return Promise<CertifyRetListCertConfig>(error:Err.get("-1",detial: "必传参数为空"))
    }
        let cer = Certification.getInstance()
        return cer.postListCertConfig(serId: serId).then(on: cer.queue, { (webAPIRetrun) -> Promise<CertifyRetListCertConfig> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetListCertConfig>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! CertifyRetListCertConfig
            return Promise<CertifyRetListCertConfig>.value(body)
        })
    }
    
//MARK: mt 中原对应信息  ============================================================================
  public func getAppInfo() -> Promise<retSysInfo>{
        let uum = BikeUum.getInstance()
        return uum.systemCenter.sysinfo().then(on: uum.queue, { (webAPIRetrun) -> Promise<retSysInfo> in
            if !webAPIRetrun.successful {
                return Promise<retSysInfo>(error:Err.get(webAPIRetrun.retcode, detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! retSysInfo
             return Promise<retSysInfo>.value(body)
        })
    }
    
    // 获取验证码
   public func getVCode( _ phoneNumber:String, _ channel:String,  appId: String) -> Promise<UumRetGetVcode> {
        
        let uum = BikeUum.getInstance()
       return uum.userCenter.postGetVcode(phoneNumber, channel, appId: appId).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetGetVcode> in
            
            if !webAPIRetrun.successful {
                return Promise<UumRetGetVcode>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! UumRetGetVcode
            return Promise<UumRetGetVcode>.value(body)
        })
    }
    
    // 用验证码登录
    public func vCodeLogin(loginName: String, vcode: String, userToken: String = "") -> Promise<UumRetVCodeLogin>{
        let uum = BikeUum.getInstance()
        return uum.userCenter.postVCodeLogin(loginName, vcode, userToken).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetVCodeLogin> in
            if !webAPIRetrun.successful {
                return Promise<UumRetVCodeLogin>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! UumRetVCodeLogin
            if body.avatarURL != nil && body.avatarURL != "" && body.avatarURL != "null"{
                do {
                    let url : URL = URL.init(string: body.avatarURL!)!
                    let request = NSURLRequest(url: url)
                    let imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                    if imgData != nil {
                        if imgData!.count > 0 && UIImage.init(data: imgData!) != nil{
                            UserDefaults.standard.setValue(imgData, forKey: "kAvatarPicKey")
                            UserDefaults.standard.synchronize()
                        }
                    }
                }
            }
            
            let tokenSaveTime = NSDate.timeIntervalSinceReferenceDate
            _ = UserToken(
                userId: String.isEmptyReplace(body.userId,replace: "u0000****"),
                loginname: body.phoneNO!,
                token: body.userToken!,
                tokenSaveTime:String(tokenSaveTime)).VcodetokenSaveToUserDefault()
            return Promise<UumRetVCodeLogin>.value(body)
        })
    }
    
    //更换头像
   public func ChangeAvatar(_ avatarURL: String) -> Promise<UumRetUpdateAvatar> {
        let uum = BikeUum.getInstance()
        return uum.userCenter.postChangeAvatar(avatarURL: avatarURL).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetUpdateAvatar> in
            
            if !webAPIRetrun.successful {
                return Promise<UumRetUpdateAvatar>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! UumRetUpdateAvatar
            return Promise<UumRetUpdateAvatar>.value(body)
        })
    }
    
    /*
     * 第三方登陆是否已绑定
     * bindId  第三方账号唯一标识
     * thirdBindType  第三方登陆类型  微信:wx
     *  result
     * isRegister  0:未绑定 1:已绑定  error:验证异常
     * accessToken   访问令牌,访问其他服务使用,用户无操作15天失效
     **/
   public func IsThirdBind( bindId: String, thirdBindType: String, requestType: String, memberPhone:String) -> Promise<UumRetIsThirdBind> {
        
        let uum = BikeUum.getInstance()
        return uum.userCenter.postIsThirdBind(bindId: bindId, thirdBindType: thirdBindType, requestType: requestType, memberPhone: memberPhone).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetIsThirdBind> in
            
            if !webAPIRetrun.successful {
                return Promise<UumRetIsThirdBind>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! UumRetIsThirdBind
            if body.isRegister != "1" || requestType != "1" {
                return Promise<UumRetIsThirdBind>.value(body)
            }
            if body.avatarURL != nil && body.avatarURL != "" && body.avatarURL != "null"{
                do {
                    let url : URL = URL.init(string: body.avatarURL!)!
                    let request = NSURLRequest(url: url)
                    let imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                    if imgData != nil {
                        if imgData!.count > 0 && UIImage.init(data: imgData!) != nil{
                            UserDefaults.standard.setValue(imgData, forKey: "kAvatarPicKey")
                            UserDefaults.standard.synchronize()
                        }
                    }
                }
            }
            
            let tokenSaveTime = NSDate.timeIntervalSinceReferenceDate
            _ = UserToken(
                userId: String.isEmptyReplace(body.userId,replace: "u0000****"),
                loginname: body.phoneNO!,
                token: body.userToken!,
                tokenSaveTime:String(tokenSaveTime)).VcodetokenSaveToUserDefault()
            return Promise<UumRetIsThirdBind>.value(body)
        })
    }
    
    /*
     * 第三方登陆解绑与绑定
     * memberPhone  用户手机号
     * thirdBindType  第三方登陆类型
     * result
     * isUnbind true 解绑/绑定成功 false:解绑/绑定失败
     **/
    
   public func ThirdSwitchBind(memberPhone: String, thirdBindType: String, bindId: String, switchType: String, loginId: String) -> Promise<UumRetThirdSwitchBind> {
        
        let uum = BikeUum.getInstance()
        return uum.userCenter.postThirdSwitchBind(memberPhone: memberPhone, thirdBindType: thirdBindType, bindId: bindId, switchType: switchType, loginId: loginId).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetThirdSwitchBind> in
            if !webAPIRetrun.successful {
                return Promise<UumRetThirdSwitchBind>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! UumRetThirdSwitchBind
            return Promise<UumRetThirdSwitchBind>.value(body)
        })
    }
    
    /*
     * 第三方登陆绑定
     * userPhone   用户手机号
     * vcode  验证码
     * result
     * userToken 用户令牌,自动登录
     * exchangeKey 消息交换密钥
     * accessToken 访问令牌,访问其他服务使用,用户无操作15天失效
     * userId 用户ID
     * phoneNO 手机号码
     * avatarURL
     **/
   public func ThirdBindLogin(memberName: String, avatarURL: String, bindId: String, thirdBindType: String,userPhone: String, vcode: String) -> Promise<UumRetThirdBindLogin> {
        let uum = BikeUum.getInstance()
        return uum.userCenter.postThirdBindLogin(memberName: memberName, avatarURL: avatarURL, bindId: bindId, thirdBindType: thirdBindType, userPhone: userPhone, vcode: vcode).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetThirdBindLogin> in
            
            if !webAPIRetrun.successful {
                return Promise<UumRetThirdBindLogin>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            
            let body = webAPIRetrun as! UumRetThirdBindLogin
            if body.avatarURL != nil && body.avatarURL != "" && body.avatarURL != "null"{
                do {
                    let url : URL = URL.init(string: body.avatarURL!)!
                    let request = NSURLRequest(url: url)
                    let imgData = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil)
                    if imgData != nil {
                        if imgData!.count > 0 && UIImage.init(data: imgData!) != nil{
                            UserDefaults.standard.setValue(imgData, forKey: "kAvatarPicKey")
                            UserDefaults.standard.synchronize()
                        }
                    }
                }
            }
            
            let tokenSaveTime = NSDate.timeIntervalSinceReferenceDate
            _ = UserToken(
                userId: String.isEmptyReplace(body.userId,replace: "u0000****"),
                loginname: body.phoneNO!,
                token: body.userToken!,
                tokenSaveTime:String(tokenSaveTime)).VcodetokenSaveToUserDefault()
            return Promise<UumRetThirdBindLogin>.value(body)
        })
    }
    
    /// 获取用户信息
    public func GetMemberInfo() -> Promise<UumRetGetMemberInfo> {
        
        let uum = BikeUum.getInstance()
        return uum.userCenter.postGetMemberInfo().then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetGetMemberInfo> in
            if !webAPIRetrun.successful {
                return Promise<UumRetGetMemberInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! UumRetGetMemberInfo
            return Promise<UumRetGetMemberInfo>.value(body)
        })
    }
    
    /// 修改用户信息
    ///
    /// - Parameters:
    ///   - nickName: 姓名
    ///   - avatarURL: 用户头像
    ///   - memberAlias: 用户别名
    ///   - memberSex: 用户性别  默认1：男 0：女
    ///   - memberBirthday: 用户生日
    ///   - memberIndustry:  用户行业
    ///   - memberTags: 个性化标签
    public func UpdateMemberInfo(nickName: String, avatarURL: String, memberAlias: String, memberSex: String, memberBirthday: String, memberIndustry: String, memberTags: String) -> Promise<UumRetUpdateMemberInfo> {
        
        let uum = BikeUum.getInstance()
        return uum.userCenter.postUpdateMemberInfo(nickName: nickName, avatarURL: avatarURL, memberAlias: memberAlias, memberSex: memberSex, memberBirthday: memberBirthday, memberIndustry: memberIndustry, memberTags: memberTags).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetUpdateMemberInfo> in
            if !webAPIRetrun.successful {
                return Promise<UumRetUpdateMemberInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! UumRetUpdateMemberInfo
            return Promise<UumRetUpdateMemberInfo>.value(body)
        })
    }
    
    //获取城市列表
    public func getCitylist() -> Promise<MtretCityListInfo>{
        let uum = BikeUum.getInstance()
        return uum.systemCenter.getCitylist().then(on: uum.queue, { (webAPIRetrun) -> Promise<MtretCityListInfo> in
            if !webAPIRetrun.successful {
                return Promise<MtretCityListInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MtretCityListInfo
            return Promise<MtretCityListInfo>.value(body)
        })
    }
    
    ///查询用户钱包
    public func QueryUserWallet(serviceId: String) -> Promise<BizcoupRetQueryUserWallet> {
        let cou = BikeCou.getInstance()
        return cou.postQueryUserWallet(serviceId: serviceId).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetQueryUserWallet> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetQueryUserWallet>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetQueryUserWallet
            return Promise<BizcoupRetQueryUserWallet>.value(body)
        })
    }
    
    ///钱包套餐列表  返回钱包基本套餐
    public func QueryWalletConfigList(serviceId: String) -> Promise<BizcoupRetQueryWalletConfigList> {
        let cou = BikeCou.getInstance()
        return cou.postQueryWalletConfigList(serviceId: serviceId).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetQueryWalletConfigList> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetQueryWalletConfigList>(error:ITReturnInfo.init(webAPIRetrun.retcode!,webAPIRetrun.retmsg!))
            }
            let body = webAPIRetrun as! BizcoupRetQueryWalletConfigList
            return Promise<BizcoupRetQueryWalletConfigList>.value(body)
        })
    }
    
    ///查询用户钱包充值记录列表
    public func GetWalletBuyRecord(beginindex: String, retcount: String) -> Promise<BizcoupRetGetWalletBuyRecord> {
        let cou = BikeCou.getInstance()
        return cou.postGetWalletBuyRecord(beginindex: beginindex, retcount: retcount).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetGetWalletBuyRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetGetWalletBuyRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetGetWalletBuyRecord
            return Promise<BizcoupRetGetWalletBuyRecord>.value(body)
        })
    }
    
    ///查询用户钱包消费记录列表
    public func UserWalletConsumeRecord(beginindex: String, retcount: String) -> Promise<BizcoupRetUserWalletConsumeRecord> {
        let cou = BikeCou.getInstance()
        return cou.postUserWalletConsumeRecord(beginindex: beginindex, retcount: retcount).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetUserWalletConsumeRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUserWalletConsumeRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUserWalletConsumeRecord
            return Promise<BizcoupRetUserWalletConsumeRecord>.value(body)
        })
    }
    
    ///使用钱包支付超时费、月卡、云pos、移动联名卡（叮嗒卡）、IC卡绑卡等费用  <!--usedChannel 使用渠道  1：自行车超时费 2:购买月卡 3：云POS 4：移动联名卡（叮嗒卡）5：IC卡绑卡-->
    public func UseWalletForBusiness(orderId: String,serviceId: String,usedChannel: String, coupUsedId: String) -> Promise<BikecaRetUseWalletForBusiness>{
        if orderId.requireParameterIsEmpty(){
            return Promise<BikecaRetUseWalletForBusiness>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let ca = Bikeca.getInstance()
        
        return ca.postUseWalletForBusiness(orderId: orderId,serviceId: serviceId,usedChannel: usedChannel, coupUsedId: coupUsedId).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetUseWalletForBusiness>  in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetUseWalletForBusiness>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetUseWalletForBusiness
            return Promise<BikecaRetUseWalletForBusiness>.value(body)
        })
    }
    
    ///购买月卡等的时候  检查订单状态信息 APP支付完毕,则调用；或者在APP弹出的支付异常提示框中,用户点击已支付,APP对订单状态的检查
    public func CheckBuyOrderStatus(orderId: String,serviceId: String,type: String, cardId: String, walletConfigId: String) -> Promise<BikecaRetCheckBuyOrderStatus>{
        
        let ca = Bikeca.getInstance()
        
        return ca.postCheckBuyOrderStatus(orderId: orderId,serviceId: serviceId,type: type, cardId: cardId, walletConfigId: walletConfigId).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetCheckBuyOrderStatus>  in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetCheckBuyOrderStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetCheckBuyOrderStatus
            return Promise<BikecaRetCheckBuyOrderStatus>.value(body)
        })
    }
    
    //签到
    public func signOnUser(serviceId: String) -> Promise<BizcoupRetSignForDD> {
        let cou = BikeCou.getInstance()
        return cou.postUserSign(serviceId: serviceId).then(on: cou.queue, { (webAPIRetrun) -> Promise<BizcoupRetSignForDD> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetSignForDD>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetSignForDD
            return Promise<BizcoupRetSignForDD>.value(body)
        })
    }
    
    //签到记录
    public func getSignInfo() -> Promise<BizcoupRetSignListAndStatus> {
        let cou = BikeCou.getInstance()
        return cou.postUserSignInfo().then(on: cou.queue, { (webAPIRetrun) -> Promise<BizcoupRetSignListAndStatus> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetSignListAndStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetSignListAndStatus
            return Promise<BizcoupRetSignListAndStatus>.value(body)
        })
    }
    
    //永久租还车验证请求
    public func hireOreRentYJBike(serviceId: String,DeviceId: String, qR: String="", electricity: String, cityCode: String, biztype: String, hireStationName: String, rentflag: String = "map", deviceStakeId: String = "", coordinate: String) -> Promise<ThirdpartyRetThirdPartyHireRequest>{
        let third = ThirdPartService.getInstance()
        return third.hirebike(serviceId: serviceId, DeviceId: DeviceId, qR: qR, electricity: electricity, cityCode: cityCode, biztype: biztype, hireStationName: hireStationName, rentflag: rentflag, deviceStakeId: deviceStakeId, coordinate: coordinate).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetThirdPartyHireRequest> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetThirdPartyHireRequest>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetThirdPartyHireRequest
            return Promise<ThirdpartyRetThirdPartyHireRequest>.value(body)
        })
    }
    
    //还车请求
    public func restoreYJBike(deviceId: String, cityCode: String, deviceType: String, lockStatus: String, coordinate: String, electricity: String, rentflag: String = "map", deviceStakeId: String, restoreStationName: String, flag: String, operId: String) -> Promise<ThirdpartyRetThirdPartyTrip> {
        let third = ThirdPartService.getInstance()
        return third.restoreBike(deviceId: deviceId, cityCode: cityCode, deviceType: deviceType, lockStatus: lockStatus, coordinate: coordinate, electricity: electricity, rentflag: rentflag, deviceStakeId: deviceStakeId, restoreStationName: restoreStationName, flag: flag, operId: operId).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetThirdPartyTrip> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetThirdPartyTrip>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetThirdPartyTrip
            return Promise<ThirdpartyRetThirdPartyTrip>.value(body)
        })
    }
    
    //车辆故障
    public func erporyYJError(operId: String, deviceId: String, coordinate: String, electricity: String, deviceStakeId: String, restoreStationName: String, failBody: String, failType: String, kindId: String) -> Promise<ThirdpartyRetThirdPartyHireError> {
        let third = ThirdPartService.getInstance()
        return third.errorHire(operId: operId, deviceId: deviceId, coordinate: coordinate, electricity: electricity, deviceStakeId: "", restoreStationName: restoreStationName,failBody: failBody, failType: failType, kindId: kindId).then(on: third.queue) { (webAPIRetrun) -> Promise<ThirdpartyRetThirdPartyHireError> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetThirdPartyHireError>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetThirdPartyHireError
            return Promise<ThirdpartyRetThirdPartyHireError>.value(body)
        }
    }
    
    //永久附近站点
    public func getNearYJStations(serviceId: String, coordinate: String) -> Promise<[ThirdpartyRetStation]>{
        let third = ThirdPartService.getInstance()
        return third.postNearStations(serviceId: serviceId, coordinate: coordinate).then(on: third.queue, { (webAPIRetrun) -> Promise<[ThirdpartyRetStation]> in
            if !webAPIRetrun.successful {
                return Promise<[ThirdpartyRetStation]>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetGetStations
            return Promise<[ThirdpartyRetStation]>.value(body.data)
        })
    }
    //永久附近车辆
    public func getNearBikes(coordinate: String, serviceId: String) -> Promise<ThirdpartyRetGetBikes>{
        let third = ThirdPartService.getInstance()
        return third.postNearbike(coordinate: coordinate, serviceId: serviceId).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetGetBikes> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetGetBikes>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetGetBikes
            return Promise<ThirdpartyRetGetBikes>.value(body)
        })
    }
    //永久行车区域
    public func getYJDriveSpace(cityCode: String) -> Promise<ThirdpartyRetGetScopes> {
        let third = ThirdPartService.getInstance()
        return third.postDriveSpace(cityCode: cityCode).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetGetScopes> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetGetScopes>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetGetScopes
            return Promise<ThirdpartyRetGetScopes>.value(body)
        })
    }
    
    //new 永久行车区域
    public func businessScopesNew(cityCode: String) -> Promise<ThirdpartyRetGetScopesNew> {
        let third = ThirdPartService.getInstance()
        return third.postBusinessScopesNew(cityCode: cityCode).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetGetScopesNew> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetGetScopesNew>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetGetScopesNew
            return Promise<ThirdpartyRetGetScopesNew>.value(body)
        })
    }
    
    //永久车辆信息
    public func queryBikeInfo(bikeCode: String) -> Promise<ThirdpartyRetGetBike> {
        if bikeCode.requireParameterIsEmpty(){
            return Promise<ThirdpartyRetGetBike>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let third = ThirdPartService.getInstance()
        
        return third .postBikeInfo(bikeCode: bikeCode).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetGetBike> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetGetBike>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetGetBike
            return Promise<ThirdpartyRetGetBike>.value(body)
        })
    }
    
    //永久骑行轨迹
    public func reportTrip(operId: String, points: String) -> Promise<ThirdpartyRetTripPath> {
        let third = ThirdPartService.getInstance()
        return third.postTrip(operId: operId, points: points).then(on: third.queue, { (webAPIRetrun) -> Promise<ThirdpartyRetTripPath> in
            if !webAPIRetrun.successful {
                return Promise<ThirdpartyRetTripPath>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! ThirdpartyRetTripPath
            return Promise<ThirdpartyRetTripPath>.value(body)
        })
    }
    
    //获取拓展业务协议状态
    public func queryBizagree()->Promise<BikecaRetGetBizAgree> {
        let ca = Bikeca.getInstance()
        return ca.postQueryOtherBiz().then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetGetBizAgree> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetGetBizAgree>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetGetBizAgree
            return Promise<BikecaRetGetBizAgree>.value(body)
        })
    }
    
    //同意拓展协议bizType： 1 MSC 2 YJ 3公交 4新用户领券(pamrams:-1拒绝)
    public func agereeOtherBiz(bizType: String, pamrams: String = "")->Promise<BikecaRetOpenBizAgree>{
        let ca = Bikeca.getInstance()
        return ca.postAgree(bizType: bizType, pamrams: pamrams).then(on: ca.queue, { (webAPIRetrun) -> Promise<BikecaRetOpenBizAgree> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetOpenBizAgree>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetOpenBizAgree
            return Promise<BikecaRetOpenBizAgree>.value(body)
        })
    }
    
    //获取用户MSC业务信息
    public func getUserMSCBizInfo(serviceId: String) -> Promise<MscRetMscBizInfo> {
        if serviceId.requireParameterIsEmpty(){
            return Promise<MscRetMscBizInfo>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let msc = MscService.getInstance()
        return msc.posMscBizInfo(serviceId: serviceId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetMscBizInfo> in
            if !webAPIRetrun.successful {
                return Promise<MscRetMscBizInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetMscBizInfo
            return Promise<MscRetMscBizInfo>.value(body)
        })
    }
    
    //MSC周边网点
    public func queryNearStations(coordinate: String, range: String = "1000", serviceId: String) -> Promise<MscRetQueryMscDevices> {
        let msc = MscService.getInstance()
        return msc.postNearStation(coordinate: coordinate, range: range, serviceId: serviceId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetQueryMscDevices> in
            if !webAPIRetrun.successful {
                return Promise<MscRetQueryMscDevices>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetQueryMscDevices
            return Promise<MscRetQueryMscDevices>.value(body)
        })
    }
    
    //new MSC周边网点
    public func queryNewNearStations(coordinate: String, range: String = "1000", serviceId: String) -> Promise<MscRetQueryMscStation> {
        let msc = MscService.getInstance()
        return msc.postNewNearStation(coordinate: coordinate, range: range, serviceId: serviceId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetQueryMscStation> in
            if !webAPIRetrun.successful {
                return Promise<MscRetQueryMscStation>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetQueryMscStation
            return Promise<MscRetQueryMscStation>.value(body)
        })
    }
    
    //msc站点详情
    public func mscStationDetailed(serviceId: String, stationId: String) -> Promise<MscRetStationDetailed> {
        if serviceId.requireParameterIsEmpty() || stationId.requireParameterIsEmpty(){
            return Promise<MscRetStationDetailed>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let msc = MscService.getInstance()
        return msc.postStationDetailed(serviceId: serviceId, stationId: stationId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetStationDetailed> in
            if !webAPIRetrun.successful {
                return Promise<MscRetStationDetailed>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetStationDetailed
            return Promise<MscRetStationDetailed>.value(body)
        })
    }

    //MSC检查订单
    public func checkMSCOrder(serviceId: String, orderId: String, isNew: Bool = false) -> Promise<MscRetCheckMscOrder> {
        let msc = MscService.getInstance()
        DDLog("MSC订单检查")
        return msc.postCheckMscOrder(serviceId: serviceId, orderId: orderId, isNew: isNew).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetCheckMscOrder> in
            if !webAPIRetrun.successful {
                return Promise<MscRetCheckMscOrder>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetCheckMscOrder
            return Promise<MscRetCheckMscOrder>.value(body)
        })
    }
    
    //MSC租电请求 new
    public func requestNewMSC(serviceId: String, deviceId: String, priceConfigId: String, portId: String) -> Promise<MscRetRequestRent> {
        let msc = MscService.getInstance()
        return msc.postNewRequestRent(serviceId: serviceId, deviceId: deviceId, priceConfigId: priceConfigId, portId: portId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetRequestRent> in
            if !webAPIRetrun.successful {
                return Promise<MscRetRequestRent>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetRequestRent
            return Promise<MscRetRequestRent>.value(body)
        })
    }
    
    //MSC租电请求 old
    public func requestMSC(serviceId: String, deviceId: String, priceConfigId: String) -> Promise<MscRetRequestCharge> {
        let msc = MscService.getInstance()
        return msc.postRequestRent(serviceId: serviceId, deviceId: deviceId, priceConfigId: priceConfigId).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetRequestCharge> in
            if !webAPIRetrun.successful {
                return Promise<MscRetRequestCharge>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetRequestCharge
            return Promise<MscRetRequestCharge>.value(body)
        })
    }
    
    //MSC记录
    public func getMscRecord(start: String, limit: String) -> Promise<MscRetGetChargeRecord> {
        let msc = MscService.getInstance()
        return msc.postMscRecord(start: start, limit: limit).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetGetChargeRecord> in
            if !webAPIRetrun.successful {
                return Promise<MscRetGetChargeRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetGetChargeRecord
            return Promise<MscRetGetChargeRecord>.value(body)
        })
    }
    
    //MSC选择时间列表
    public func queryPricelist(serviceId: String, deviceId: String, isNew: Bool = false) -> Promise<MscRetMscPriceConfig> {
        let msc = MscService.getInstance()
        return msc.postMSCRentList(serviceId: serviceId, deviceId: deviceId, isNew: isNew).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetMscPriceConfig> in
            if !webAPIRetrun.successful {
                return Promise<MscRetMscPriceConfig>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetMscPriceConfig
            return Promise<MscRetMscPriceConfig>.value(body)
        })
    }
    
    //MSC钱包支付
    public func mscUseWalletPay(orderId: String, usedChannel: String = "6", serviceId: String, isNew: Bool = false) -> Promise<MscRetUseWalletPay> {
        if serviceId.requireParameterIsEmpty() || orderId.requireParameterIsEmpty(){
            return Promise<MscRetUseWalletPay>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let msc = MscService.getInstance()
        return msc.postUseWalletPay(orderId: orderId, usedChannel: usedChannel, serviceId: serviceId, isNew: isNew).then(on: msc.queue, { (webAPIRetrun) -> Promise<MscRetUseWalletPay> in
            if !webAPIRetrun.successful {
                return Promise<MscRetUseWalletPay>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! MscRetUseWalletPay
            return Promise<MscRetUseWalletPay>.value(body)
        })
    }
    
    //用户登录日志记录
    public func memLoginLog(phonemodel: String, phoneVersion: String, appVersion: String, ipAdd: String, serviceId: String) -> Promise<UumRetMemLoginLog>{
        let uum = BikeUum.getInstance()
        return uum.userCenter.postMemLoginLog(phonemodel: phonemodel, phoneVersion: phoneVersion, appVersion: appVersion, ipAdd: ipAdd, serviceId: serviceId).then(on: uum.queue, { (webAPIRetrun) -> Promise<UumRetMemLoginLog> in
            if !webAPIRetrun.successful {
                return Promise<UumRetMemLoginLog>(error:Err.get(webAPIRetrun.retcode, detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! UumRetMemLoginLog
            return Promise<UumRetMemLoginLog>.value(body)
        })
    }
    
    //个人红包查询
    public func userRedpac(serviceId: String) -> Promise<BizcoupRetUserRedpac>{
        if serviceId.requireParameterIsEmpty(){
            return Promise<BizcoupRetUserRedpac>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = BikeCou.getInstance()
        return cou.postUserRedpac(serviceId: serviceId).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetUserRedpac> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUserRedpac>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUserRedpac
            return Promise<BizcoupRetUserRedpac>.value(body)
        })
    }
    
    //个人红包获取记录列表
    public func getRedpacObtainRecord(beginindex: String, retcount: String) -> Promise<BizcoupRetGetRedpacObtainRecord>{
        let cou = BikeCou.getInstance()
        return cou.postGetRedpacObtainRecord(beginindex: beginindex, retcount: retcount).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetGetRedpacObtainRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetGetRedpacObtainRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetGetRedpacObtainRecord
            return Promise<BizcoupRetGetRedpacObtainRecord>.value(body)
        })
    }
    
    //个人红包使用记录列表
    public func useRedpacRecord(beginindex: String, retcount: String) -> Promise<BizcoupRetUseRedpacRecord>{
        let cou = BikeCou.getInstance()
        return cou.postUseRedpacRecord(beginindex: beginindex, retcount: retcount).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetUseRedpacRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUseRedpacRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUseRedpacRecord
            return Promise<BizcoupRetUseRedpacRecord>.value(body)
        })
    }
    
    //红包转入余额
    public func shiftToBanlance(serviceId: String) -> Promise<BizcoupRetShiftToBanlance>{
        if serviceId.requireParameterIsEmpty(){
            return Promise<BizcoupRetShiftToBanlance>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = BikeCou.getInstance()
        return cou.postShiftToBanlance(serviceId: serviceId).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetShiftToBanlance> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetShiftToBanlance>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetShiftToBanlance
            return Promise<BizcoupRetShiftToBanlance>.value(body)
        })
    }
    
    //红包提现 accountfalg:提现账户渠道（默认：ALIPAY:支付宝 WX:微信） 目前只支持支付宝
    public func redpacWithdraw(serviceId: String, money: String, withdrawAccount: String, userName: String,accountFalg: String = "ALIPAY") -> Promise<BizcoupRetRedpacWithdraw>{
        let cou = BikeCou.getInstance()
        return cou.postRedpacWithdraw(serviceId: serviceId, money: money, withdrawAccount: withdrawAccount, userName: userName,accountFalg: accountFalg).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetRedpacWithdraw> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetRedpacWithdraw>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetRedpacWithdraw
            return Promise<BizcoupRetRedpacWithdraw>.value(body)
        })
    }
    
    //new红包提现
    public func newRedpacWd(serviceId: String, money: String, withdrawAccount: String, userName: String,accountFalg: String = "ALIPAY") -> Promise<DingdRetRedpacWdraw>{
        if serviceId.requireParameterIsEmpty() || money.requireParameterIsEmpty() {
            return Promise<DingdRetRedpacWdraw>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = DingdaWeb.getInstance()
        return cou.postNewRedpacWd(serviceId: serviceId, money: money, withdrawAccount: withdrawAccount, userName: userName,accountFalg: accountFalg).then(on:cou.queue, {
            webAPIRetrun -> Promise<DingdRetRedpacWdraw> in
            if !webAPIRetrun.successful {
                return Promise<DingdRetRedpacWdraw>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! DingdRetRedpacWdraw
            return Promise<DingdRetRedpacWdraw>.value(body)
        })
    }
    
    //新用户领取优惠券
    public func newUserRecCoupon(serviceId: String, couponType: String) -> Promise<DingdRetNewUserRecCoupon>{
        if serviceId.requireParameterIsEmpty() {
            return Promise<DingdRetNewUserRecCoupon>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = DingdaWeb.getInstance()
        return cou.postNewUserRecCoupon(serviceId: serviceId, couponType: couponType).then(on:cou.queue, {
            webAPIRetrun -> Promise<DingdRetNewUserRecCoupon> in
            if !webAPIRetrun.successful {
                return Promise<DingdRetNewUserRecCoupon>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! DingdRetNewUserRecCoupon
            return Promise<DingdRetNewUserRecCoupon>.value(body)
        })
    }
    
    //红包领取
    public func receiveRedpac(serviceId: String, obtainChannel: String = "1", redpacPerc: String) -> Promise<BizcoupRetReceiveRedpac>{
        if serviceId.requireParameterIsEmpty() {
            return Promise<BizcoupRetReceiveRedpac>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = BikeCou.getInstance()
        return cou.postReceiveRedpac(serviceId: serviceId, obtainChannel: obtainChannel, redpacPerc: redpacPerc).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetReceiveRedpac> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetReceiveRedpac>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetReceiveRedpac
            return Promise<BizcoupRetReceiveRedpac>.value(body)
        })
    }
    
    //查询等级列表
    public func getMemberLevel() -> Promise<BizcoupRetMemberLevel>{
        let cou = BikeCou.getInstance()
        return cou.postGetMemberLevel().then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetMemberLevel> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetMemberLevel>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetMemberLevel
            return Promise<BizcoupRetMemberLevel>.value(body)
        })
    }
    
    //查询用户等级和积分
    public func getMemberPoints() -> Promise<BizcoupRetMemberPoints>{
        let cou = BikeCou.getInstance()
        return cou.postGetMemberPoints().then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetMemberPoints> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetMemberPoints>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetMemberPoints
            return Promise<BizcoupRetMemberPoints>.value(body)
        })
    }
    
    //查询积分增减记录
    public func getMemberPointsRecord(addOrSubtract: String,start: String, limit: String) -> Promise<BizcoupRetMemberPointsRecord>{
        if addOrSubtract.requireParameterIsEmpty() {
            return Promise<BizcoupRetMemberPointsRecord>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let cou = BikeCou.getInstance()
        return cou.postGetMemberPointsRecord(addOrSubtract: addOrSubtract, start: start, limit: limit).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetMemberPointsRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetMemberPointsRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetMemberPointsRecord
            return Promise<BizcoupRetMemberPointsRecord>.value(body)
        })
    }
    
    //根据id获取行程
    public func getTripInfo(tripId: String) -> Promise<BikecaRetGetTripInfo>{
        if tripId.requireParameterIsEmpty() {
            return Promise<BikecaRetGetTripInfo>(error:Err.get("-1",detial: "必传参数为空"))
        }
        let ca = Bikeca.getInstance()
        return ca.postGetTripInfo(tripId: tripId).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetGetTripInfo> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetGetTripInfo>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetGetTripInfo
            return Promise<BikecaRetGetTripInfo>.value(body)
        })
    }
    
    //年卡剩余时间
    public func queryYearCardDaysRemaining() -> Promise<BizcoupRetQueryYearCardDaysRemaining>{
        let cou = BikeCou.getInstance()
        return cou.postQueryYearCardDaysRemaining().then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetQueryYearCardDaysRemaining> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetQueryYearCardDaysRemaining>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetQueryYearCardDaysRemaining
            return Promise<BizcoupRetQueryYearCardDaysRemaining>.value(body)
        })
    }
    
    //查询年卡详情列表
    public func getYearCardDetailList(serviceId: String) -> Promise<BizcoupRetGetYearCardDetailList>{
        let cou = BikeCou.getInstance()
        return cou.postGetYearCardDetailList(serviceId: serviceId).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetGetYearCardDetailList> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetGetYearCardDetailList>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetGetYearCardDetailList
            return Promise<BizcoupRetGetYearCardDetailList>.value(body)
        })
    }
    
    //查询用户年卡购买记录列表
    public func getUserBuyYearCardList(start: String, limit: String) -> Promise<BizcoupRetGetUserBuyYearCardList>{
        let cou = BikeCou.getInstance()
        return cou.postGetUserBuyYearCardList(start: start, limit: limit).then(on:cou.queue, {
            webAPIRetrun -> Promise<BizcoupRetGetUserBuyYearCardList> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetGetUserBuyYearCardList>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetGetUserBuyYearCardList
            return Promise<BizcoupRetGetUserBuyYearCardList>.value(body)
        })
    }
    
    //用户购买年卡获取orderid
    public func userBuyYearCard(yearCardId: String, serviceId: String, walletConfigId:String, bizType: String) -> Promise<DingdRetUserBuyYearCard>{
        let dingd = DingdaWeb.getInstance()
        return dingd.postUserBuyYearCard(yearCardId: yearCardId, serviceId: serviceId, walletConfigId:walletConfigId, bizType: bizType).then(on:dingd.queue, {
            webAPIRetrun -> Promise<DingdRetUserBuyYearCard> in
            if !webAPIRetrun.successful {
                return Promise<DingdRetUserBuyYearCard>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! DingdRetUserBuyYearCard
            return Promise<DingdRetUserBuyYearCard>.value(body)
        })
    }
    
    //检查年卡订单状态
    public func checkYearCardOrder(yearCardId: String, serviceId: String, orderId: String) -> Promise<BikecaRetCheckYearCardOrder>{
        let ca = Bikeca.getInstance()
        return ca.postCheckYearCardOrder(yearCardId: yearCardId, serviceId: serviceId, orderId: orderId).then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetCheckYearCardOrder> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetCheckYearCardOrder>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetCheckYearCardOrder
            return Promise<BikecaRetCheckYearCardOrder>.value(body)
        })
    }
    
    //查询用户年卡状态
    public func queryUserYearCardStatus() -> Promise<BizcoupRetUserYearCardStatus>{
        let ca = BikeCou.getInstance()
        return ca.postQueryUserYearCardStatus().then(on:ca.queue, {
            webAPIRetrun -> Promise<BizcoupRetUserYearCardStatus> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetUserYearCardStatus>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetUserYearCardStatus
            return Promise<BizcoupRetUserYearCardStatus>.value(body)
        })
    }
    
    //悦时积分免登地址获取
    public func getYueShiUrl(redirect: String = "", vip: String = "") -> Promise<BizcoupRetYueShiGetURLRecord>{
        let ca = BikeCou.getInstance()
        return ca.postGetYueShiUrl(redirect: redirect, vip: vip).then(on:ca.queue, {
            webAPIRetrun -> Promise<BizcoupRetYueShiGetURLRecord> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetYueShiGetURLRecord>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetYueShiGetURLRecord
            return Promise<BizcoupRetYueShiGetURLRecord>.value(body)
        })
    }
    
    //检查用户有无剩余月卡
    public func queryUserCard() -> Promise<BikecaRetQueryUserCard>{
        let ca = Bikeca.getInstance()
        return ca.postQueryUserCard().then(on:ca.queue, {
            webAPIRetrun -> Promise<BikecaRetQueryUserCard> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetQueryUserCard>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetQueryUserCard
            return Promise<BikecaRetQueryUserCard>.value(body)
        })
    }
    
    //苏宁贷授权信息接口
    public func suningAuthorizedlogin() -> Promise<CertifyRetAuthorizedlogin>{
        let cer = Certification.getInstance()
        return cer.postSuningAuthorizedlogin().then(on: cer.queue, { webAPIRetrun -> Promise<CertifyRetAuthorizedlogin> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetAuthorizedlogin>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CertifyRetAuthorizedlogin
            return Promise<CertifyRetAuthorizedlogin>.value(body)
        })
    }
    
    // 实名认证免押
    public func realNameFreeBet(serviceId: String) -> Promise<BikecaRetRealNameFreeBet>{
        let cer = Bikeca.getInstance()
        return cer.postRealNameFreeBet(serviceId: serviceId).then(on: cer.queue, { webAPIRetrun -> Promise<BikecaRetRealNameFreeBet> in
            if !webAPIRetrun.successful {
                return Promise<BikecaRetRealNameFreeBet>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BikecaRetRealNameFreeBet
            return Promise<BikecaRetRealNameFreeBet>.value(body)
        })
    }
    
    public func passport(serviceId: String, userId: String, passport: String) -> Promise<CertifyRetPassport>{
        let cer = Certification.getInstance()
        return cer.passport(serviceId: serviceId, userId: userId, passport: passport).then(on: cer.queue, { webAPIRetrun -> Promise<CertifyRetPassport> in
            if !webAPIRetrun.successful {
                return Promise<CertifyRetPassport>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! CertifyRetPassport
            return Promise<CertifyRetPassport>.value(body)
        })
    }
    
    //开头盔锁
    public func openHelmetLock(tripId: String) -> Promise<IotcaRetOpenHelmetLock> {
        let iotca = BikeIot.getInstance()
        return iotca.openHelmetLock(tripId: tripId).then(on: iotca.queue, { webAPIRetrun -> Promise<IotcaRetOpenHelmetLock> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetOpenHelmetLock>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg, isRelet: true))
            }
            let body = webAPIRetrun as! IotcaRetOpenHelmetLock
            return Promise<IotcaRetOpenHelmetLock>.value(body)
        })
    }
    
    //叮嗒助力车还车
    public func appReturnBike( bikeId: String, operationId: String, lat: String, lng: String, angle: String = "", lngLatList: String = "", checkDispatchFee: String = "") -> Promise<IotcaRetAppReturnBike>{
        let cer = BikeIot.getInstance()
        return cer.appReturnBike( bikeId: bikeId, operationId: operationId, lat: lat, lng: lng, angle: angle, lngLatList: lngLatList, checkDispatchFee: checkDispatchFee).then({ webAPIRetrun -> Promise<IotcaRetAppReturnBike> in
            if !webAPIRetrun.successful {
                return Promise<IotcaRetAppReturnBike>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! IotcaRetAppReturnBike
            return Promise<IotcaRetAppReturnBike>.value(body)
        })
    }
    
    //用户登陆送券
    public func loginSendCoup(serviceId: String, sendType: String = "1") -> Promise<BizcoupRetLoginSendCoup>{
        let cer = BikeCou.getInstance()
        return cer.postLoginSendCoup(serviceId: serviceId, sendType: sendType).then({ webAPIRetrun -> Promise<BizcoupRetLoginSendCoup> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetLoginSendCoup>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetLoginSendCoup
            return Promise<BizcoupRetLoginSendCoup>.value(body)
        })
    }
    
    //兑换码兑换
    public func exchangeCoupon(serviceId: String, command: String) -> Promise<BizcoupRetExchangeCoupon>{
        let cer = BikeCou.getInstance()
        return cer.postQueryExchangeCoupon(serviceId: serviceId, command: command).then({ webAPIRetrun -> Promise<BizcoupRetExchangeCoupon> in
            if !webAPIRetrun.successful {
                return Promise<BizcoupRetExchangeCoupon>(error:Err.get(webAPIRetrun.retcode,detial: webAPIRetrun.retmsg))
            }
            let body = webAPIRetrun as! BizcoupRetExchangeCoupon
            return Promise<BizcoupRetExchangeCoupon>.value(body)
        })
    }
    
    ///网点信息详情查询 new
    public func queryStationInfo( stationId: String, cityCode: String) -> Promise<[String : Any]>{
        return Promise{ seal in
            let parameters: [String: Any] = [
                "appId": kAppId,
                "cityCode": cityCode,
                "stationId": stationId
            ]
            AlamofireRequest(map: "/api/bikebht/business/queryStationInfo", param: parameters, noData: false) { data in
                seal.fulfill(data)
            } fail: { _ in
                seal.reject(ITReturnInfo.init("-1", "请求失败"))
            }
        }
    }
}

extension String {
    func requireParameterIsEmpty() -> Bool{
        return (self.isEmpty || self.lowercased() == "nil" || self.lowercased() == "null" || self.count == 0)
    }
}

@MainActor func AlamofireRequest(map: String, method: HTTPMethod = HTTPMethod.post, param: Parameters = [:], noData: Bool = true, _ suc: @escaping ([String: Any])->Void, fail: @escaping ([String: Any]?)->Void) {
    let ff = try! JSONSerialization.data(withJSONObject:param, options: [])
    let json = NSString(data: ff, encoding: String.Encoding.utf8.rawValue)
    Alamofire.request(kRootUrl + map, method: method, parameters: method == .get ? nil : param, encoding:JSONEncoding.default, headers: nil).response(queue:DispatchQueue(label: map + Date.init().toString(), attributes: DispatchQueue.Attributes.concurrent),completionHandler: { (respon) in
        if respon.data == nil {
            fail(nil)
            return
        }
        if let responseMessage = (try? JSONSerialization.jsonObject(with: respon.data!, options: [])as? [String: Any]) {
            let error = respon.error
            if error == nil {
                DispatchQueue.main.async {
                    if (responseMessage["retcode"] as? String == "0" || responseMessage["retCode"] as? String == "0") || !noData {
                        suc(responseMessage)
                        let json = NSString(data: respon.data!, encoding: String.Encoding.utf8.rawValue)
                        return
                    }
                    fail(responseMessage)
                }
            }else {
                fail(responseMessage)
            }
            return
        }
        fail(nil)
        return
    })
}
