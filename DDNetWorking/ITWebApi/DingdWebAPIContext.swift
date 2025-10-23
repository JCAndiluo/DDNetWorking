import Foundation

// MARK: Factory
open class DingdWebAPIContext : ITWebAPIContext{
	required public init(){}
    open var visitablePair:ITVisitablePair = ITXmlVisitablePair()
    fileprivate var secureKeys = [String:ITSecureKey]()
    open func setSecureKey(_ secureKey:ITSecureKey?) -> ITWebAPIContext?{
        if let secureKey_ = secureKey {
            secureKeys[secureKey_.name] = secureKey_
        }
        return self
    }

    open func getSecureKey(_ keyName:String) -> ITSecureKey? {
        return self.secureKeys[keyName]
    }

    open func getSecureKeys() -> [String:ITSecureKey]? {
        return self.secureKeys
    }

    open func createRequestBody(_ requestMapping:String) -> ITWebAPIBody {
        return self.createBody(type: .requestBody, requestMapping: requestMapping, content: nil, secureKeys: self.secureKeys)
    }
    open func createRequestBody(_ requestMapping:String,content:String?) -> ITWebAPIBody {
        return self.createBody(type: .requestBody, requestMapping: requestMapping, content: content, secureKeys: self.secureKeys)
    }
    open func createRequestBody(_ requestMapping:String,content:String?,secureKey:ITSecureKey?) -> ITWebAPIBody{
        if secureKey == nil {
            return self.createBody(type: .requestBody, requestMapping: requestMapping, content: content, secureKeys: self.secureKeys)
        }

        return self.createBody(type: .requestBody, requestMapping: requestMapping, content: content, secureKeys: [secureKey!.name:secureKey!])
    }

    open func createResponseBody(_ requestMapping:String) -> ITWebAPIBody {
        return self.createBody(type: .responseBody, requestMapping: requestMapping, content: nil, secureKeys: self.secureKeys)
    }
    open func createResponseBody(_ requestMapping:String,content:String?) -> ITWebAPIBody {
        return self.createBody(type: .responseBody, requestMapping: requestMapping, content: content, secureKeys: self.secureKeys)
    }
    open func createResponseBody(_ requestMapping:String,content:String?,secureKey:ITSecureKey?) -> ITWebAPIBody {
        if secureKey == nil {
            return self.createBody(type: .responseBody, requestMapping: requestMapping, content: content, secureKeys: self.secureKeys)
        }

        return self.createBody(type: .responseBody, requestMapping: requestMapping, content: content, secureKeys: [secureKey!.name:secureKey!])
    }

    fileprivate enum BodyType{
        case requestBody
        case responseBody
    }

    fileprivate func createBody(type:BodyType,requestMapping:String,content:String?,secureKeys:[String:ITSecureKey]) -> ITWebAPIBody{
        var body:ITWebAPIBody
        switch(requestMapping){
        case "/api/dingd/redpac/redpacWdraw":
            if type == .requestBody {
                body = DingdPostRedpacWdraw()
            } else {
                body = DingdRetRedpacWdraw(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/dingd/business/newUserRecCoupon":
            if type == .requestBody {
                body = DingdPostNewUserRecCoupon()
            } else {
                body = DingdRetNewUserRecCoupon(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/dingd/purchase/userBuyYearCard":
            if type == .requestBody {
                body = DingdPostUserBuyYearCard()
            } else {
                body = DingdRetUserBuyYearCard(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

open class DingdPostRedpacWdraw : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var money:String?
    open var withdrawAccount:String?
    open var userName:String?
    open var accountFalg:String?
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/redpac/redpacWdraw"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/redpac/redpacWdraw"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let serviceId_ = self.serviceId;
        let money_ = self.money;
        let withdrawAccount_ = self.withdrawAccount;
        let userName_ = self.userName;
        let accountFalg_ = self.accountFalg;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"DingdPostRedpacWdraw",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"money",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:money_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"money",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"withdrawAccount",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:withdrawAccount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"withdrawAccount",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"userName",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:userName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"userName",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"accountFalg",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:accountFalg_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"accountFalg",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"DingdPostRedpacWdraw",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class DingdRetRedpacWdraw : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/redpac/redpacWdraw"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/redpac/redpacWdraw"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class DingdPostNewUserRecCoupon : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var couponType:String?
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/business/newUserRecCoupon"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/business/newUserRecCoupon"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let serviceId_ = self.serviceId;
        let couponType_ = self.couponType;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"DingdPostNewUserRecCoupon",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"couponType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:couponType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"couponType",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"DingdPostNewUserRecCoupon",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class DingdRetNewUserRecCoupon : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/business/newUserRecCoupon"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/business/newUserRecCoupon"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class DingdPostUserBuyYearCard : BaseITWebAPIBody {
    
    //
    open var yearCardId:String?
    open var appId:String?
    open var serviceId:String?
    open var bizType:String?
    open var terminalType:String?
    open var walletConfigId:String?
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/purchase/userBuyYearCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/purchase/userBuyYearCard"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let yearCardId_ = self.yearCardId;
        let appId_ = self.appId;
        let serviceId_ = self.serviceId;
        let bizType_ = self.bizType;
        let terminalType_ = self.terminalType;
        let walletConfigId_ = self.walletConfigId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"DingdPostUserBuyYearCard",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:8,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"yearCardId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:8,value:yearCardId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"yearCardId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:8,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:8,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:8,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:8,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"walletConfigId",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:8,value:walletConfigId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"walletConfigId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"DingdPostUserBuyYearCard",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class DingdRetUserBuyYearCard : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var orderId:String?
    
    required public init(){
        super.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/purchase/userBuyYearCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "53"
        self.appName_ = "dingd"
        self.mapping_ = "/api/dingd/purchase/userBuyYearCard"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        orderId = visitableSource.getValue("orderId")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
