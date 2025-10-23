import Foundation

// MARK: Factory
open class MscWebAPIContext : ITWebAPIContext{
	required public init(){}
    open var visitablePair:ITVisitablePair = ITXmlVisitablePair()
    open var secureKeys = [String:ITSecureKey]()
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

    public enum BodyType{
        case requestBody
        case responseBody
    }

    open func createBody(type:BodyType,requestMapping:String,content:String?,secureKeys:[String:ITSecureKey]) -> ITWebAPIBody{
        var body:ITWebAPIBody
        switch(requestMapping){
        				case "/api/msc/business/getMscBizInfo":
				if type == .requestBody {
                    body = MscPostMscBizInfo()
                } else {
                    body = MscRetMscBizInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/queryMscDevices":
				if type == .requestBody {
                    body = MscPostQueryMscDevices()
                } else {
                    body = MscRetQueryMscDevices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/checkMscOrder":
				if type == .requestBody {
                    body = MscPostCheckMscOrder()
                } else {
                    body = MscRetCheckMscOrder(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/getMscPriceConfig":
				if type == .requestBody {
                    body = MscPostMscPriceConfig()
                } else {
                    body = MscRetMscPriceConfig(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/requestCharge":
				if type == .requestBody {
                    body = MscPostRequestCharge()
                } else {
                    body = MscRetRequestCharge(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/getChargeRecord":
				if type == .requestBody {
                    body = MscPostGetChargeRecord()
                } else {
                    body = MscRetGetChargeRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/useWalletPay":
				if type == .requestBody {
                    body = MscPostUseWalletPay()
                } else {
                    body = MscRetUseWalletPay(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/notifyChargeStatus":
				if type == .requestBody {
                    body = MscPostNotifyChargeStatus()
                } else {
                    body = MscRetNotifyChargeStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/deviceHeartbeat":
				if type == .requestBody {
                    body = MscPostDeviceHeartbeat()
                } else {
                    body = MscRetDeviceHeartbeat(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/stationLifecycle":
				if type == .requestBody {
                    body = MscPostStationLifecycle()
                } else {
                    body = MscRetStationLifecycle(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/devLifecycle":
				if type == .requestBody {
                    body = MscPostDevlifecycle()
                } else {
                    body = MscRetDevlifecycle(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/requestRent":
				if type == .requestBody {
                    body = MscPostRequestRent()
                } else {
                    body = MscRetRequestRent(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/startReport":
				if type == .requestBody {
                    body = MscPostStartReport()
                } else {
                    body = MscRetStartReport(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/stopReport":
				if type == .requestBody {
                    body = MscPostStopReport()
                } else {
                    body = MscRetStopReport(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/queryMscStation":
				if type == .requestBody {
                    body = MscPostQueryMscStation()
                } else {
                    body = MscRetQueryMscStation(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/api/msc/business/stationDetailed":
				if type == .requestBody {
                    body = MscPostStationDetailed()
                } else {
                    body = MscRetStationDetailed(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}


		
open class MscPostMscBizInfo : BaseITWebAPIBody {
	
	//
									open var appId:String?
    							open var serviceId:String?
    							open var version:String?
    							open var terminalType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscBizInfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscBizInfo"
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
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostMscBizInfo",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:6,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:6,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:6,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:6,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"terminalType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostMscBizInfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetMscBizInfo : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var bizExtra:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscBizInfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscBizInfo"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
																											bizExtra = visitableSource.getValue("bizExtra")
															}

	//-------> list
			    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MscPostQueryMscDevices : BaseITWebAPIBody {
	
	//
						open var serviceId:String?
    							open var keyword:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var range:String?
    							open var version:String?
    							open var terminalType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
        	}

	//-------> list
			    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let serviceId_ = self.serviceId;
																					let keyword_ = self.keyword;
																					let coordinate_ = self.coordinate;
																					let coordType_ = self.coordType;
																					let range_ = self.range;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostQueryMscDevices",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:8,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"keyword",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:8,value:keyword_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"keyword",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:8,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:8,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"coordType",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"range",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:8,value:range_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"range",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:8,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:8,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"terminalType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostQueryMscDevices",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetQueryMscDevices : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->list
            open var data = [MscRetMscQueryDevicesDetail]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = visitableSource.getValue("datacount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( MscRetMscQueryDevicesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:MscRetMscQueryDevicesDetail) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [MscRetMscQueryDevicesDetail]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								
open class MscRetMscQueryDevicesDetail : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var deviceName:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var address:String?
    							open var status:String?
    							open var cityCode:String?
    							open var totalcount:String?
    							open var rentcount:String?
    							open var badcount:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscDevices"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		deviceId = visitableSource.getValue("deviceId")
																											deviceName = visitableSource.getValue("deviceName")
																											coordinate = visitableSource.getValue("coordinate")
																											coordType = visitableSource.getValue("coordType")
																											address = visitableSource.getValue("address")
																											status = visitableSource.getValue("status")
																											cityCode = visitableSource.getValue("cityCode")
																											totalcount = visitableSource.getValue("totalcount")
																											rentcount = visitableSource.getValue("rentcount")
																											badcount = visitableSource.getValue("badcount")
															}

	//-------> list
			    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }
						}

		
open class MscPostCheckMscOrder : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var type:String?
    							open var orderId:String?
    							open var version:String?
    							open var terminalType:String?
    							open var isNew:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/checkMscOrder"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/checkMscOrder"
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
																					let appId_ = self.appId;
																					let type_ = self.type;
																					let orderId_ = self.orderId;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
																					let isNew_ = self.isNew;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostCheckMscOrder",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:9,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:9,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"type",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:9,value:type_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"type",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"orderId",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:9,value:orderId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"orderId",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:9,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:9,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"terminalType",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"isNew",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:9,value:isNew_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"isNew",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostCheckMscOrder",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetCheckMscOrder : BaseITWebAPIBody {
	
	//
												open var orderStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/checkMscOrder"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/checkMscOrder"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											orderStatus = visitableSource.getValue("orderStatus")
															}

	//-------> list
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MscPostMscPriceConfig : BaseITWebAPIBody {
	
	//
						open var serviceId:String?
    							open var deviceId:String?
    							open var version:String?
    							open var terminalType:String?
    							open var isNew:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscPriceConfig"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscPriceConfig"
        	}

	//-------> list
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let serviceId_ = self.serviceId;
																					let deviceId_ = self.deviceId;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
																					let isNew_ = self.isNew;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostMscPriceConfig",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:6,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:6,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:6,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:6,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"terminalType",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"isNew",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:6,value:isNew_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"isNew",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostMscPriceConfig",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetMscPriceConfig : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->list
			open var data = [MscRetMscPriceConfigInfo]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscPriceConfig"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getMscPriceConfig"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = visitableSource.getValue("datacount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( MscRetMscPriceConfigInfo (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:MscRetMscPriceConfigInfo) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [MscRetMscPriceConfigInfo]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								

						}

open class MscRetMscPriceConfigInfo : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var hireTime:String?
    open var price:String?
    
    required public init(){
        super.init()
        self.appId_ = "51"
        self.appName_ = "msc"
        self.mapping_ = "/api/msc/business/getMscPriceConfig"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
        self.appName_ = "msc"
        self.mapping_ = "/api/msc/business/getMscPriceConfig"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        hireTime = visitableSource.getValue("hireTime")
        price = visitableSource.getValue("price")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

		
open class MscPostRequestCharge : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var deviceId:String?
    							open var priceConfigId:String?
    							open var version:String?
    							open var terminalType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestCharge"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestCharge"
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
																					let appId_ = self.appId;
																					let deviceId_ = self.deviceId;
																					let priceConfigId_ = self.priceConfigId;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostRequestCharge",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:8,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:8,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:8,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:8,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"priceConfigId",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:8,value:priceConfigId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"priceConfigId",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:8,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:8,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"terminalType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostRequestCharge",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetRequestCharge : BaseITWebAPIBody {
	
	//
												open var reqStatus:String?
    							open var orderId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestCharge"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestCharge"
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

		
open class MscPostGetChargeRecord : BaseITWebAPIBody {
	
	//
									open var limit:String?
    							open var start:String?
    							open var version:String?
    							open var terminalType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getChargeRecord"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getChargeRecord"
        	}

	//-------> list
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let accessToken_ = self.accessToken;
																					let limit_ = self.limit;
																					let start_ = self.start;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostGetChargeRecord",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"limit",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:6,value:limit_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"limit",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"start",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:6,value:start_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"start",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:6,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:6,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"terminalType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostGetChargeRecord",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetGetChargeRecord : BaseITWebAPIBody {
	
	//
												open var dataCount:String?
    				    		//----->list
			open var data = [MscRetRecordInfo]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getChargeRecord"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/getChargeRecord"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											dataCount = visitableSource.getValue("dataCount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( MscRetRecordInfo (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:MscRetRecordInfo) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [MscRetRecordInfo]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }

						}


open class MscRetRecordInfo : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var hireTime:String?
    open var payOrderId:String?
    open var stationId:String?
    open var stationName:String?
    open var deviceId:String?
    open var money:String?
    open var stationCoord:String?
    open var chargeStatus:String?
    open var openTime:String?
    open var createTime:String?
    open var recordType:String?
    
    required public init(){
        super.init()
        self.appId_ = "51"
        self.appName_ = "msc"
        self.mapping_ = "/api/msc/business/getChargeRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
        self.appName_ = "msc"
        self.mapping_ = "/api/msc/business/getChargeRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        hireTime = visitableSource.getValue("hireTime")
        payOrderId = visitableSource.getValue("payOrderId")
        stationId = visitableSource.getValue("stationId")
        stationName = visitableSource.getValue("stationName")
        deviceId = visitableSource.getValue("deviceId")
        money = visitableSource.getValue("money")
        stationCoord = visitableSource.getValue("stationCoord")
        chargeStatus = visitableSource.getValue("chargeStatus")
        openTime = visitableSource.getValue("openTime")
        createTime = visitableSource.getValue("createTime")
        recordType = visitableSource.getValue("recordType")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

		
open class MscPostUseWalletPay : BaseITWebAPIBody {
	
	//
									open var orderId:String?
    							open var usedChannel:String?
    							open var serviceId:String?
    							open var terminalType:String?
    							open var appversion:String?
    							open var isNew:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/useWalletPay"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/useWalletPay"
        	}

	//-------> list
			    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let accessToken_ = self.accessToken;
																					let orderId_ = self.orderId;
																					let usedChannel_ = self.usedChannel;
																					let serviceId_ = self.serviceId;
																					let terminalType_ = self.terminalType;
																					let appversion_ = self.appversion;
																					let isNew_ = self.isNew;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostUseWalletPay",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:8,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"orderId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:8,value:orderId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"orderId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"usedChannel",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:8,value:usedChannel_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"usedChannel",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:8,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:8,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"terminalType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"appversion",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:8,value:appversion_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"appversion",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"isNew",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:8,value:isNew_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"isNew",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostUseWalletPay",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetUseWalletPay : BaseITWebAPIBody {
	
	//
							
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/useWalletPay"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/useWalletPay"
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

		
open class MscPostNotifyChargeStatus : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var bizType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/notifyChargeStatus"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/notifyChargeStatus"
        	}

	//-------> list
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let bizType_ = self.bizType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostNotifyChargeStatus",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:3,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"bizType",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:3,value:bizType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"bizType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostNotifyChargeStatus",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetNotifyChargeStatus : BaseITWebAPIBody {
	
	//
									open var message:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/notifyChargeStatus"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/notifyChargeStatus"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											message = visitableSource.getValue("message")
															}

	//-------> list
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MscPostDeviceHeartbeat : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var onlineStatus:String?
    							open var deviceStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/deviceHeartbeat"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/deviceHeartbeat"
        	}

	//-------> list
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let onlineStatus_ = self.onlineStatus;
																					let deviceStatus_ = self.deviceStatus;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostDeviceHeartbeat",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:4,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"onlineStatus",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:4,value:onlineStatus_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"onlineStatus",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"deviceStatus",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:4,value:deviceStatus_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"deviceStatus",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostDeviceHeartbeat",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetDeviceHeartbeat : BaseITWebAPIBody {
	
	//
									open var message:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/deviceHeartbeat"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/deviceHeartbeat"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											message = visitableSource.getValue("message")
															}

	//-------> list
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MscPostStationLifecycle : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var deviceName:String?
    							open var address:String?
    							open var cordinate:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationLifecycle"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationLifecycle"
        	}

	//-------> list
			    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let deviceName_ = self.deviceName;
																					let address_ = self.address;
																					let cordinate_ = self.cordinate;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostStationLifecycle",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:5,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"deviceName",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:5,value:deviceName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"deviceName",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"address",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:5,value:address_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"address",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"cordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:5,value:cordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"cordinate",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostStationLifecycle",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetStationLifecycle : BaseITWebAPIBody {
	
	//
							
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationLifecycle"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationLifecycle"
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

		
open class MscPostDevlifecycle : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var stationId:String?
    							open var cityCode:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/devLifecycle"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/devLifecycle"
        	}

	//-------> list
			    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let stationId_ = self.stationId;
																					let cityCode_ = self.cityCode;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostDevlifecycle",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:4,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"stationId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:4,value:stationId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"stationId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"cityCode",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:4,value:cityCode_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"cityCode",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostDevlifecycle",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetDevlifecycle : BaseITWebAPIBody {
	
	//
							
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/devLifecycle"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/devLifecycle"
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

		
open class MscPostRequestRent : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var deviceId:String?
    							open var priceConfigId:String?
    							open var version:String?
    							open var terminalType:String?
    							open var portId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestRent"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestRent"
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
																					let appId_ = self.appId;
																					let deviceId_ = self.deviceId;
																					let priceConfigId_ = self.priceConfigId;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
																					let portId_ = self.portId;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostRequestRent",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:9,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:9,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:9,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"priceConfigId",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:9,value:priceConfigId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"priceConfigId",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:9,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:9,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"terminalType",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"portId",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:9,value:portId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"portId",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostRequestRent",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetRequestRent : BaseITWebAPIBody {
	
	//
												open var reqStatus:String?
    							open var orderId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestRent"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/requestRent"
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

		
open class MscPostStartReport : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var plugId:String?
    							open var result:String?
    							open var operId:String?
    							open var dataTime:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/startReport"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/startReport"
        	}

	//-------> list
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let plugId_ = self.plugId;
																					let result_ = self.result;
																					let operId_ = self.operId;
																					let dataTime_ = self.dataTime;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostStartReport",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:6,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"plugId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:6,value:plugId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"plugId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"result",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:6,value:result_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"result",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:6,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"dataTime",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:6,value:dataTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"dataTime",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostStartReport",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetStartReport : BaseITWebAPIBody {
	
	//
							
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/startReport"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/startReport"
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

		
open class MscPostStopReport : BaseITWebAPIBody {
	
	//
						open var deviceId:String?
    							open var plugId:String?
    							open var stopReason:String?
    							open var stopPower:String?
    							open var remain:String?
    							open var remainTime:String?
    							open var operId:String?
    							open var dataTime:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stopReport"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stopReport"
        	}

	//-------> list
			    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let deviceId_ = self.deviceId;
																					let plugId_ = self.plugId;
																					let stopReason_ = self.stopReason;
																					let stopPower_ = self.stopPower;
																					let remain_ = self.remain;
																					let remainTime_ = self.remainTime;
																					let operId_ = self.operId;
																					let dataTime_ = self.dataTime;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostStopReport",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:9,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"plugId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:9,value:plugId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"plugId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"stopReason",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:9,value:stopReason_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"stopReason",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"stopPower",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:9,value:stopPower_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"stopPower",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"remain",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:9,value:remain_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"remain",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"remainTime",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:9,value:remainTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"remainTime",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:9,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"dataTime",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:9,value:dataTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"dataTime",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostStopReport",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetStopReport : BaseITWebAPIBody {
	
	//
							
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stopReport"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stopReport"
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

		
open class MscPostQueryMscStation : BaseITWebAPIBody {
	
	//
						open var serviceId:String?
    							open var keyword:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var range:String?
    							open var version:String?
    							open var terminalType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscStation"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscStation"
        	}

	//-------> list
			    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let serviceId_ = self.serviceId;
																					let keyword_ = self.keyword;
																					let coordinate_ = self.coordinate;
																					let coordType_ = self.coordType;
																					let range_ = self.range;
																					let version_ = self.version;
																					let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostQueryMscStation",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:8,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"keyword",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:8,value:keyword_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"keyword",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"coordinate",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:8,value:coordinate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"coordinate",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"coordType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:8,value:coordType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"coordType",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"range",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:8,value:range_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"range",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"version",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:8,value:version_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"version",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:8,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"terminalType",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostQueryMscStation",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetQueryMscStation : BaseITWebAPIBody {
	
	//
												open var datacount:String?
    				    		//----->list
			open var data = [MscRetQueryMscStationDetail]()
			//>-----
			
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscStation"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/queryMscStation"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = visitableSource.getValue("datacount")
																					//----->list
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( MscRetQueryMscStationDetail (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> list
			    		    		    			    open func addData(subBody:MscRetQueryMscStationDetail) -> Void{
	        data.append(subBody)
	    }

	    open func getData() -> [MscRetQueryMscStationDetail]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    																								
    open class MscRetQueryMscStationDetail : BaseITWebAPIBody {
        
        //
        open var deviceId:String?
        open var deviceName:String?
        open var coordinate:String?
        open var coordType:String?
        open var address:String?
        open var status:String?
        open var cityCode:String?
        open var rentcount:String?
        
        required public init(){
            super.init()
            self.appId_ = "51"
            self.appName_ = "msc"
            self.mapping_ = "/api/msc/business/queryMscStation"
        }
        
        required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
            self.init()
            self.appId_ = "51"
            self.appName_ = "msc"
            self.mapping_ = "/api/msc/business/queryMscStation"
            //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
            }
            deviceId = visitableSource.getValue("deviceId")
            deviceName = visitableSource.getValue("deviceName")
            coordinate = visitableSource.getValue("coordinate")
            coordType = visitableSource.getValue("coordType")
            address = visitableSource.getValue("address")
            status = visitableSource.getValue("status")
            cityCode = visitableSource.getValue("cityCode")
            rentcount = visitableSource.getValue("rentcount")
        }
        
        //-------> list
        
        override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
        
        
        open func isRequestBody() -> Bool{
            return false;
        }
    }
						}

		
open class MscPostStationDetailed : BaseITWebAPIBody {
	
	//
						open var serviceId:String?
    							open var stationId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationDetailed"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationDetailed"
        	}

	//-------> list
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let serviceId_ = self.serviceId;
																					let stationId_ = self.stationId;
									
		//====   md5 check   ====
		
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MscPostStationDetailed",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:3,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"stationId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:3,value:stationId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"stationId",body:self))
									result.append(vo.onObjectEnd(index,length:length,objname:"MscPostStationDetailed",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MscRetStationDetailed : BaseITWebAPIBody {
	
	//
												open var mainDevCount:String?
    							open var portDevCount:String?
    							open var rentcount:String?
    		
	required public init(){
		super.init()
		self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationDetailed"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "51"
		self.appName_ = "msc"
		self.mapping_ = "/api/msc/business/stationDetailed"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											mainDevCount = visitableSource.getValue("mainDevCount")
																											portDevCount = visitableSource.getValue("portDevCount")
																											rentcount = visitableSource.getValue("rentcount")
															}

	//-------> list
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }
