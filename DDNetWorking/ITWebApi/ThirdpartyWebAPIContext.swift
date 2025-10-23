import Foundation

// MARK: Factory
open class ThirdpartyWebAPIContext : ITWebAPIContext{
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
        				case "/api/thirdparty/business/hirerequest":
				if type == .requestBody {
                    body = ThirdpartyPostThirdPartyHireRequest()
                } else {
                    body = ThirdpartyRetThirdPartyHireRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/thirdparty/business/restorerequest":
				if type == .requestBody {
                    body = ThirdpartyPostThirdPartyTrip()
                } else {
                    body = ThirdpartyRetThirdPartyTrip(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/thirdparty/business/getStations":
				if type == .requestBody {
                    body = ThirdpartyPostGetStations()
                } else {
                    body = ThirdpartyRetGetStations(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/thirdparty/business/getBikes":
				if type == .requestBody {
                    body = ThirdpartyPostGetBikes()
                } else {
                    body = ThirdpartyRetGetBikes(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/thirdparty/business/hireerror":
				if type == .requestBody {
                    body = ThirdpartyPostThirdPartyHireError()
                } else {
                    body = ThirdpartyRetThirdPartyHireError(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                    case "/api/thirdparty/business/businessScopes":
            if type == .requestBody {
                body = ThirdpartyPostGetScopes()
            } else {
                body = ThirdpartyRetGetScopes(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/thirdparty/business/getBikeInfo":
            if type == .requestBody {
                body = ThirdpartyPostGetBike()
            } else {
                body = ThirdpartyRetGetBike(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/thirdparty/business/tripPath":
            if type == .requestBody {
                body = ThirdpartyPostTripPath()
            } else {
                body = ThirdpartyRetTripPath(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/thirdparty/business/businessScopesNew":
            if type == .requestBody {
                body = ThirdpartyPostGetScopesNew()
            } else {
                body = ThirdpartyRetGetScopesNew(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/thirdparty/business/citiesNew":
            if type == .requestBody {
                body = ThirdpartyPostGetCitiesNew()
            } else {
                body = ThirdpartyRetGetCitiesNew(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

open class ThirdpartyPostThirdPartyHireRequest : BaseITWebAPIBody {
    
    //
    open var hireType:String?
    open var serviceId:String?
    open var appId:String?
    open var terminalType:String?
    open var DeviceId:String?
    open var qR:String?
    open var electricity:String?
    open var cityCode:String?
    open var bizType:String?
    open var rentflag:String?
    open var deviceStakeId:String?
    open var hireStationName:String?
    open var coordinate:String?
    open var coordType:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/hirerequest"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/hirerequest"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let hireType_ = secureKeys?["AES"]?.encrypt(original: self.hireType) ?? ""
        let serviceId_ = secureKeys?["AES"]?.encrypt(original: self.serviceId) ?? ""
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let terminalType_ = secureKeys?["AES"]?.encrypt(original: self.terminalType) ?? ""
        let DeviceId_ = secureKeys?["AES"]?.encrypt(original: self.DeviceId) ?? ""
        let qR_ = secureKeys?["AES"]?.encrypt(original: self.qR) ?? ""
        let electricity_ = secureKeys?["AES"]?.encrypt(original: self.electricity) ?? ""
        let cityCode_ = self.cityCode;
        let bizType_ = self.bizType;
        let rentflag_ = self.rentflag;
        let deviceStakeId_ = self.deviceStakeId;
        let hireStationName_ = self.hireStationName;
        let coordinate_ = self.coordinate;
        let coordType_ = self.coordType;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&hireType=" + (hireType_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&terminalType=" + (terminalType_ ?? ""))
        md5.append("&DeviceId=" + (DeviceId_ ?? ""))
        md5.append("&qR=" + (qR_ ?? ""))
        md5.append("&electricity=" + (electricity_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostThirdPartyHireRequest",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:16,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:16,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:16,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:16,field:"hireType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:16,value:hireType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:16,field:"hireType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:16,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:16,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:16,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:16,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:16,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:16,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:16,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:16,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:16,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:16,field:"DeviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:16,value:DeviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:16,field:"DeviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:16,field:"qR",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:16,value:qR_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:16,field:"qR",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:16,field:"electricity",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:16,value:electricity_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:16,field:"electricity",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:16,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:16,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:16,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:16,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:16,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:16,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:16,field:"rentflag",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:16,value:rentflag_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:16,field:"rentflag",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:16,field:"deviceStakeId",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:16,value:deviceStakeId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:16,field:"deviceStakeId",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:16,field:"hireStationName",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:16,value:hireStationName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:16,field:"hireStationName",body:self))
        result.append(vo.onFieldBegin(.flat,index:14,length:16,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:14,length:16,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:14,length:16,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:15,length:16,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:15,length:16,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:15,length:16,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:16,length:16,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:16,length:16,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:16,length:16,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostThirdPartyHireRequest",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

		
open class ThirdpartyRetThirdPartyHireRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var reqStatus:String?
    							open var operId:String?
    							open var bikeId:String?
    							open var reqExtra:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hirerequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hirerequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
																											reqStatus = visitableSource.getValue("reqStatus")
																											operId = visitableSource.getValue("operId")
																											bikeId = visitableSource.getValue("bikeId")
																											reqExtra = visitableSource.getValue("reqExtra")
															}

	//-------> list
			    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

open class ThirdpartyPostThirdPartyTrip : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var cityCode:String?
    open var deviceType:String?
    open var lockStatus:String?
    open var coordinate:String?
    open var coordType:String?
    open var bizExtra:String?
    open var electricity:String?
    open var rentflag:String?
    open var deviceStakeId:String?
    open var restoreStationName:String?
    open var flag:String?
    open var operId:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/restorerequest"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/restorerequest"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let deviceId_ = self.deviceId;
        let cityCode_ = self.cityCode;
        let deviceType_ = self.deviceType;
        let lockStatus_ = self.lockStatus;
        let coordinate_ = self.coordinate;
        let coordType_ = self.coordType;
        let bizExtra_ = self.bizExtra;
        let electricity_ = self.electricity;
        let rentflag_ = self.rentflag;
        let deviceStakeId_ = self.deviceStakeId;
        let restoreStationName_ = self.restoreStationName;
        let flag_ = self.flag;
        let operId_ = self.operId;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostThirdPartyTrip",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:15,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:15,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:15,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:15,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:15,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:15,field:"deviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:15,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:15,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:15,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:15,field:"deviceType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:15,value:deviceType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:15,field:"deviceType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:15,field:"lockStatus",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:15,value:lockStatus_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:15,field:"lockStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:15,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:15,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:15,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:15,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:15,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:15,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:15,field:"bizExtra",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:15,value:bizExtra_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:15,field:"bizExtra",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:15,field:"electricity",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:15,value:electricity_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:15,field:"electricity",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:15,field:"rentflag",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:15,value:rentflag_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:15,field:"rentflag",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:15,field:"deviceStakeId",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:15,value:deviceStakeId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:15,field:"deviceStakeId",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:15,field:"restoreStationName",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:15,value:restoreStationName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:15,field:"restoreStationName",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:15,field:"flag",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:15,value:flag_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:15,field:"flag",body:self))
        result.append(vo.onFieldBegin(.flat,index:14,length:15,field:"operId",body:self))
        result.append(vo.onFieldValue(.flat,index:14,length:15,value:operId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:14,length:15,field:"operId",body:self))
        result.append(vo.onFieldBegin(.flat,index:15,length:15,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:15,length:15,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:15,length:15,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostThirdPartyTrip",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

		
open class ThirdpartyRetThirdPartyTrip : BaseITWebAPIBody {
	
	//
												open var reqStatus:String?
    							open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/restorerequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/restorerequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											reqStatus = visitableSource.getValue("reqStatus")
																											bizStatus = visitableSource.getValue("bizStatus")
															}

	//-------> list
			    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class ThirdpartyPostGetStations : BaseITWebAPIBody {
	
	//
						open var appId:String?
    							open var serviceId:String?
    							open var coordinate:String?
    							open var coordType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getStations"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getStations"
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
																					let coordinate_ = secureKeys?["AES"]?.encrypt(original: self.coordinate) ?? ""
																					let coordType_ = secureKeys?["AES"]?.encrypt(original: self.coordType) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("appId=" + (appId_ ?? ""))
																					md5.append("&serviceId=" + (serviceId_ ?? ""))
																					md5.append("&coordinate=" + (coordinate_ ?? ""))
																					md5.append("&coordType=" + (coordType_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetStations",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:5,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:5,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:5,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"coordType",body:self))
									result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetStations",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class ThirdpartyRetGetStations : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->list
    open var data = [ThirdpartyRetStation]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getStations"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getStations"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = visitableSource.getValue("datacount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data .append(ThirdpartyRetStation (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:ThirdpartyRetStation) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [ThirdpartyRetStation]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								

    
}
open class ThirdpartyRetVertexes : BaseITWebAPIBody {
    
    //
    open var lng:String?
    open var lat:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getStations"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getStations"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        lng = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("lng"))
        lat = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("lat"))
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
}

open class ThirdpartyRetStation : BaseITWebAPIBody {
    
    //
    open var name:String?
    //----->list
    open var vertexes = [ThirdpartyRetVertexes]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getStations"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getStations"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        name = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("name"))
        //----->list
        for visitableSource in visitableSource.getSubSource("vertexes") {
            vertexes .append( ThirdpartyRetVertexes (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addVertexes(subBody:ThirdpartyRetVertexes) -> Void{
        vertexes.append(subBody)
    }
    
    open func getVertexes() -> [ThirdpartyRetVertexes]{
        return vertexes
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

		
open class ThirdpartyPostGetBikes : BaseITWebAPIBody {
	
	//
    open var appId:String?
    open var serviceId:String?
    open var coordinate:String?
    open var coordType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getBikes"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getBikes"
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
        let coordinate_ = secureKeys?["AES"]?.encrypt(original: self.coordinate) ?? ""
        let coordType_ = secureKeys?["AES"]?.encrypt(original: self.coordType) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&coordinate=" + (coordinate_ ?? ""))
        md5.append("&coordType=" + (coordType_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetBikes",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetBikes",body:self))
        return result.joined(separator:"")
    }
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class ThirdpartyRetGetBikes : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->list
    open var data = [ThirdpartyRetGetBikesDetail]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getBikes"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/getBikes"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = visitableSource.getValue("datacount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data.append( ThirdpartyRetGetBikesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:ThirdpartyRetGetBikesDetail) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [ThirdpartyRetGetBikesDetail]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								

}
open class ThirdpartyRetGetBikesDetail : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var coordinate:String?
    open var battery:String?
    open var coordType:String?
    open var isLocked:String?
    open var isFaulty:String?
    open var isEnabled:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikes"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikes"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        deviceId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceId"))
        coordinate = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordinate"))
        battery = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("battery"))
        coordType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordType"))
        isLocked = visitableSource.getValue("isLocked")
        isFaulty = visitableSource.getValue("isFaulty")
        isEnabled = visitableSource.getValue("isEnabled")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class ThirdpartyPostThirdPartyHireError : BaseITWebAPIBody {
	
	//
									open var operId:String?
    							open var deviceId:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var electricity:String?
    							open var deviceStakeId:String?
    							open var restoreStationName:String?
    
    open var failBody:String?
    open var failType:String?
    open var kindId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hireerror"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hireerror"
        	}

	//-------> list
			    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let accessToken_ = self.accessToken;
																					let operId_ = self.operId;
																					let deviceId_ = self.deviceId;
																					let coordinate_ = self.coordinate;
																					let coordType_ = self.coordType;
																					let electricity_ = self.electricity;
																					let deviceStakeId_ = self.deviceStakeId;
																					let restoreStationName_ = self.restoreStationName;
            let failBody_ = self.failBody;
            let failType_ = self.failType;
            let kindId_ = self.kindId;
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("accessToken=" + (accessToken_ ?? ""))
																																																															
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostThirdPartyHireError",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:9,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:9,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:9,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:9,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"coordType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"electricity",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:9,value:electricity_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"electricity",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"deviceStakeId",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:9,value:deviceStakeId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"deviceStakeId",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"restoreStationName",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:9,value:restoreStationName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"restoreStationName",body:self))
            result.append(vo.onFieldBegin(.flat,index:9,length:11,field:"failBody",body:self))
            result.append(vo.onFieldValue(.flat,index:9,length:11,value:failBody_ ?? "",body:self))
            result.append(vo.onFieldEnd(.flat,index:9,length:11,field:"failBody",body:self))
            result.append(vo.onFieldBegin(.flat,index:10,length:11,field:"failType",body:self))
            result.append(vo.onFieldValue(.flat,index:10,length:11,value:failType_ ?? "",body:self))
            result.append(vo.onFieldEnd(.flat,index:10,length:11,field:"failType",body:self))
            result.append(vo.onFieldBegin(.flat,index:11,length:12,field:"kindId",body:self))
            result.append(vo.onFieldValue(.flat,index:11,length:12,value:kindId_ ?? "",body:self))
            result.append(vo.onFieldEnd(.flat,index:11,length:12,field:"kindId",body:self))
									result.append(vo.onFieldBegin(.flat,index:9,length:9,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:9,length:9,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:9,length:9,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostThirdPartyHireError",body:self))
            
            
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class ThirdpartyRetThirdPartyHireError : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    open var reqStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hireerror"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "thirdparty"
		self.mapping_ = "/api/thirdparty/business/hireerror"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
        reqStatus = visitableSource.getValue("reqStatus")
															}

	//-------> list
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }
open class ThirdpartyPostGetScopes : BaseITWebAPIBody {
    
    //
    open var cityCode:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let cityCode_ = secureKeys?["AES"]?.encrypt(original: self.cityCode) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&cityCode=" + (cityCode_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetScopes",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetScopes",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class ThirdpartyRetGetScopes : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [ThirdpartyRetGetScopesDetail]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("retcode"))
        retmsg = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("retmsg"))
        datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( ThirdpartyRetGetScopesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:ThirdpartyRetGetScopesDetail) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [ThirdpartyRetGetScopesDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
    
}
open class ThirdpartyRetGetScopesDetail : BaseITWebAPIBody {
    
    //
    open var name:String?
    open var boundary = [ThirdpartyRetBoundary]()
    
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        name = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("name"))
        for visitableSource in visitableSource.getSubSource("boundary") {
            boundary .append(ThirdpartyRetBoundary (visitableSource:visitableSource,secureKeys:secureKeys))
        }
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class ThirdpartyRetBoundary : BaseITWebAPIBody {
    
    //
    open var lng:String?
    open var lat:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopes"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        lng = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("lng"))
        lat = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("lat"))
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class ThirdpartyPostGetBike : BaseITWebAPIBody {
    
    //
    open var code:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikeInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikeInfo"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let code_ = secureKeys?["AES"]?.encrypt(original: self.code) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("code=" + (code_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetBike",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"code",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:code_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"code",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:2,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetBike",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class ThirdpartyRetGetBike : BaseITWebAPIBody {
    
    //
    open var code:String?
    open var longitude:String?
    open var latitude:String?
    open var battery:String?
    open var isLocked:String?
    open var isFaulty:String?
    open var isEnabled:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikeInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/getBikeInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        code = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("code"))
        longitude = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("longitude"))
        latitude = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("latitude"))
        battery = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("battery"))
        isLocked = visitableSource.getValue("isLocked")
        isFaulty = visitableSource.getValue("isFaulty")
        isEnabled = visitableSource.getValue("isEnabled")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class ThirdpartyPostTripPath : BaseITWebAPIBody {
    
    //
    open var operId:String?
    open var points:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/tripPath"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/tripPath"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let operId_ = self.operId;
        let points_ = self.points;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostTripPath",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"operId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:operId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"operId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"points",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:points_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"points",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostTripPath",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class ThirdpartyRetTripPath : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/tripPath"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/tripPath"
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

open class ThirdpartyPostGetScopesNew : BaseITWebAPIBody {
    
    //
    open var cityCode:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let cityCode_ = self.cityCode;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetScopesNew",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"cityCode",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetScopesNew",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class ThirdpartyRetGetScopesNew : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [ThirdpartyRetGetScopesDetailNew]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( ThirdpartyRetGetScopesDetailNew (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:ThirdpartyRetGetScopesDetailNew) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [ThirdpartyRetGetScopesDetailNew]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class ThirdpartyRetGetScopesDetailNew : BaseITWebAPIBody {
    
    //
    open var name:String?
    //----->list
    open var boundary = [ThirdpartyRetBoundaryNew]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/businessScopesNew"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        name = visitableSource.getValue("name")
        //----->list
        for visitableSource in visitableSource.getSubSource("boundary") {
            boundary .append( ThirdpartyRetBoundaryNew (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
    open class ThirdpartyRetBoundaryNew : BaseITWebAPIBody {
        
        //
        open var lng:String?
        open var lat:String?
        
        required public init(){
            super.init()
            self.appId_ = "49"
            self.appName_ = "thirdparty"
            self.mapping_ = "/api/thirdparty/business/businessScopesNew"
        }
        
        required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
            self.init()
            self.appId_ = "49"
            self.appName_ = "thirdparty"
            self.mapping_ = "/api/thirdparty/business/businessScopesNew"
            //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
            }
            lng = visitableSource.getValue("lng")
            lat = visitableSource.getValue("lat")
        }
        
        //-------> list
        
        override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
        
        
        open func isRequestBody() -> Bool{
            return false;
        }
    }
}

open class ThirdpartyPostGetCitiesNew : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"ThirdpartyPostGetCitiesNew",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"ThirdpartyPostGetCitiesNew",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class ThirdpartyRetGetCitiesNew : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [ThirdpartyRetGetCityDetailNew]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( ThirdpartyRetGetCityDetailNew (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:ThirdpartyRetGetCityDetailNew) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [ThirdpartyRetGetCityDetailNew]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class ThirdpartyRetGetCityDetailNew : BaseITWebAPIBody {
    
    //
    open var code:String?
    open var name:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "thirdparty"
        self.mapping_ = "/api/thirdparty/business/citiesNew"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        code = visitableSource.getValue("code")
        name = visitableSource.getValue("name")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
