import Foundation

// MARK: Factory
open class IotcaWebAPIContext : ITWebAPIContext{
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
        				case "/iotca/business/hirerequest":
				if type == .requestBody {
                    body = IotcaPostIotHireRequest()
                } else {
                    body = IotcaRetIotHireRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/iotca/business/querydevices":
				if type == .requestBody {
                    body = IotcaPostQueryIotDevices()
                } else {
                    body = IotcaRetQueryIotDevices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/iotca/business/iottrip":
				if type == .requestBody {
                    body = IotcaPostIotTrip()
                } else {
                    body = IotcaRetIotTrip(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/iotca/business/restorerequest":
				if type == .requestBody {
                    body = IotcaPostIotRestoreRequest()
                } else {
                    body = IotcaRetIotRestoreRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/iotca/business/unlock":
				if type == .requestBody {
                    body = IotcaPostIotUnlock()
                } else {
                    body = IotcaRetIotUnlock(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
        case "/api/iotca/business/currentAmount":
            if type == .requestBody {
                body = IotcaPostCurrentAmount()
            } else {
                body = IotcaRetCurrentAmount(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/iotca/business/getLockPwd":
            if type == .requestBody {
                body = IotcaPostGetLockPwd()
            } else {
                body = IotcaRetGetLockPwd(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/iotca/business/rentBikeFault":
            if type == .requestBody {
                body = IotcaPostRentBikeFault()
            } else {
                body = IotcaRetRentBikeFault(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/iotca/business/appReturnBike":
            if type == .requestBody {
                body = IotcaPostAppReturnBike()
            } else {
                body = IotcaRetAppReturnBike(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/iotca/business/openHelmetLock":
            if type == .requestBody {
                body = IotcaPostOpenHelmetLock()
            } else {
                body = IotcaRetOpenHelmetLock(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}


		
open class IotcaPostIotHireRequest : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var terminalType:String?
    open var requestType:String?
    open var DeviceId:String?
    open var parkNum:String?
    open var cityCode:String?
    open var bizType:String?
    open var deviceStakeId:String?
    open var coordinate:String?
    open var coordType:String?
    open var version:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/iotca/business/hirerequest"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/iotca/business/hirerequest"
    }
    
    //-------> one-to-many
    
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
        let deviceStakeId_ = self.deviceStakeId;
        let coordinate_ = self.coordinate;
        let coordType_ = self.coordType;
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
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostIotHireRequest",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:13,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:13,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:13,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:13,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:13,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:13,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:13,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:13,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:13,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:13,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:13,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:13,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:13,field:"requestType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:13,value:requestType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:13,field:"requestType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:13,field:"DeviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:13,value:DeviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:13,field:"DeviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:13,field:"parkNum",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:13,value:parkNum_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:13,field:"parkNum",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:13,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:13,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:13,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:13,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:13,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:13,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:13,field:"deviceStakeId",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:13,value:deviceStakeId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:13,field:"deviceStakeId",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:13,field:"coordinate",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:13,value:coordinate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:13,field:"coordinate",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:13,field:"coordType",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:13,value:coordType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:13,field:"coordType",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:14,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:14,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:14,field:"version",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:13,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:13,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:13,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostIotHireRequest",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

		
open class IotcaRetIotHireRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var reqStatus:String?
    							open var serviceId:String?
    							open var orderId:String?
    							open var bikeId:String?
    							open var reqExtra:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/hirerequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/hirerequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
																											reqStatus = visitableSource.getValue("reqStatus")
																											serviceId = visitableSource.getValue("serviceId")
																											orderId = visitableSource.getValue("orderId")
																											bikeId = visitableSource.getValue("bikeId")
																											reqExtra = visitableSource.getValue("reqExtra")
															}

	//-------> one-to-many
			    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class IotcaPostQueryIotDevices : BaseITWebAPIBody {
	
	//
						open var appId:String?
    							open var serviceId:String?
    							open var keyword:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var range:String?
    							open var type:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/querydevices"
        	}

	//-------> one-to-many
			    		    		    		    		    		    		    
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
		result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostQueryIotDevices",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:8,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:8,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"keyword",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:8,value:keyword_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"keyword",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:8,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:8,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"coordType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"range",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:8,value:range_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"range",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"type",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:8,value:type_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"type",body:self))
									result.append(vo.onFieldBegin(.flat,index:8,length:8,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:8,length:8,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:8,length:8,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostQueryIotDevices",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class IotcaRetQueryIotDevices : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->one-to-manay
    open var data = [IotcaRetQueryDevicesDetail]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/querydevices"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
																					//----->one-to-manay
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( IotcaRetQueryDevicesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> one-to-many
			    		    		    			    open func addIotcaRetQueryDevicesDetail(subBody:IotcaRetQueryDevicesDetail) -> Void{
	        data.append(subBody)
	    }

	    open func getIotcaRetQueryDevicesDetail() -> [IotcaRetQueryDevicesDetail]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								
}

open class IotcaRetQueryDevicesDetail : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var deviceName:String?
    open var coordinate:String?
    open var coordType:String?
    open var address:String?
    open var status:String?
    open var updatetime:String?
    open var rentcount:String?
    open var type:String?
    open var cityCode:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/iotca/business/querydevices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/iotca/business/querydevices"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        deviceId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceId"))
        deviceName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceName"))
        coordinate = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordinate"))
        coordType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordType"))
        address = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("address"))
        status = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("status"))
        updatetime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("updatetime"))
        rentcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("rentcount"))
        type = visitableSource.getValue("type")
        cityCode = visitableSource.getValue("cityCode")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

		
open class IotcaPostIotTrip : BaseITWebAPIBody {
	
	//
						open var dataType:String?
    							open var deviceId:String?
    							open var deviceType:String?
    							open var lockStatus:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var bizExtra:String?
    							open var batteryLevel:String?
    							open var deviceStakeId:String?
    							open var DataTime:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/iottrip"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/iottrip"
        	}

	//-------> one-to-many
			    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let dataType_ = self.dataType;
																					let deviceId_ = self.deviceId;
																					let deviceType_ = self.deviceType;
																					let lockStatus_ = self.lockStatus;
																					let coordinate_ = secureKeys?["AES"]?.encrypt(original: self.coordinate) ?? ""
																					let coordType_ = self.coordType;
																					let bizExtra_ = self.bizExtra;
																					let batteryLevel_ = self.batteryLevel;
																					let deviceStakeId_ = self.deviceStakeId;
																					let DataTime_ = secureKeys?["AES"]?.encrypt(original: self.DataTime) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
																																											md5.append("coordinate=" + (coordinate_ ?? ""))
																																																	md5.append("&DataTime=" + (DataTime_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostIotTrip",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:11,field:"dataType",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:11,value:dataType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:11,field:"dataType",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:11,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:11,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:11,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:11,field:"deviceType",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:11,value:deviceType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:11,field:"deviceType",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:11,field:"lockStatus",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:11,value:lockStatus_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:11,field:"lockStatus",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:11,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:11,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:11,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:11,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:11,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:11,field:"coordType",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:11,field:"bizExtra",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:11,value:bizExtra_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:11,field:"bizExtra",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:11,field:"batteryLevel",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:11,value:batteryLevel_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:11,field:"batteryLevel",body:self))
												result.append(vo.onFieldBegin(.flat,index:9,length:11,field:"deviceStakeId",body:self))
				result.append(vo.onFieldValue(.flat,index:9,length:11,value:deviceStakeId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:9,length:11,field:"deviceStakeId",body:self))
												result.append(vo.onFieldBegin(.flat,index:10,length:11,field:"DataTime",body:self))
				result.append(vo.onFieldValue(.flat,index:10,length:11,value:DataTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:10,length:11,field:"DataTime",body:self))
									result.append(vo.onFieldBegin(.flat,index:11,length:11,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:11,length:11,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:11,length:11,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostIotTrip",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class IotcaRetIotTrip : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/iottrip"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/iottrip"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
															}

	//-------> one-to-many
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class IotcaPostIotRestoreRequest : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var deviceType:String?
    							open var lockStatus:String?
    							open var bizExtra:String?
    							open var DataTime:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/restorerequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/restorerequest"
        	}

	//-------> one-to-many
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let deviceType_ = self.deviceType;
																					let lockStatus_ = self.lockStatus;
																					let bizExtra_ = self.bizExtra;
																					let DataTime_ = secureKeys?["AES"]?.encrypt(original: self.DataTime) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
																																											md5.append("DataTime=" + (DataTime_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostIotRestoreRequest",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:6,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"deviceType",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:6,value:deviceType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"deviceType",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"lockStatus",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:6,value:lockStatus_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"lockStatus",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"bizExtra",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:6,value:bizExtra_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"bizExtra",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"DataTime",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:6,value:DataTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"DataTime",body:self))
									result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostIotRestoreRequest",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class IotcaRetIotRestoreRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/restorerequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/restorerequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
															}

	//-------> one-to-many
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class IotcaPostIotUnlock : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var cmdTime:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/unlock"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/unlock"
        	}

	//-------> one-to-many
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let cmdTime_ = self.cmdTime;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostIotUnlock",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:3,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"cmdTime",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:3,value:cmdTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"cmdTime",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostIotUnlock",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class IotcaRetIotUnlock : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/unlock"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
		self.appName_ = "iotca"
		self.mapping_ = "/iotca/business/unlock"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
															}

	//-------> one-to-many
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }
open class IotcaPostCurrentAmount : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/currentAmount"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/currentAmount"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let deviceId_ = self.deviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostCurrentAmount",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"deviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostCurrentAmount",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class IotcaRetCurrentAmount : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/currentAmount"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/currentAmount"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class IotcaPostGetLockPwd : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var devType:String?
    open var cityCode:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/getLockPwd"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/getLockPwd"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let deviceId_ = self.deviceId;
        let devType_ = self.devType;
        let cityCode_ = self.cityCode;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostGetLockPwd",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"deviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:deviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"deviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"devType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:devType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"devType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"cityCode",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostGetLockPwd",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class IotcaRetGetLockPwd : BaseITWebAPIBody {
    
    //
    open var openPwd:String?
    open var closePwd:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/getLockPwd"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/getLockPwd"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        openPwd = visitableSource.getValue("openPwd")
        closePwd = visitableSource.getValue("closePwd")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class IotcaPostRentBikeFault : BaseITWebAPIBody {
    
    //
    open var bikeId:String?
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/rentBikeFault"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/rentBikeFault"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let bikeId_ = self.bikeId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostRentBikeFault",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"bikeId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:bikeId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"bikeId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostRentBikeFault",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class IotcaRetRentBikeFault : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/rentBikeFault"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/rentBikeFault"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class IotcaPostAppReturnBike : BaseITWebAPIBody {
    
    //
                                    open var lat:String?
                                open var lng:String?
                                open var coordinateType:String?
                                open var bikeId:String?
                                open var operationId:String?
                                open var angle:String?
                                open var handleType:String?
    open var lngLatList:String?
    open var checkDispatchFee:String?
            
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/appReturnBike"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/appReturnBike"
            }

    //-------> list
                                                                                                    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

        override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

        //====encrypt field====
                                                        let accessToken_ = self.accessToken;
                                                                                    let lat_ = self.lat;
                                                                                    let lng_ = self.lng;
                                                                                    let coordinateType_ = self.coordinateType;
                                                                                    let bikeId_ = self.bikeId;
                                                                                    let operationId_ = self.operationId;
                                                                                    let angle_ = self.angle;
                                                                                    let handleType_ = self.handleType;
            let lngLatList_ = self.lngLatList;
            let checkDispatchFee_ = self.checkDispatchFee
                                    
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostAppReturnBike",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:10,field:"accessToken",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:10,value:accessToken_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:10,field:"accessToken",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:10,field:"lat",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:10,value:lat_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:10,field:"lat",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:3,length:10,field:"lng",body:self))
                result.append(vo.onFieldValue(.flat,index:3,length:10,value:lng_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:3,length:10,field:"lng",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:4,length:10,field:"coordinateType",body:self))
                result.append(vo.onFieldValue(.flat,index:4,length:10,value:coordinateType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:4,length:10,field:"coordinateType",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:5,length:10,field:"bikeId",body:self))
                result.append(vo.onFieldValue(.flat,index:5,length:10,value:bikeId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:5,length:10,field:"bikeId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:6,length:10,field:"operationId",body:self))
                result.append(vo.onFieldValue(.flat,index:6,length:10,value:operationId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:6,length:10,field:"operationId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:7,length:10,field:"angle",body:self))
                result.append(vo.onFieldValue(.flat,index:7,length:10,value:angle_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:7,length:10,field:"angle",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:8,length:10,field:"handleType",body:self))
                result.append(vo.onFieldValue(.flat,index:8,length:10,value:handleType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:8,length:10,field:"handleType",body:self))
            result.append(vo.onFieldBegin(.flat,index:9,length:10,field:"lngLatList",body:self))
result.append(vo.onFieldValue(.flat,index:9,length:10,value:lngLatList_ ?? "",body:self))
result.append(vo.onFieldEnd(.flat,index:9,length:10,field:"lngLatList",body:self))
            result.append(vo.onFieldBegin(.flat,index:10,length:10,field:"checkDispatchFee",body:self))
result.append(vo.onFieldValue(.flat,index:10,length:10,value:checkDispatchFee_ ?? "",body:self))
result.append(vo.onFieldEnd(.flat,index:10,length:10,field:"checkDispatchFee",body:self))
                                    result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostAppReturnBike",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

open class IotcaRetAppReturnBike : BaseITWebAPIBody {
    
    //
                            
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/appReturnBike"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/appReturnBike"
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

open class IotcaPostOpenHelmetLock : BaseITWebAPIBody {
    
    //
                                    open var tripId:String?
            
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/openHelmetLock"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/openHelmetLock"
            }

    //-------> list
                            
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

        override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

        //====encrypt field====
                                                        let accessToken_ = self.accessToken;
                                                                                    let tripId_ = self.tripId;
                                    
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"IotcaPostOpenHelmetLock",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"tripId",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:3,value:tripId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"tripId",body:self))
                                    result.append(vo.onObjectEnd(index,length:length,objname:"IotcaPostOpenHelmetLock",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

        
open class IotcaRetOpenHelmetLock : BaseITWebAPIBody {
    
    //
                            
    required public init(){
        super.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/openHelmetLock"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "44"
        self.appName_ = "iotca"
        self.mapping_ = "/api/iotca/business/openHelmetLock"
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
