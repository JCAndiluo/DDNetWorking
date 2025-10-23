//
//  ITWebAPIContext.swift
//  ITWebAPI
//
//  Created by 吴知洋 on 16/2/24.
//  Copyright © 2016年 杭州艾拓. All rights reserved.
//

import Foundation
import Alamofire
public enum ITSeverMode{
    case sermode_normal
    case sermode_no_session
    case sermode_no_login
    case sermode_no_token
}
public protocol ITWebAPIBody :NSObjectProtocol{
    //构造函数
    init()
    init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey])
    
    var context: ITWebAPIContext? { get set}
    var isValid: Bool { get }
    
    //
    var retcode : String? { get set }
    var retmsg : String? { get set }
    var clientid : String? { get set }
    
    //
    var appId_: String{ get }
    var appName_: String{ get }
    var mapping_: String{ get }
    
    //
    var accessToken : String? { get set }
    var successful : Bool { get }
    /**
     ** serverMode 服务端处理模式
     **	noSession	不用建立session连接，该接口可直接访问，数据不能加密，明码传输
     **	noLogin		用户不用登录，建立session连接后可以访问，数据可以加密传输
     **	noToken		针对网关服务，可以直接访问，服务端不检查访问令牌，数据对称加密
     */
    var serverMode:ITSeverMode { get }
    var checkSession: Bool { get }
    var checkLogin: Bool { get }
    var checkAccessToken : Bool { get }
    
    //消息序列化加密
    func encode() -> String?
    
    func encode(_ visitableObject:ITVisitableObject?) -> String?
    
    func encode(_ secureKey:ITSecureKey?) -> String?
    
    func encode(_ visitableObject:ITVisitableObject?,secureKey:ITSecureKey?) ->String?
    
    
    
    
}

public protocol ITWebAPIContext{
    // 数据访问设置
    var visitablePair:ITVisitablePair { get set }
    
    // 密钥设置
    func setSecureKey(_ secureKey:ITSecureKey?) -> ITWebAPIContext?
    func getSecureKey(_ keyName:String) -> ITSecureKey?
    func getSecureKeys() -> [String:ITSecureKey]?
    
    // 创建消息体
    func createRequestBody(_ requestMapping:String) -> ITWebAPIBody
    func createRequestBody(_ requestMapping:String,content:String?) -> ITWebAPIBody
    func createRequestBody(_ requestMapping:String,content:String?,secureKey:ITSecureKey?) -> ITWebAPIBody
    
    func createResponseBody(_ requestMapping:String) -> ITWebAPIBody
    func createResponseBody(_ requestMapping:String,content:String?) -> ITWebAPIBody
    func createResponseBody(_ requestMapping:String,content:String?,secureKey:ITSecureKey?) -> ITWebAPIBody

}

@MainActor 
open class ITReturnInfo :Error{
    open var detail:String?
    public let retCode:String
    public let retMsg:String
    
    convenience public init(_ retCode:String,_ retMsg:String){
        self.init(retCode,retMsg,detail:nil)
    }
    
    public init(_ retCode:String,_ retMsg:String,detail:String?){
        self.retCode = retCode
        self.retMsg = retMsg
        self.detail = detail
    }
    open var successful :Bool { get { return self.retCode == "0" } }
}

//MARK: WebAPIBody

open class BaseITWebAPIBody: NSObject, ITWebAPIBody {

    public var mapping_: String
    public var appName_: String
    public var appId_: String

    open var context: ITWebAPIContext?
    
    public required override init() {
        
        mapping_ = ""
        appName_ = ""
        appId_ = ""
    }
    public required init(visitableSource: ITVisitableSource, secureKeys: [String: ITSecureKey]) {
        
        mapping_ = ""
        appName_ = ""
        appId_ = ""
    }
    
    open var valid: Bool = true
    open var isValid: Bool { get { return valid } }
    
    open var retcode: String?
    open var retmsg: String?
    open var clientid: String?
    open var accessToken: String? {
        willSet {
            UserDefaults.standard.set(newValue, forKey: kAccessTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
    open var successful: Bool { get { return retcode == "0" } }
    
    open var serverMode: ITSeverMode { get { return .sermode_normal } }
    open var checkSession: Bool { get { return self.serverMode != .sermode_no_session } }
    open var checkLogin: Bool { get { return self.checkSession && self.serverMode != .sermode_no_login } }
    open var checkAccessToken: Bool { get { return self.serverMode != .sermode_no_token } }
    
    open func encode() -> String? {
        return self.encode(1, length: 1, visitableObject: context?.visitablePair.getVisitableObject(), secureKeys: context?.getSecureKeys())
    }
    
    open func encode(_ visitableObject: ITVisitableObject?) -> String? {
        return self.encode(1, length: 1, visitableObject: visitableObject, secureKeys: context?.getSecureKeys())
    }
    
    open func encode(_ secureKey: ITSecureKey?) -> String? {
        var secureKeys = [String: ITSecureKey]()
        if let secureKeyName = secureKey?.name {
            secureKeys[secureKeyName] = secureKey
        }
        return self.encode(1, length: 1, visitableObject: context?.visitablePair.getVisitableObject(), secureKeys: secureKeys)
    }
    
    open func encode(_ visitableObject: ITVisitableObject?, secureKey: ITSecureKey?) -> String? {
        var secureKeys = [String: ITSecureKey]()
        if let secureKeyName = secureKey?.name {
            secureKeys[secureKeyName] = secureKey
        }
        return self.encode(1, length: 1, visitableObject: visitableObject, secureKeys: secureKeys)
    } 
    
    open func encode(_ index: UInt8, length: UInt8, visitableObject: ITVisitableObject?, secureKeys: [String: ITSecureKey]?) -> String? {
        return nil
    } 
}
