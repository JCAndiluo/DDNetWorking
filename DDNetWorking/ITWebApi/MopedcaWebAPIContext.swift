import Foundation

// MARK: Factory
open class MopedcaWebAPIContext : ITWebAPIContext{
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
        				case "/mopedca/business/request":
				if type == .requestBody {
                    body = MopedcaPostMopedRequest()
                } else {
                    body = MopedcaRetMopedRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/checkRequest":
				if type == .requestBody {
                    body = MopedcaPostCheckRequest()
                } else {
                    body = MopedcaRetCheckRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/querydevices":
				if type == .requestBody {
                    body = MopedcaPostQueryMopedDevices()
                } else {
                    body = MopedcaRetQueryMopedDevices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/getdevicestatus":
				if type == .requestBody {
                    body = MopedcaPostGetMopedStatus()
                } else {
                    body = MopedcaRetGetMopedStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/hireinfo":
				if type == .requestBody {
                    body = MopedcaPostHireinfo()
                } else {
                    body = MopedcaRetHireinfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/restoreinfo":
				if type == .requestBody {
                    body = MopedcaPostRestoreinfo()
                } else {
                    body = MopedcaRetRestoreinfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/mopedca/business/errorhdlinfo":
				if type == .requestBody {
                    body = MopedcaPostErrorhdlinfo()
                } else {
                    body = MopedcaRetErrorhdlinfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}


		
open class MopedcaPostMopedRequest : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var terminalType:String?
    							open var requestType:String?
    							open var siteNum:String?
    							open var parkNum:String?
    							open var deviceId:String?
    							open var dateTime:String?
    							open var cityCode:String?
    							open var bizType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/request"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/request"
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
																					let siteNum_ = secureKeys?["AES"]?.encrypt(original: self.siteNum) ?? ""
																					let parkNum_ = secureKeys?["AES"]?.encrypt(original: self.parkNum) ?? ""
																					let deviceId_ = secureKeys?["AES"]?.encrypt(original: self.deviceId) ?? ""
																					let dateTime_ = secureKeys?["AES"]?.encrypt(original: self.dateTime) ?? ""
																					let cityCode_ = self.cityCode;
																					let bizType_ = self.bizType;
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("accessToken=" + (accessToken_ ?? ""))
																					md5.append("&serviceId=" + (serviceId_ ?? ""))
																					md5.append("&appId=" + (appId_ ?? ""))
																					md5.append("&terminalType=" + (terminalType_ ?? ""))
																					md5.append("&requestType=" + (requestType_ ?? ""))
																					md5.append("&siteNum=" + (siteNum_ ?? ""))
																					md5.append("&parkNum=" + (parkNum_ ?? ""))
																					md5.append("&deviceId=" + (deviceId_ ?? ""))
																					md5.append("&dateTime=" + (dateTime_ ?? ""))
																												
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostMopedRequest",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:12,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:12,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:12,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:12,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:12,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:12,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:12,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:12,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:12,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:12,field:"terminalType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:12,value:terminalType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:12,field:"terminalType",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:12,field:"requestType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:12,value:requestType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:12,field:"requestType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:12,field:"siteNum",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:12,value:siteNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:12,field:"siteNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:12,field:"parkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:12,value:parkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:12,field:"parkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:12,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:12,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:12,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:9,length:12,field:"dateTime",body:self))
				result.append(vo.onFieldValue(.flat,index:9,length:12,value:dateTime_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:9,length:12,field:"dateTime",body:self))
												result.append(vo.onFieldBegin(.flat,index:10,length:12,field:"cityCode",body:self))
				result.append(vo.onFieldValue(.flat,index:10,length:12,value:cityCode_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:10,length:12,field:"cityCode",body:self))
												result.append(vo.onFieldBegin(.flat,index:11,length:12,field:"bizType",body:self))
				result.append(vo.onFieldValue(.flat,index:11,length:12,value:bizType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:11,length:12,field:"bizType",body:self))
									result.append(vo.onFieldBegin(.flat,index:12,length:12,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:12,length:12,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:12,length:12,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostMopedRequest",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetMopedRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var reqStatus:String?
    							open var serviceId:String?
    							open var orderId:String?
    							open var reqExtra:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/request"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/request"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
																											reqStatus = visitableSource.getValue("reqStatus")
																											serviceId = visitableSource.getValue("serviceId")
																											orderId = visitableSource.getValue("orderId")
																											reqExtra = visitableSource.getValue("reqExtra")
															}

	//-------> one-to-many
			    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MopedcaPostCheckRequest : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var siteNum:String?
    							open var parkNum:String?
    							open var bizType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/checkRequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/checkRequest"
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
																					let siteNum_ = secureKeys?["AES"]?.encrypt(original: self.siteNum) ?? ""
																					let parkNum_ = secureKeys?["AES"]?.encrypt(original: self.parkNum) ?? ""
																					let bizType_ = self.bizType;
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("accessToken=" + (accessToken_ ?? ""))
																					md5.append("&serviceId=" + (serviceId_ ?? ""))
																					md5.append("&appId=" + (appId_ ?? ""))
																					md5.append("&siteNum=" + (siteNum_ ?? ""))
																					md5.append("&parkNum=" + (parkNum_ ?? ""))
																					
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostCheckRequest",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:7,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:7,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"siteNum",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:7,value:siteNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"siteNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"parkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:7,value:parkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"parkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"bizType",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:7,value:bizType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"bizType",body:self))
									result.append(vo.onFieldBegin(.flat,index:7,length:7,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:7,length:7,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:7,length:7,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostCheckRequest",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetCheckRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var reqStatus:String?
    							open var serviceId:String?
    							open var operId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/checkRequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/checkRequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
																											reqStatus = visitableSource.getValue("reqStatus")
																											serviceId = visitableSource.getValue("serviceId")
																											operId = visitableSource.getValue("operId")
															}

	//-------> one-to-many
			    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MopedcaPostQueryMopedDevices : BaseITWebAPIBody {
	
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
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/querydevices"
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
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostQueryMopedDevices",body:self))
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
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostQueryMopedDevices",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetQueryMopedDevices : BaseITWebAPIBody {
	
    open var datacount:String?
    open var data = [MopedcaRetQueryDevicesDetail]()
			
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/querydevices"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
																					//----->one-to-manay
					for visitableSource in visitableSource.getSubSource("data") {
						data .append( MopedcaRetQueryDevicesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
					}
					//>-----
										}

	//-------> one-to-many
			    		    		    			    open func addMopedcaRetQueryDevicesDetail(subBody:MopedcaRetQueryDevicesDetail) -> Void{
	        data.append(subBody)
	    }

	    open func getMopedcaRetQueryDevicesDetail() -> [MopedcaRetQueryDevicesDetail]{
	        return data
	    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
}
open class MopedcaRetQueryDevicesDetail : BaseITWebAPIBody {
    
    //
    open var deviceId:String?
    open var deviceName:String?
    open var coordinate:String?
    open var coordType:String?
    open var address:String?
    open var status:String?
    open var updatetime:String?
    open var totalcount:String?
    open var rentcount:String?
    open var restorecount:String?
    open var type:String?
    
    required public init(){
        super.init()
        self.appId_ = "41"
        self.appName_ = "mopedca"
        self.mapping_ = "/mopedca/business/querydevices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
        self.appName_ = "mopedca"
        self.mapping_ = "/mopedca/business/querydevices"
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
        totalcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("totalcount"))
        rentcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("rentcount"))
        restorecount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restorecount"))
        type = visitableSource.getValue("type")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class MopedcaPostGetMopedStatus : BaseITWebAPIBody {
	
						open var appId:String?
    							open var serviceId:String?
    							open var deviceId:String?
    							open var type:String?
    
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/getdevicestatus"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/getdevicestatus"
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
																					let deviceId_ = secureKeys?["AES"]?.encrypt(original: self.deviceId) ?? ""
																					let type_ = secureKeys?["AES"]?.encrypt(original: self.type) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("appId=" + (appId_ ?? ""))
																					md5.append("&serviceId=" + (serviceId_ ?? ""))
																					md5.append("&deviceId=" + (deviceId_ ?? ""))
																					md5.append("&type=" + (type_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostGetMopedStatus",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:5,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"deviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:5,value:deviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"deviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"type",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:5,value:type_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"type",body:self))
									result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostGetMopedStatus",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetGetMopedStatus : BaseITWebAPIBody {
	
	//
												open var deviceId:String?
    							open var deviceName:String?
    							open var coordinate:String?
    							open var coordType:String?
    							open var address:String?
    							open var status:String?
    							open var updatetime:String?
    							open var totalcount:String?
    							open var rentcount:String?
    							open var restorecount:String?
    							open var posinfos:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/getdevicestatus"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/getdevicestatus"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											deviceId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceId"))
																											deviceName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("deviceName"))
																											coordinate = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordinate"))
																											coordType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("coordType"))
																											address = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("address"))
																											status = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("status"))
																											updatetime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("updatetime"))
																											totalcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("totalcount"))
																											rentcount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("rentcount"))
																											restorecount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restorecount"))
																											posinfos = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("posinfos"))
															}

	//-------> one-to-many
			    		    		    		    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }

		
open class MopedcaPostHireinfo : BaseITWebAPIBody {
	
	//
						open var userId:String?
    							open var userPhone:String?
    							open var cityCode:String?
    							open var bikeId:String?
    							open var loginType:String?
    							open var hireDeviceId:String?
    							open var hireDeviceName:String?
    							open var hireParkNum:String?
    							open var hireDate:String?
    							open var operId:String?
    							open var cityName:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/hireinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/hireinfo"
        	}

	//-------> one-to-many
			    		    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let userId_ = secureKeys?["AES"]?.encrypt(original: self.userId) ?? ""
																					let userPhone_ = secureKeys?["AES"]?.encrypt(original: self.userPhone) ?? ""
																					let cityCode_ = secureKeys?["AES"]?.encrypt(original: self.cityCode) ?? ""
																					let bikeId_ = secureKeys?["AES"]?.encrypt(original: self.bikeId) ?? ""
																					let loginType_ = secureKeys?["AES"]?.encrypt(original: self.loginType) ?? ""
																					let hireDeviceId_ = secureKeys?["AES"]?.encrypt(original: self.hireDeviceId) ?? ""
																					let hireDeviceName_ = secureKeys?["AES"]?.encrypt(original: self.hireDeviceName) ?? ""
																					let hireParkNum_ = secureKeys?["AES"]?.encrypt(original: self.hireParkNum) ?? ""
																					let hireDate_ = secureKeys?["AES"]?.encrypt(original: self.hireDate) ?? ""
																					let operId_ = secureKeys?["AES"]?.encrypt(original: self.operId) ?? ""
																					let cityName_ = secureKeys?["AES"]?.encrypt(original: self.cityName) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("userId=" + (userId_ ?? ""))
																					md5.append("&userPhone=" + (userPhone_ ?? ""))
																					md5.append("&cityCode=" + (cityCode_ ?? ""))
																					md5.append("&bikeId=" + (bikeId_ ?? ""))
																					md5.append("&loginType=" + (loginType_ ?? ""))
																					md5.append("&hireDeviceId=" + (hireDeviceId_ ?? ""))
																					md5.append("&hireDeviceName=" + (hireDeviceName_ ?? ""))
																					md5.append("&hireParkNum=" + (hireParkNum_ ?? ""))
																					md5.append("&hireDate=" + (hireDate_ ?? ""))
																					md5.append("&operId=" + (operId_ ?? ""))
																					md5.append("&cityName=" + (cityName_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostHireinfo",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:12,field:"userId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:12,value:userId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:12,field:"userId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:12,field:"userPhone",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:12,value:userPhone_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:12,field:"userPhone",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:12,field:"cityCode",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:12,value:cityCode_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:12,field:"cityCode",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:12,field:"bikeId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:12,value:bikeId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:12,field:"bikeId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:12,field:"loginType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:12,value:loginType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:12,field:"loginType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:12,field:"hireDeviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:12,value:hireDeviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:12,field:"hireDeviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:12,field:"hireDeviceName",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:12,value:hireDeviceName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:12,field:"hireDeviceName",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:12,field:"hireParkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:12,value:hireParkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:12,field:"hireParkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:9,length:12,field:"hireDate",body:self))
				result.append(vo.onFieldValue(.flat,index:9,length:12,value:hireDate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:9,length:12,field:"hireDate",body:self))
												result.append(vo.onFieldBegin(.flat,index:10,length:12,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:10,length:12,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:10,length:12,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:11,length:12,field:"cityName",body:self))
				result.append(vo.onFieldValue(.flat,index:11,length:12,value:cityName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:11,length:12,field:"cityName",body:self))
									result.append(vo.onFieldBegin(.flat,index:12,length:12,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:12,length:12,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:12,length:12,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostHireinfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetHireinfo : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/hireinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/hireinfo"
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

		
open class MopedcaPostRestoreinfo : BaseITWebAPIBody {
	
	//
						open var userId:String?
    							open var userPhone:String?
    							open var cityCode:String?
    							open var bikeId:String?
    							open var loginType:String?
    							open var hireDeviceId:String?
    							open var hireDeviceName:String?
    							open var hireParkNum:String?
    							open var hireDate:String?
    							open var restoreDeviceId:String?
    							open var restoreDeviceName:String?
    							open var restoreParkNum:String?
    							open var restoreDate:String?
    							open var hireFee:String?
    							open var operId:String?
    							open var cityName:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/restoreinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/restoreinfo"
        	}

	//-------> one-to-many
			    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let userId_ = secureKeys?["AES"]?.encrypt(original: self.userId) ?? ""
																					let userPhone_ = secureKeys?["AES"]?.encrypt(original: self.userPhone) ?? ""
																					let cityCode_ = secureKeys?["AES"]?.encrypt(original: self.cityCode) ?? ""
																					let bikeId_ = secureKeys?["AES"]?.encrypt(original: self.bikeId) ?? ""
																					let loginType_ = secureKeys?["AES"]?.encrypt(original: self.loginType) ?? ""
																					let hireDeviceId_ = secureKeys?["AES"]?.encrypt(original: self.hireDeviceId) ?? ""
																					let hireDeviceName_ = secureKeys?["AES"]?.encrypt(original: self.hireDeviceName) ?? ""
																					let hireParkNum_ = secureKeys?["AES"]?.encrypt(original: self.hireParkNum) ?? ""
																					let hireDate_ = secureKeys?["AES"]?.encrypt(original: self.hireDate) ?? ""
																					let restoreDeviceId_ = secureKeys?["AES"]?.encrypt(original: self.restoreDeviceId) ?? ""
																					let restoreDeviceName_ = secureKeys?["AES"]?.encrypt(original: self.restoreDeviceName) ?? ""
																					let restoreParkNum_ = secureKeys?["AES"]?.encrypt(original: self.restoreParkNum) ?? ""
																					let restoreDate_ = secureKeys?["AES"]?.encrypt(original: self.restoreDate) ?? ""
																					let hireFee_ = secureKeys?["AES"]?.encrypt(original: self.hireFee) ?? ""
																					let operId_ = secureKeys?["AES"]?.encrypt(original: self.operId) ?? ""
																					let cityName_ = secureKeys?["AES"]?.encrypt(original: self.cityName) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("userId=" + (userId_ ?? ""))
																					md5.append("&userPhone=" + (userPhone_ ?? ""))
																					md5.append("&cityCode=" + (cityCode_ ?? ""))
																					md5.append("&bikeId=" + (bikeId_ ?? ""))
																					md5.append("&loginType=" + (loginType_ ?? ""))
																					md5.append("&hireDeviceId=" + (hireDeviceId_ ?? ""))
																					md5.append("&hireDeviceName=" + (hireDeviceName_ ?? ""))
																					md5.append("&hireParkNum=" + (hireParkNum_ ?? ""))
																					md5.append("&hireDate=" + (hireDate_ ?? ""))
																					md5.append("&restoreDeviceId=" + (restoreDeviceId_ ?? ""))
																					md5.append("&restoreDeviceName=" + (restoreDeviceName_ ?? ""))
																					md5.append("&restoreParkNum=" + (restoreParkNum_ ?? ""))
																					md5.append("&restoreDate=" + (restoreDate_ ?? ""))
																					md5.append("&hireFee=" + (hireFee_ ?? ""))
																					md5.append("&operId=" + (operId_ ?? ""))
																					md5.append("&cityName=" + (cityName_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostRestoreinfo",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:17,field:"userId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:17,value:userId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:17,field:"userId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:17,field:"userPhone",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:17,value:userPhone_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:17,field:"userPhone",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:17,field:"cityCode",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:17,value:cityCode_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:17,field:"cityCode",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:17,field:"bikeId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:17,value:bikeId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:17,field:"bikeId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:17,field:"loginType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:17,value:loginType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:17,field:"loginType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:17,field:"hireDeviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:17,value:hireDeviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:17,field:"hireDeviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:17,field:"hireDeviceName",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:17,value:hireDeviceName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:17,field:"hireDeviceName",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:17,field:"hireParkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:17,value:hireParkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:17,field:"hireParkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:9,length:17,field:"hireDate",body:self))
				result.append(vo.onFieldValue(.flat,index:9,length:17,value:hireDate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:9,length:17,field:"hireDate",body:self))
												result.append(vo.onFieldBegin(.flat,index:10,length:17,field:"restoreDeviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:10,length:17,value:restoreDeviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:10,length:17,field:"restoreDeviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:11,length:17,field:"restoreDeviceName",body:self))
				result.append(vo.onFieldValue(.flat,index:11,length:17,value:restoreDeviceName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:11,length:17,field:"restoreDeviceName",body:self))
												result.append(vo.onFieldBegin(.flat,index:12,length:17,field:"restoreParkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:12,length:17,value:restoreParkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:12,length:17,field:"restoreParkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:13,length:17,field:"restoreDate",body:self))
				result.append(vo.onFieldValue(.flat,index:13,length:17,value:restoreDate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:13,length:17,field:"restoreDate",body:self))
												result.append(vo.onFieldBegin(.flat,index:14,length:17,field:"hireFee",body:self))
				result.append(vo.onFieldValue(.flat,index:14,length:17,value:hireFee_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:14,length:17,field:"hireFee",body:self))
												result.append(vo.onFieldBegin(.flat,index:15,length:17,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:15,length:17,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:15,length:17,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:16,length:17,field:"cityName",body:self))
				result.append(vo.onFieldValue(.flat,index:16,length:17,value:cityName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:16,length:17,field:"cityName",body:self))
									result.append(vo.onFieldBegin(.flat,index:17,length:17,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:17,length:17,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:17,length:17,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostRestoreinfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetRestoreinfo : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/restoreinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/restoreinfo"
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

		
open class MopedcaPostErrorhdlinfo : BaseITWebAPIBody {
	
	//
						open var userId:String?
    							open var userPhone:String?
    							open var cityCode:String?
    							open var bikeId:String?
    							open var loginType:String?
    							open var errorhdlDeviceId:String?
    							open var errorhdlDeviceName:String?
    							open var errorhdlParkNum:String?
    							open var errorhdlDate:String?
    							open var operId:String?
    							open var cityName:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/errorhdlinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/errorhdlinfo"
        	}

	//-------> one-to-many
			    		    		    		    		    		    		    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

		override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
														let userId_ = self.userId;
																					let userPhone_ = self.userPhone;
																					let cityCode_ = self.cityCode;
																					let bikeId_ = self.bikeId;
																					let loginType_ = self.loginType;
																					let errorhdlDeviceId_ = self.errorhdlDeviceId;
																					let errorhdlDeviceName_ = self.errorhdlDeviceName;
																					let errorhdlParkNum_ = self.errorhdlParkNum;
																					let errorhdlDate_ = self.errorhdlDate;
																					let operId_ = self.operId;
																					let cityName_ = secureKeys?["AES"]?.encrypt(original: self.cityName) ?? ""
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("userId=" + (userId_ ?? ""))
																					md5.append("&userPhone=" + (userPhone_ ?? ""))
																					md5.append("&cityCode=" + (cityCode_ ?? ""))
																					md5.append("&bikeId=" + (bikeId_ ?? ""))
																					md5.append("&loginType=" + (loginType_ ?? ""))
																					md5.append("&errorhdlDeviceId=" + (errorhdlDeviceId_ ?? ""))
																					md5.append("&errorhdlDeviceName=" + (errorhdlDeviceName_ ?? ""))
																					md5.append("&errorhdlParkNum=" + (errorhdlParkNum_ ?? ""))
																					md5.append("&errorhdlDate=" + (errorhdlDate_ ?? ""))
																					md5.append("&operId=" + (operId_ ?? ""))
																					md5.append("&cityName=" + (cityName_ ?? ""))
														
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"MopedcaPostErrorhdlinfo",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:12,field:"userId",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:12,value:userId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:12,field:"userId",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:12,field:"userPhone",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:12,value:userPhone_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:12,field:"userPhone",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:12,field:"cityCode",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:12,value:cityCode_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:12,field:"cityCode",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:12,field:"bikeId",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:12,value:bikeId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:12,field:"bikeId",body:self))
												result.append(vo.onFieldBegin(.flat,index:5,length:12,field:"loginType",body:self))
				result.append(vo.onFieldValue(.flat,index:5,length:12,value:loginType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:5,length:12,field:"loginType",body:self))
												result.append(vo.onFieldBegin(.flat,index:6,length:12,field:"errorhdlDeviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:6,length:12,value:errorhdlDeviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:6,length:12,field:"errorhdlDeviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:7,length:12,field:"errorhdlDeviceName",body:self))
				result.append(vo.onFieldValue(.flat,index:7,length:12,value:errorhdlDeviceName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:7,length:12,field:"errorhdlDeviceName",body:self))
												result.append(vo.onFieldBegin(.flat,index:8,length:12,field:"errorhdlParkNum",body:self))
				result.append(vo.onFieldValue(.flat,index:8,length:12,value:errorhdlParkNum_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:8,length:12,field:"errorhdlParkNum",body:self))
												result.append(vo.onFieldBegin(.flat,index:9,length:12,field:"errorhdlDate",body:self))
				result.append(vo.onFieldValue(.flat,index:9,length:12,value:errorhdlDate_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:9,length:12,field:"errorhdlDate",body:self))
												result.append(vo.onFieldBegin(.flat,index:10,length:12,field:"operId",body:self))
				result.append(vo.onFieldValue(.flat,index:10,length:12,value:operId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:10,length:12,field:"operId",body:self))
												result.append(vo.onFieldBegin(.flat,index:11,length:12,field:"cityName",body:self))
				result.append(vo.onFieldValue(.flat,index:11,length:12,value:cityName_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:11,length:12,field:"cityName",body:self))
									result.append(vo.onFieldBegin(.flat,index:12,length:12,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:12,length:12,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:12,length:12,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"MopedcaPostErrorhdlinfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class MopedcaRetErrorhdlinfo : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    		
	required public init(){
		super.init()
		self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/errorhdlinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "41"
		self.appName_ = "mopedca"
		self.mapping_ = "/mopedca/business/errorhdlinfo"
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
