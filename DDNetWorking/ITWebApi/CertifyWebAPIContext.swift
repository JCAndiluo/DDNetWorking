import Foundation

// MARK: Factory
open class CertifyWebAPIContext : ITWebAPIContext{
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
        case "/certification/user/certify":
            if type == .requestBody {
                body = CertifyPostCertify()
            } else {
                body = CertifyRetCertify(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/certification/user/getCertInfo":
            if type == .requestBody {
                body = CertifyPostGetCertInfo()
            } else {
                body = CertifyRetGetCertInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/certification/user/isCertified":
            if type == .requestBody {
                body = CertifyPostIsCertified()
            } else {
                body = CertifyRetIsCertified(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/certification/user/whiteListStatus":
            if type == .requestBody {
                body = CertifyPostWhiteListStatus()
            } else {
                body = CertifyRetWhiteListStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/certification/config/listCertConfig":
            if type == .requestBody {
                body = CertifyPostListCertConfig()
            } else {
                body = CertifyRetListCertConfig(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/certification/user/authorizedlogin":
            if type == .requestBody {
                body = CertifyPostAuthorizedlogin()
            } else {
                body = CertifyRetAuthorizedlogin(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/certification/user/passport":
        if type == .requestBody {
            body = CertifyPostPassport()
        } else {
            body = CertifyRetPassport(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
        }
        break
        default:
            body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}



open class CertifyPostCertify : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var userId:String?
    open var realName:String?
    open var phoneNo:String?
    open var cardNo:String?
    open var idCard:String?
    open var params:String?
    open var channel:String?
    open var certAddr:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/certify"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/certify"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
        let userId_ = secureKeys?["AES"]?.encrypt(original: self.userId) ?? ""
        let realName_ = secureKeys?["AES"]?.encrypt(original: self.realName) ?? ""
        let phoneNo_ = secureKeys?["AES"]?.encrypt(original: self.phoneNo) ?? ""
        let cardNo_ = secureKeys?["AES"]?.encrypt(original: self.cardNo) ?? ""
        let idCard_ = secureKeys?["AES"]?.encrypt(original: self.idCard) ?? ""
        let params_ = secureKeys?["AES"]?.encrypt(original: self.params) ?? ""
        let channel_ = secureKeys?["AES"]?.encrypt(original: self.channel) ?? ""
        let certAddr_ = secureKeys?["AES"]?.encrypt(original: self.certAddr) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&userId=" + (userId_ ?? ""))
        md5.append("&realName=" + (realName_ ?? ""))
        md5.append("&phoneNo=" + (phoneNo_ ?? ""))
        md5.append("&cardNo=" + (cardNo_ ?? ""))
        md5.append("&idCard=" + (idCard_ ?? ""))
        md5.append("&params=" + (params_ ?? ""))
        md5.append("&channel=" + (channel_ ?? ""))
        md5.append("&certAddr=" + (certAddr_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostCertify",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:12,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:12,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:12,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:12,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:12,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:12,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:12,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:12,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:12,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:12,field:"userId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:12,value:userId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:12,field:"userId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:12,field:"realName",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:12,value:realName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:12,field:"realName",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:12,field:"phoneNo",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:12,value:phoneNo_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:12,field:"phoneNo",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:12,field:"cardNo",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:12,value:cardNo_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:12,field:"cardNo",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:12,field:"idCard",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:12,value:idCard_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:12,field:"idCard",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:12,field:"params",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:12,value:params_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:12,field:"params",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:12,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:12,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:12,field:"channel",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:12,field:"certAddr",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:12,value:certAddr_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:12,field:"certAddr",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:12,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:12,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:12,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostCertify",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class CertifyRetCertify : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/certify"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/certify"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class CertifyPostGetCertInfo : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var channel:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
        let channel_ = secureKeys?["AES"]?.encrypt(original: self.channel) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&channel=" + (channel_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostGetCertInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostGetCertInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class CertifyRetGetCertInfo : BaseITWebAPIBody {
    
    //
    open var dataCount:String?
    //----->one-to-manay
    var data = [CertifyCertInfoDetail]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        dataCount = visitableSource.getValue("dataCount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( CertifyCertInfoDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addCertifyCertInfoDetail(subBody:CertifyCertInfoDetail) -> Void{
        data.append(subBody)
    }
    
    open func getCertifyCertInfoDetail() -> [CertifyCertInfoDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
   
}
open class CertifyCertInfoDetail : BaseITWebAPIBody {
    
    //
    open var realName:String?
    open var phoneNo:String?
    open var idCard:String?
    open var channel:String?
    open var certStatus:String?
    open var handleStatus:String?
    open var params:String?
    open var certTime:String?
    open var mobileCardSta:String?
    open var validBeginDate:String?
    open var validEndDate:String?
    open var validPeriod:String?
    open var bindId:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/getCertInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        realName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("realName"))
        phoneNo = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("phoneNo"))
        idCard = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("idCard"))
        channel = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("channel"))
        certStatus = visitableSource.getValue("certStatus")
        handleStatus = visitableSource.getValue("handleStatus")
        params = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("params"))
        certTime = visitableSource.getValue("certTime")
        mobileCardSta = visitableSource.getValue("mobileCardSta")
        validBeginDate = visitableSource.getValue("validBeginDate")
        validEndDate = visitableSource.getValue("validEndDate")
        validPeriod = visitableSource.getValue("validPeriod")
        bindId = visitableSource.getValue("bindId")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class CertifyPostIsCertified : BaseITWebAPIBody {
    
    //
    open var channel:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/isCertified"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/isCertified"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let channel_ = secureKeys?["AES"]?.encrypt(original: self.channel) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("channel=" + (channel_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostIsCertified",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"channel",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:2,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostIsCertified",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class CertifyRetIsCertified : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/isCertified"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/isCertified"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class CertifyPostWhiteListStatus : BaseITWebAPIBody {
    
    //
    open var channel:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/whiteListStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/whiteListStatus"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let channel_ = secureKeys?["AES"]?.encrypt(original: self.channel) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&channel=" + (channel_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostWhiteListStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"channel",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostWhiteListStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class CertifyRetWhiteListStatus : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/whiteListStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/user/whiteListStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class CertifyPostListCertConfig : BaseITWebAPIBody {
    
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let appId_ = self.appId;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostListCertConfig",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostListCertConfig",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class CertifyRetListCertConfig : BaseITWebAPIBody {
    
    open var bizStatus:String?
    open var datacount:String?
    open var data = [CertifyCertConfig]()
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizStatus = visitableSource.getValue("bizStatus")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( CertifyCertConfig (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:CertifyCertConfig) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [CertifyCertConfig]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }

}

open class CertifyCertConfig : BaseITWebAPIBody {
    
    open var name:String?
    open var value:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/certification/config/listCertConfig"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        name = visitableSource.getValue("name")
        value = visitableSource.getValue("value")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class CertifyPostAuthorizedlogin : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/authorizedlogin"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/authorizedlogin"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostAuthorizedlogin",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostAuthorizedlogin",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class CertifyRetAuthorizedlogin : BaseITWebAPIBody {
    
    //
    open var version:String?
    open var appId:String?
    open var signType:String?
    open var signkeyIndex:String?
    open var sign:String?
    open var timestamp:String?
    open var userNo:String?
    open var phoneNumber:String?
    
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/authorizedlogin"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/authorizedlogin"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        version = visitableSource.getValue("version")
        appId = visitableSource.getValue("appId")
        signType = visitableSource.getValue("signType")
        signkeyIndex = visitableSource.getValue("signkeyIndex")
        sign = visitableSource.getValue("sign")
        timestamp = visitableSource.getValue("timestamp")
        userNo = visitableSource.getValue("userNo")
        phoneNumber = visitableSource.getValue("phoneNumber")
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class CertifyPostPassport : BaseITWebAPIBody {
    
    //
                                    open var appId:String?
                                open var serviceId:String?
                                open var userId:String?
                                open var passport:String?
            
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/passport"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/passport"
            }

    //-------> list
                                                                
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

        override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

        //====encrypt field====
                                                        let accessToken_ = self.accessToken;
                                                                                    let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
                                                                                    let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
                                                                                    let userId_ = secureKeys?["AES"]?.encrypt(original: self.userId) ?? ""
                                                                                    let passport_ = secureKeys?["AES"]?.encrypt(original: self.passport) ?? ""
                                    
        //====   md5 check   ====
                    var md5:[String] = []
                                                            md5.append("accessToken=" + (accessToken_ ?? ""))
                                                                                    md5.append("&appId=" + (appId_ ?? ""))
                                                                                    md5.append("&serviceId=" + (serviceId_ ?? ""))
                                                                                    md5.append("&userId=" + (userId_ ?? ""))
                                                                                    md5.append("&passport=" + (passport_ ?? ""))
                                                        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CertifyPostPassport",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"appId",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:6,value:appId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"appId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"serviceId",body:self))
                result.append(vo.onFieldValue(.flat,index:3,length:6,value:serviceId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"serviceId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"userId",body:self))
                result.append(vo.onFieldValue(.flat,index:4,length:6,value:userId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"userId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"passport",body:self))
                result.append(vo.onFieldValue(.flat,index:5,length:6,value:passport_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"passport",body:self))
                                    result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
                result.append(vo.onObjectEnd(index,length:length,objname:"CertifyPostPassport",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

open class CertifyRetPassport : BaseITWebAPIBody {
    
    //
                            
    required public init(){
        super.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/passport"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "42"
        self.appName_ = "certify"
        self.mapping_ = "/api/certification/user/passport"
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
