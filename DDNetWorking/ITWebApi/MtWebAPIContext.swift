import Foundation

// MARK: Factory
open class MtWebAPIContext : ITWebAPIContext{
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
        case "/bikemt/manager/sysinfo":
            if type == .requestBody {
                body = postSysInfo()
            } else {
                body = retSysInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikemt/business/citylistinfo":
            if type == .requestBody {
                body = MtpostCityListInfo()
            } else {
                body = MtretCityListInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        default:
            body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

open class postSysInfo : BaseITWebAPIBody {
    
    open var appid:String?
    
    required public init(){
        super.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/manager/sysinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/manager/sysinfo"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_session } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appid_ = self.appid;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appid=" + (appid_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"postSysInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"appid",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:appid_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"appid",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:2,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"postSysInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class retSysInfo : BaseITWebAPIBody {
    
    open var bizlistver:String?
    open var appver:String?
    open var suminfo:String?
    open var anncId:String?
    open var title:String?
    open var content:String?
    open var createTime:String?
    open var type:String?
    
    required public init(){
        super.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/manager/sysinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/manager/sysinfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizlistver = visitableSource.getValue("bizlistver")
        appver = visitableSource.getValue("appver")
        suminfo = visitableSource.getValue("suminfo")
        anncId = visitableSource.getValue("anncId")
        title = visitableSource.getValue("title")
        content = visitableSource.getValue("content")
        createTime = visitableSource.getValue("createTime")
        type = visitableSource.getValue("type")
    }
    
    //-------> one-to-many
    override open var serverMode:ITSeverMode { get { return .sermode_no_session } }
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class MtpostCityListInfo : BaseITWebAPIBody {
    
    //
    open var appid:String?
    open var businesstype:String?
    
    required public init(){
        super.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_session } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appid_ = self.appid;
        let businesstype_ = self.businesstype;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"MtpostCityListInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appid",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appid_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appid",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"businesstype",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:businesstype_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"businesstype",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"MtpostCityListInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class MtretCityListInfo : BaseITWebAPIBody {
    
    //
    open var citylistver:String?
    //----->one-to-manay
    open var data = [MtCityList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        citylistver = visitableSource.getValue("citylistver")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( MtCityList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addMtCityList(subBody:MtCityList) -> Void{
        data.append(subBody)
    }
    
    open func getMtCityList() -> [MtCityList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_session } }
    
    
    open func isRequestBody() -> Bool{
        return false
    }

}

open class MtCityList : BaseITWebAPIBody {
    
    //
    open var cityver:String?
    open var cityid:String?
    open var tenantid:String?
    open var cityname:String?
    open var citycode:String?
    open var carrierid:String?
    open var serviceinfo:String?
    open var paykey:String?
    open var pricekey:String?
    open var certifykey:String?
    open var reletkey:String?
    
    required public init(){
        super.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "27"
        self.appName_ = "mt"
        self.mapping_ = "/bikemt/business/citylistinfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        cityver = visitableSource.getValue("cityver")
        cityid = visitableSource.getValue("cityid")
        tenantid = visitableSource.getValue("tenantid")
        cityname = visitableSource.getValue("cityname")
        citycode = visitableSource.getValue("citycode")
        carrierid = visitableSource.getValue("carrierid")
        serviceinfo = visitableSource.getValue("serviceinfo")
        paykey = visitableSource.getValue("paykey")
        pricekey = visitableSource.getValue("pricekey")
        certifykey = visitableSource.getValue("certifykey")
        reletkey = visitableSource.getValue("reletkey")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_session } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


