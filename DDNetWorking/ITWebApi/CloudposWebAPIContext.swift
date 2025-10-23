import Foundation

// MARK: Factory
open class CloudposWebAPIContext : ITWebAPIContext{
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
        				case "/cloudpos/business/qrcoderequest":
				if type == .requestBody {
                    body = CloudposPostQRCodeRequest()
                } else {
                    body = CloudposRetQRCodeRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
        case "/cloudpos/business/agree":
            if type == .requestBody {
                body = CloudposPostAgree()
            } else {
                body = CloudposRetAgree(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}


		
open class CloudposPostQRCodeRequest : BaseITWebAPIBody {
	
	//
									open var serviceId:String?
    							open var appId:String?
    							open var QRCodeType:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "cloudpos"
		self.mapping_ = "/cloudpos/business/qrcoderequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "cloudpos"
		self.mapping_ = "/cloudpos/business/qrcoderequest"
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
																					let QRCodeType_ = self.QRCodeType;
									
		//====   md5 check   ====
					var md5:[String] = []
															md5.append("accessToken=" + (accessToken_ ?? ""))
																					md5.append("&serviceId=" + (serviceId_ ?? ""))
																					md5.append("&appId=" + (appId_ ?? ""))
																					
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"CloudposPostQRCodeRequest",body:self))
											result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
				result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
												result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
				result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
												result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"appId",body:self))
				result.append(vo.onFieldValue(.flat,index:3,length:5,value:appId_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"appId",body:self))
												result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"QRCodeType",body:self))
				result.append(vo.onFieldValue(.flat,index:4,length:5,value:QRCodeType_ ?? "",body:self))
				result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"QRCodeType",body:self))
									result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
				result.append(vo.onObjectEnd(index,length:length,objname:"CloudposPostQRCodeRequest",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
    }

		
open class CloudposRetQRCodeRequest : BaseITWebAPIBody {
	
	//
												open var bizStatus:String?
    							open var result:String?
    							open var QRCodeStr:String?
    open var bizExtra:String?
    		
	required public init(){
		super.init()
		self.appId_ = "49"
		self.appName_ = "cloudpos"
		self.mapping_ = "/cloudpos/business/qrcoderequest"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
		self.appName_ = "cloudpos"
		self.mapping_ = "/cloudpos/business/qrcoderequest"
        			//====   md5 check   ====
			if !String.isEmpty(visitableSource.getValue("sign")) {
						}
																		retcode = visitableSource.getValue("retcode")
																											retmsg = visitableSource.getValue("retmsg")
																											bizStatus = visitableSource.getValue("bizStatus")
        bizExtra = visitableSource.getValue("bizExtra")
																											result = visitableSource.getValue("result")
																											QRCodeStr = visitableSource.getValue("QRCodeStr")
															}

	//-------> list
			    		    		    		    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	
	open func isRequestBody() -> Bool{
    	return false;
    }
    }
open class CloudposPostAgree : BaseITWebAPIBody {
    
    //
    open var agree:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "cloudpos"
        self.mapping_ = "/cloudpos/business/agree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "cloudpos"
        self.mapping_ = "/cloudpos/business/agree"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let agree_ = self.agree;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"CloudposPostAgree",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"agree",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:agree_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"agree",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"CloudposPostAgree",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class CloudposRetAgree : BaseITWebAPIBody {
    
    //
    open var bizStatus:String?
    open var bizExtra:String?
    
    required public init(){
        super.init()
        self.appId_ = "49"
        self.appName_ = "cloudpos"
        self.mapping_ = "/cloudpos/business/agree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "49"
        self.appName_ = "cloudpos"
        self.mapping_ = "/cloudpos/business/agree"
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
