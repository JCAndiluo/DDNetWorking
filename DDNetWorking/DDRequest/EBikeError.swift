//
//  EBikeError.swift
//  EBikeModel
//
//  Created by 吴知洋 on 16/3/10.
//  Copyright © 2016年 杭州艾拓. All rights reserved.
//

import Foundation

@MainActor 
public struct Err {
	// ----系统服务类----
	public static let OK = "0"
    public static let REQUEST_ERR    = "100"
	public static let ILLEGAL_ACCESS    = "101"
	public static let SECURE_KEY_ERR    = "102"
	public static let USER_NOT_LOGIN    = "103"
	public static let PARAM_VER_ERR     = "104"
	public static let INVALID_TOKEN     = "105"
	public static let OBJ_NOT_EXIST     = "106"
	public static let SERVER_ERR        = "107"
	public static let TOO_FREQUENT       = "108"
    public static let HAVE_SHARE       = "20006"  //已分享
    public static let HAVE_RIDE       = "20008"  //已骑行
    public static let OVER_TIMES       = "20001"  //次数超限
	public static let OTHER_ERR         = "109"
    public static let NotConnectedToInternet         = "-1009"
    public static let NO_SERVICE         = "99"
    
	// -----虚拟卡类----
    public static let CARD_NEW              = "1001"
    public static let CARD_OPEN_PAYING		= "1002"
    public static let CARD_VALID            = "1003"
	public static let CARD_RENT             = "1004"
    public static let CARD_OVERTIME_PAYING  = "1005"
    public static let CARD_LOGOFF           = "1006"
    public static let CARD_LOST             = "1007"
    public static let CARD_LOCK             = "1008"
    public static let CARD_NOT_EXIST        = "1009"
 
    // -----支付类----
    public static let ORDER_NOT_EXIST		= "1010"
    public static let ORDER_IS_NEW			= "1011"
    public static let ORDER_IS_COMMIT		= "1012"
    public static let ORDER_IS_FINISHED		= "1013"
    public static let ORDER_IS_CANCELED		= "1014"
    public static let ORDER_CRT_CHARGE_ERR	= "1015"
    public static let ORDER_LOGOUT_FAILED	= "1016"
    
    //-----租车业务类----
    public static let OPER_NOBIKE           = "2002"
    public static let OPER_UNLOCK_ERR		= "2003"
    public static let OPER_OFFLINE          = "2004"
    public static let OPER_CITY_ERR         = "2005"
    public static let OPER_PARKNUM_ERR      = "2006"
    public static let OPER_SITENUM_ERR      = "2007"
    public static let OPER_PARK_ERR         = "2008"
    public static let OPER_OUT_TIME 		= "2009"
    
    //-----用户登录类----
    public static let USERNAME_NULL         = "3001"
    public static let USER_NOT_EXISTS		= "3002"
    public static let USER_LOCKED           = "3003"
    public static let USER_BLACKLIST        = "3004"
    public static let PWD_FAIL              = "3005"
    public static let VCODE_SEND_FAIL       = "3006"
    public static let PHONE_BLACKLIS        = "3007"
    public static let PHONE_REGISTERED 		= "3008"
    public static let PHONE_UNREGISTER 		= "3009"
    public static let VCODE_FAIL 		    = "3010"
    public static let USERSTOKEN_FAIL 		= "3011"
    public static let PHONE_NOT_EXISTS 		= "3012"
    
    //---蓝牙状态---锁状态
    public static let BHT_AVAILABLE        =  "4000"  //可用
    public static let BHT_LOCK_UNLOCK      =  "4001"  //锁开，已租车，可还车，可临时停车
    public static let BHT_LOCK_LOCKED      =  "4002"  //锁闭，已还车，可租车
    public static let BHT_LOCK_TEMP        =  "4003"  //锁闭，临时停车
    public static let BHT_BATTERY_LOW      =  "4006"  //电量低
    public static let BHT_DEVICE_NOTEXIST  =  "4007"  //设备未入库，不存在
    public static let BHT_DEVICE_ERROR     =  "4008"  //设备异常
    public static let BHT_OTHER_ERROR      =  "4009"  //其他错误
    

    // 续租
    public static let RELETE_OUT_TIME    =   "5001" //续租超出限制
    
    
    public static let YJBIKE_ERROR = "40009"
    
    //
    
	public static let GobalReturnInfo : [String: ITReturnInfo] = {
		return [
//            Err.OK: ITReturnInfo(Err.OK, "OK"),
//            Err.ILLEGAL_ACCESS: ITReturnInfo(Err.ILLEGAL_ACCESS, "与叮嗒失联，请重新登录"),
//            Err.SECURE_KEY_ERR: ITReturnInfo(Err.SECURE_KEY_ERR, "服务异常，稍后尝试"),
//            Err.USER_NOT_LOGIN: ITReturnInfo(Err.USER_NOT_LOGIN, "请先登录"),
//            Err.PARAM_VER_ERR: ITReturnInfo(Err.PARAM_VER_ERR, "参数校验失败"),
//            Err.INVALID_TOKEN: ITReturnInfo(Err.INVALID_TOKEN, "请重试登录"),
//            Err.OBJ_NOT_EXIST: ITReturnInfo(Err.OBJ_NOT_EXIST, "系统异常"),
//            Err.SERVER_ERR: ITReturnInfo(Err.SERVER_ERR, "对象不存在"),
//            Err.REQUEST_ERR: ITReturnInfo(Err.REQUEST_ERR, "网络开小差，稍后重试"),
//            Err.OTHER_ERR: ITReturnInfo(Err.OTHER_ERR, "网络开小差，稍后重试"),
//            Err.NotConnectedToInternet: ITReturnInfo(Err.NotConnectedToInternet, "未连接网络，请开启网络"),
//            
//            Err.HAVE_SHARE: ITReturnInfo(Err.HAVE_SHARE, "已分享"),
//            Err.HAVE_RIDE: ITReturnInfo(Err.HAVE_RIDE, "已骑行"),
//            Err.OVER_TIMES: ITReturnInfo(Err.OVER_TIMES, "验证码次数超限，请明天尝试"),
//            // -----虚拟卡类----
//            Err.CARD_NEW: ITReturnInfo(Err.CARD_NEW, "新建"), 
//            Err.CARD_OPEN_PAYING: ITReturnInfo(Err.CARD_OPEN_PAYING, "业务开通支付中"),
//            Err.CARD_VALID: ITReturnInfo(Err.CARD_VALID, "有效"), 
//            Err.CARD_RENT : ITReturnInfo(Err.CARD_RENT, "您当前账号已租车"),
//            Err.CARD_OVERTIME_PAYING : ITReturnInfo(Err.CARD_OVERTIME_PAYING, "租车超时支付中"), 
//            Err.CARD_LOGOFF : ITReturnInfo(Err.CARD_LOGOFF, "已注销"), 
//            Err.CARD_LOST : ITReturnInfo(Err.CARD_LOST, "已挂失"), 
//            Err.CARD_LOCK : ITReturnInfo(Err.CARD_LOCK, "账户锁定"), 
//            Err.CARD_NOT_EXIST : ITReturnInfo(Err.CARD_NOT_EXIST, "用户不存在"), 
//            Err.NO_SERVICE   :ITReturnInfo(Err.NO_SERVICE,"该城市未开通服务，请检查您的定位"),
//            // -----支付类----
//            Err.ORDER_NOT_EXIST        :ITReturnInfo(Err.ORDER_NOT_EXIST,"该订单失联，请稍后尝试"),
//            Err.ORDER_IS_NEW        :ITReturnInfo(Err.ORDER_IS_NEW,"订单已创建"),
//            Err.ORDER_IS_COMMIT        :ITReturnInfo(Err.ORDER_IS_COMMIT,"订单已提交"),
//            Err.ORDER_IS_FINISHED    :ITReturnInfo(Err.ORDER_IS_FINISHED,"订单已完成"),
//            Err.ORDER_IS_CANCELED    :ITReturnInfo(Err.ORDER_IS_CANCELED,"订单已取消"),
//            Err.ORDER_CRT_CHARGE_ERR    :ITReturnInfo(Err.ORDER_CRT_CHARGE_ERR,"暂时失联，请稍后重试"),
//            Err.ORDER_LOGOUT_FAILED    :ITReturnInfo(Err.ORDER_LOGOUT_FAILED,"暂时失联，重试看看"),
//            
//            //-----租车业务类----
//            Err.OPER_NOBIKE     :ITReturnInfo(Err.OPER_NOBIKE,"选中桩位没有车辆，试试其他桩位吧"),
//            Err.OPER_UNLOCK_ERR    :ITReturnInfo(Err.OPER_UNLOCK_ERR,"啊哦，开锁失败，重试看看"),
//            Err.OPER_OFFLINE    :ITReturnInfo(Err.OPER_OFFLINE,"桩位断线，请您换个桩位租车"),
//            Err.OPER_CITY_ERR        :ITReturnInfo(Err.OPER_CITY_ERR,"啊哦，定位与所在城市不匹配，不可租车哦"),
//            Err.OPER_PARKNUM_ERR    :ITReturnInfo(Err.OPER_PARKNUM_ERR,"车位不存在，请您换个车位试试"),
//            Err.OPER_SITENUM_ERR    :ITReturnInfo(Err.OPER_SITENUM_ERR,"抱歉，本站点暂不可提供服务，试试其他站点吧"),
//            Err.OPER_PARK_ERR        :ITReturnInfo(Err.OPER_PARK_ERR,"啊哦，您选择的桩位不存在，重选看看"),
//            Err.OPER_OUT_TIME         :ITReturnInfo(Err.OPER_OUT_TIME,"抱歉，不在服务时间内，下次要早点哦"),
//        
//            //-----用户登录类----
//            Err.USERNAME_NULL         :ITReturnInfo(Err.USERNAME_NULL,"用户账户不能为空"),
//            Err.USER_NOT_EXISTS     :ITReturnInfo(Err.USER_NOT_EXISTS,"用户不存在"),
//            Err.USER_LOCKED         :ITReturnInfo(Err.USER_LOCKED,"用户已锁定"),
//            Err.USER_BLACKLIST       :ITReturnInfo(Err.USER_BLACKLIST,"用户手机黑名单"),
//            Err.PWD_FAIL             :ITReturnInfo(Err.PWD_FAIL,"密码错误"),
//            Err.VCODE_SEND_FAIL     :ITReturnInfo(Err.VCODE_SEND_FAIL,"验证码发送失败，请尝试语音验证码"),
//            Err.PHONE_BLACKLIS      :ITReturnInfo(Err.PHONE_BLACKLIS,"手机号黑名单"),
//            Err.PHONE_REGISTERED     :ITReturnInfo(Err.PHONE_REGISTERED,"手机号已注册"),
//            Err.PHONE_UNREGISTER     :ITReturnInfo(Err.PHONE_UNREGISTER,"手机号未注册"),
//            Err.VCODE_FAIL          :ITReturnInfo(Err.VCODE_FAIL,"验证码不匹配"),
//            Err.USERSTOKEN_FAIL     :ITReturnInfo(Err.USERSTOKEN_FAIL,"用户令牌不匹配"),
//            Err.PHONE_NOT_EXISTS     :ITReturnInfo(Err.PHONE_NOT_EXISTS,"手机号不存在"),
//          
//            //续租
//            Err.RELETE_OUT_TIME   :ITReturnInfo(Err.RELETE_OUT_TIME,"今日延时还车次数已用完，请明天尝试"),
            
            Err.YJBIKE_ERROR : ITReturnInfo(Err.YJBIKE_ERROR, "车辆信息获取失败")
		]
	}()

    private static func get(_ retCode: String?, _ detial: String?) -> ITReturnInfo {
        
        if retCode == "105" {   // 无效token，需要退出登录
            DispatchQueue.main.async {
//                DDMomentTipView.showTip("登录信息已失效，请重新登录", closure: nil)
//                NotificationCenter.default.post(name: DDUserLogoutNotify, object: nil)
            }
        }
        NSLog(retCode!+"===retMsg==="+detial!)
        return retCode == nil ? ITReturnInfo.init("-1", "异常请求", detail: "异常请求") : ((GobalReturnInfo[retCode!] == nil ? ITReturnInfo.init(retCode!, detial!, detail: detial) :  GobalReturnInfo[retCode!])!)
	}
    

    public static func get(_ retCode: String?,detial:String? = "",isRelet: Bool = false) -> ITReturnInfo {
        
        if isRelet {
           let retinf = ITReturnInfo.init(retCode!, detial!, detail: detial)
           return retinf
        }else{
            let returnInfo = get(retCode, detial)
            returnInfo.detail = detial
            return returnInfo
        }
    }
    
    public static func getError(_ retCode: String?,_ retMsg:String?) -> ITReturnInfo {
        return ITReturnInfo(retCode!, retMsg!)
    }
}
