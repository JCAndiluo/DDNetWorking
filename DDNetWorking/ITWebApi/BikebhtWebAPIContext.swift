import Foundation

// MARK: Factory
open class BikebhtWebAPIContext : ITWebAPIContext{
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
        case "/bikebht/business/bhtrequest":
            if type == .requestBody {
                body = BikebhtPostBhtRequest()
            } else {
                body = BikebhtRetBhtRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikebht/device/bhttrip":
            if type == .requestBody {
                body = BikebhtPostBHTTrip()
            } else {
                body = BikebhtRetBHTTrip(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikebht/business/bhtquerydevices":
            if type == .requestBody {
                body = BikebhtPostBHTQueryDevices()
            } else {
                body = BikebhtRetBHTQueryDevices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikebht/device/getbhtlock":
            if type == .requestBody {
                body = BikebhtPostBhtDevBasicInfo()
            } else {
                body = BikebhtRetBhtDevBasicInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikebht/device/getbhtlockinfo":
            if type == .requestBody {
                body = BikebhtPostBhtLockInfo()
            } else {
                body = BikebhtRetBhtLockInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        default:
            body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}



open class BikebhtPostBhtRequest : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var terminalType:String?
    open var requestType:String?
    open var DeviceId:String?
    open var parkNum:String?
    open var cityCode:String?
    open var bizType:String?
    open var version:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtrequest"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtrequest"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let terminalType_ = secureKeys?["AES"]?.encrypt(original: self.terminalType) ?? ""
        let requestType_ = secureKeys?["AES"]?.encrypt(original: self.requestType) ?? ""
        let DeviceId_ = secureKeys?["AES"]?.encrypt(original: self.DeviceId) ?? ""
        let parkNum_ = secureKeys?["AES"]?.encrypt(original: self.parkNum) ?? ""
        let cityCode_ = self.cityCode;
        let bizType_ = self.bizType;
        let version_ = self.version;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&terminalType=" + (terminalType_ ?? ""))
        md5.append("&requestType=" + (requestType_ ?? ""))
        md5.append("&DeviceId=" + (DeviceId_ ?? ""))
        md5.append("&parkNum=" + (parkNum_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikebhtPostBhtRequest",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:11,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:11,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:11,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:11,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:11,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:11,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:11,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:11,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:11,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:11,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:11,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:11,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:11,field:"requestType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:11,value:requestType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:11,field:"requestType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:11,field:"DeviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:11,value:DeviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:11,field:"DeviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:11,field:"parkNum",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:11,value:parkNum_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:11,field:"parkNum",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:11,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:11,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:11,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:11,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:11,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:11,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:11,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:11,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:11,field:"version",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:11,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:11,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:11,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikebhtPostBhtRequest",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}



open class BikebhtRetBhtRequest : BaseITWebAPIBody {
    
    //
    open var bizStatus:String?
    open var reqStatus:String?
    open var serviceId:String?
    open var orderId:String?
    open var operId:String?
    open var bikeId:String?
    open var reqExtra:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtrequest"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtrequest"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizStatus = visitableSource.getValue("bizStatus")
        reqStatus = visitableSource.getValue("reqStatus")
        serviceId = visitableSource.getValue("serviceId")
        orderId = visitableSource.getValue("orderId")
        operId = visitableSource.getValue("operId")
        bikeId = visitableSource.getValue("bikeId")
        reqExtra = visitableSource.getValue("reqExtra")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BikebhtPostBHTTrip : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var operId:String?
    open var dataType:String?
    open var cityCode:String?
    open var deviceId:String?
    open var deviceType:String?
    open var terminalType:String?
    open var lockStatus:String?
    open var coordinate:String?
    open var coordType:String?
    open var bizExtra:String?
    open var batteryLevel:String?
    open var deviceStakeId:String?
    open var version:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/device/bhttrip"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/device/bhttrip"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let operId_ = secureKeys?["AES"]?.encrypt(original: self.operId) ?? ""
        let dataType_ = self.dataType;
        let cityCode_ = self.cityCode;
        let deviceId_ = self.deviceId;
        let deviceType_ = self.deviceType;
        let terminalType_ = self.terminalType;
        let lockStatus_ = self.lockStatus;
        let coordinate_ = secureKeys?["AES"]?.encrypt(original: self.coordinate) ?? ""
        let coordType_ = self.coordType;
        let bizExtra_ = self.bizExtra;
        let batteryLevel_ = self.batteryLevel;
        let deviceStakeId_ = self.deviceStakeId;
        let version_ = self.version;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&operId=" + (operId_ ?? ""))
        md5.append("&coordinate=" + (coordinate_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikebhtPostBHTTrip",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:17,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:17,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:17,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:17,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:17,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:17,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:17,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:17,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:17,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:17,field:"operId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:17,value:operId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:17,field:"operId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:17,field:"dataType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:17,value:dataType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:17,field:"dataType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:17,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:17,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:17,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:17,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:17,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:17,field:"deviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:17,field:"deviceType",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:17,value:deviceType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:17,field:"deviceType",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:17,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:17,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:17,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:17,field:"lockStatus",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:17,value:lockStatus_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:17,field:"lockStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:17,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:17,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:17,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:17,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:17,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:17,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:17,field:"bizExtra",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:17,value:bizExtra_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:17,field:"bizExtra",body:self))
        result.append(vo.onFieldBegin(.flat,index:14,length:17,field:"batteryLevel",body:self))
        result.append(vo.onFieldValue(.flat,index:14,length:17,value:batteryLevel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:14,length:17,field:"batteryLevel",body:self))
        result.append(vo.onFieldBegin(.flat,index:15,length:17,field:"deviceStakeId",body:self))
        result.append(vo.onFieldValue(.flat,index:15,length:17,value:deviceStakeId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:15,length:17,field:"deviceStakeId",body:self))
        result.append(vo.onFieldBegin(.flat,index:16,length:17,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:16,length:17,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:16,length:17,field:"version",body:self))
        result.append(vo.onFieldBegin(.flat,index:17,length:17,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:17,length:17,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:17,length:17,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikebhtPostBHTTrip",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}



open class BikebhtRetBHTTrip : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var serviceId:String?
    open var operTime:String?
    open var orderId:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/device/bhttrip"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/device/bhttrip"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        serviceId = visitableSource.getValue("serviceId")
        operTime = visitableSource.getValue("operTime")
        orderId = visitableSource.getValue("orderId")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikebhtPostBHTQueryDevices : BaseITWebAPIBody {
    
    //
                        open var appId:String?
                                open var serviceId:String?
                                open var keyword:String?
                                open var coordinate:String?
                                open var coordType:String?
                                open var range:String?
                                open var type:String?
                                open var stationType:String?
            
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/business/bhtquerydevices"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/business/bhtquerydevices"
            }

    //-------> list
                                                                                                    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

        override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

        //====encrypt field====
                                                        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
                                                                                    let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
                                                                                    let keyword_ = secureKeys?["AES"]?.encrypt(original: self.keyword) ?? ""
                                                                                    let coordinate_ = secureKeys?["AES"]?.encrypt(original: self.coordinate) ?? ""
                                                                                    let coordType_ = secureKeys?["AES"]?.encrypt(original: self.coordType) ?? ""
                                                                                    let range_ = secureKeys?["AES"]?.encrypt(original: self.range) ?? ""
                                                                                    let type_ = self.type;
                                                                                    let stationType_ = self.stationType;
                                    
        //====   md5 check   ====
                    var md5:[String] = []
                                                            md5.append("appId=" + (appId_ ?? ""))
                                                                                    md5.append("&serviceId=" + (serviceId_ ?? ""))
                                                                                    md5.append("&keyword=" + (keyword_ ?? ""))
                                                                                    md5.append("&coordinate=" + (coordinate_ ?? ""))
                                                                                    md5.append("&coordType=" + (coordType_ ?? ""))
                                                                                    md5.append("&range=" + (range_ ?? ""))
                                                                                    md5.append("&type=" + (type_ ?? ""))
                                                                                    
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikebhtPostBHTQueryDevices",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"appId",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:9,value:appId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"appId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"serviceId",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:9,value:serviceId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"serviceId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"keyword",body:self))
                result.append(vo.onFieldValue(.flat,index:3,length:9,value:keyword_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"keyword",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"coordinate",body:self))
                result.append(vo.onFieldValue(.flat,index:4,length:9,value:coordinate_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"coordinate",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"coordType",body:self))
                result.append(vo.onFieldValue(.flat,index:5,length:9,value:coordType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"coordType",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"range",body:self))
                result.append(vo.onFieldValue(.flat,index:6,length:9,value:range_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"range",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"type",body:self))
                result.append(vo.onFieldValue(.flat,index:7,length:9,value:type_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"type",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"stationType",body:self))
                result.append(vo.onFieldValue(.flat,index:8,length:9,value:stationType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"stationType",body:self))
                                    result.append(vo.onFieldBegin(.flat,index:9,length:9,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:9,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:9,field:"sign",body:self))
                result.append(vo.onObjectEnd(index,length:length,objname:"BikebhtPostBHTQueryDevices",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

open class BikebhtRetBHTQueryDevices : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->one-to-manay
    var data = [BikebhtRetBHTQueryDevicesDetail]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtquerydevices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/bikebht/business/bhtquerydevices"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikebhtRetBHTQueryDevicesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBikebhtRetBHTQueryDevicesDetail(subBody:BikebhtRetBHTQueryDevicesDetail) -> Void{
        data.append(subBody)
    }
    
    open func getBikebhtRetBHTQueryDevicesDetail() -> [BikebhtRetBHTQueryDevicesDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
    open class BikebhtRetBHTQueryDevicesDetail : BaseITWebAPIBody {
        
        //
                            open var deviceId:String?
                                    open var cityCode:String?
                                    open var deviceName:String?
                                    open var coordinate:String?
                                    open var coordType:String?
                                    open var address:String?
                                    open var status:String?
                                    open var updatetime:String?
                                    open var totalcount:String?
                                    open var rentcount:String?
                                    open var restorecount:String?
                                    open var stationType:String?
                                    open var type:String?
                
        required public init(){
            super.init()
            self.appId_ = "38"
            self.appName_ = "bikebht"
            self.mapping_ = "/api/bikebht/business/bhtquerydevices"
        }

        required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
            self.init()
            self.appId_ = "38"
            self.appName_ = "bikebht"
            self.mapping_ = "/api/bikebht/business/bhtquerydevices"
                        //====   md5 check   ====
                if !String.isEmpty(visitableSource.getValue("sign")) {
                            }
                                                                            deviceId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceId"))
                                                                                                                cityCode = visitableSource.getValue("cityCode")
                                                                                                                deviceName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceName"))
                                                                                                                coordinate = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordinate"))
                                                                                                                coordType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordType"))
                                                                                                                address = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("address"))
                                                                                                                status = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("status"))
                                                                                                                updatetime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("updatetime"))
                                                                                                                totalcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("totalcount"))
                                                                                                                rentcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("rentcount"))
                                                                                                                restorecount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restorecount"))
                                                                                                                stationType = visitableSource.getValue("stationType")
                                                                                                                type = visitableSource.getValue("type")
                                                                }

        //-------> list
                                                                                                                                                                    
        override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

        
        open func isRequestBody() -> Bool{
            return false;
        }
        }
}

open class BikebhtPostBhtDevBasicInfo : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var cityCode:String?
    open var deviceType:String?
    open var version:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlock"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlock"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let deviceId_ = self.deviceId;
        let cityCode_ = self.cityCode;
        let deviceType_ = self.deviceType;
        let version_ = self.version;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikebhtPostBhtDevBasicInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"deviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"deviceType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:deviceType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"deviceType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"version",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikebhtPostBhtDevBasicInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikebhtRetBhtDevBasicInfo : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var deviceId:String?
    open var devName:String?
    open var devType:String?
    open var qrCode:String?
    open var cityCode:String?
    open var productSn:String?
    open var devSpec:String?
    open var devStatus:String?
    open var lifecycle:String?
    open var produceCom:String?
    open var hardVer:String?
    open var softVer:String?
    open var devMac:String?
    open var batteryCap:String?
    open var createor:String?
    open var onlineStatus:String?
    open var createTime:String?
    open var updateTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlock"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlock"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        deviceId = visitableSource.getValue("deviceId")
        devName = visitableSource.getValue("devName")
        devType = visitableSource.getValue("devType")
        qrCode = visitableSource.getValue("qrCode")
        cityCode = visitableSource.getValue("cityCode")
        productSn = visitableSource.getValue("productSn")
        devSpec = visitableSource.getValue("devSpec")
        devStatus = visitableSource.getValue("devStatus")
        lifecycle = visitableSource.getValue("lifecycle")
        produceCom = visitableSource.getValue("produceCom")
        hardVer = visitableSource.getValue("hardVer")
        softVer = visitableSource.getValue("softVer")
        devMac = visitableSource.getValue("devMac")
        batteryCap = visitableSource.getValue("batteryCap")
        createor = visitableSource.getValue("createor")
        onlineStatus = visitableSource.getValue("onlineStatus")
        createTime = visitableSource.getValue("createTime")
        updateTime = visitableSource.getValue("updateTime")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikebhtPostBhtLockInfo : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var qrCode:String?
    open var deviceId:String?
    open var cityCode:String?
    open var version:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlockinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlockinfo"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let serviceId_ = self.serviceId;
        let qrCode_ = self.qrCode;
        let deviceId_ = self.deviceId;
        let cityCode_ = self.cityCode;
        let version_ = self.version;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikebhtPostBhtLockInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"qrCode",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:qrCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"qrCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"deviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"version",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikebhtPostBhtLockInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikebhtRetBhtLockInfo : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var deviceId:String?
    open var devName:String?
    open var devType:String?
    open var qrCode:String?
    open var cityCode:String?
    open var productSn:String?
    open var devSpec:String?
    open var devStatus:String?
    open var lifecycle:String?
    open var produceCom:String?
    open var hardVer:String?
    open var softVer:String?
    open var devMac:String?
    open var batteryCap:String?
    open var createor:String?
    open var createTime:String?
    open var updateTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlockinfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "38"
        self.appName_ = "bikebht"
        self.mapping_ = "/api/bikebht/device/getbhtlockinfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        deviceId = visitableSource.getValue("deviceId")
        devName = visitableSource.getValue("devName")
        devType = visitableSource.getValue("devType")
        qrCode = visitableSource.getValue("qrCode")
        cityCode = visitableSource.getValue("cityCode")
        productSn = visitableSource.getValue("productSn")
        devSpec = visitableSource.getValue("devSpec")
        devStatus = visitableSource.getValue("devStatus")
        lifecycle = visitableSource.getValue("lifecycle")
        produceCom = visitableSource.getValue("produceCom")
        hardVer = visitableSource.getValue("hardVer")
        softVer = visitableSource.getValue("softVer")
        devMac = visitableSource.getValue("devMac")
        batteryCap = visitableSource.getValue("batteryCap")
        createor = visitableSource.getValue("createor")
        createTime = visitableSource.getValue("createTime")
        updateTime = visitableSource.getValue("updateTime")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

