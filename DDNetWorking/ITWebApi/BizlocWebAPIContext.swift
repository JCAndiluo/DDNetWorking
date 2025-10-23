import Foundation

// MARK: Factory
open class BizlocWebAPIContext : ITWebAPIContext{
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
        				case "/bizloc/service/getServiceInfo":
				if type == .requestBody {
                    body = BizlocPostGetServiceInfo()
                } else {
                    body = BizlocRetGetServiceInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}
		
open class BizlocPostGetServiceInfo : BaseITWebAPIBody {
    
    //
    open var coordinate:String?
    open var coordType:String?
    open var type:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "21"
        self.appName_ = "bizloc"
        self.mapping_ = "/api/bizloc/service/getServiceInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "21"
        self.appName_ = "bizloc"
        self.mapping_ = "/api/bizloc/service/getServiceInfo"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let coordinate_ = self.coordinate;
        let coordType_ = self.coordType;
        let type_ = self.type;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("coordinate=" + (coordinate_ ?? ""))
        md5.append("&coordType=" + (coordType_ ?? ""))
        md5.append("&type=" + (type_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizlocPostGetServiceInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizlocPostGetServiceInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizlocRetGetServiceInfo : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var cityCode:String?
    open var serviceName:String?
    open var serviceType:String?
    open var serviceLeftMenu:String?
    
    required public init(){
        super.init()
        self.appId_ = "21"
        self.appName_ = "bizloc"
        self.mapping_ = "/api/bizloc/service/getServiceInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "21"
        self.appName_ = "bizloc"
        self.mapping_ = "/api/bizloc/service/getServiceInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        serviceId = visitableSource.getValue("serviceId")
        cityCode = visitableSource.getValue("cityCode")
        serviceName = visitableSource.getValue("serviceName")
        serviceType = visitableSource.getValue("serviceType")
        serviceLeftMenu = visitableSource.getValue("serviceLeftMenu")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
