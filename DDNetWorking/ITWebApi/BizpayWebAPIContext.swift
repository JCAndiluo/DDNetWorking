import Foundation

// MARK: Factory
open class BizpayWebAPIContext : ITWebAPIContext{
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
						case "/bizpay/payment/getOrder":
				if type == .requestBody {
                    body = BizpayPostGetOrder()
                } else {
                    body = BizpayRetGetOrder(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bizpay/payment/getCharge":
				if type == .requestBody {
                    body = BizpayPostGetCharge()
                } else {
                    body = BizpayRetGetCharge(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bizpay/payment/getOrders":
				if type == .requestBody {
                    body = BizpayPostGetOrders()
                } else {
                    body = BizpayRetGetOrders(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}
		
open class BizpayPostGetOrder : BaseITWebAPIBody {
	
    open var orderId:String?
    		
	required public init(){
		super.init()
		self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrder"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrder"
        	}

	//-------> one-to-many
			    		    
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

            //====encrypt field====
        let accessToken_ = self.accessToken;
        let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
            
            //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&orderId=" + (orderId_ ?? ""))
            
            //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizpayPostGetOrder",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizpayPostGetOrder",body:self))
        return result.joined(separator:"")
        }
        
    open func isRequestBody() -> Bool{
            return true;
    }
}
		
open class BizpayRetGetOrder : BaseITWebAPIBody {
    
    open var userId:String?
    open var subject:String?
    open var body:String?
    open var orderID:String?
    open var orderNo:String?
    open var orderStatus:String?
    open var orderMoney:String?
    open var orderType:String?
    open var createTime:String?
    open var paidTime:String?
    open var refundedTime:String?
    open var refundFlag:String?
    open var beforeDisMoney:String?
    open var couponId:String?
    
    required public init(){
        super.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getOrder"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getOrder"
                    //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            userId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("userId"))
            subject = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("subject"))
            body = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("body"))
            orderID = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderID"))
            orderNo = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderNo"))
            orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
            orderMoney = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderMoney"))
            beforeDisMoney = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("beforeDisMoney"))
            orderType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderType"))
            couponId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("couponId"))
            createTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("createTime"))
            paidTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("paidTime"))
            refundedTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("refundedTime"))
            refundFlag = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("refundFlag"))
        }

    //-------> one-to-many
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizpayPostGetCharge : BaseITWebAPIBody {
    
    //
                                    open var appChannel:String?
                                open var orderId:String?
                                open var channel:String?
                                open var openId:String?
                                open var money:String?
                                open var callbackURL:String?
                                open var couponId:String?
            
    required public init(){
        super.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/api/bizpay/payment/getCharge"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/api/bizpay/payment/getCharge"
            }

    //-------> list
                                                                                                    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

        override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }

        //====encrypt field====
                                                        let accessToken_ = self.accessToken;
                                                                                    let appChannel_ = self.appChannel;
                                                                                    let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
                                                                                    let channel_ = secureKeys?["AES"]?.encrypt(original: self.channel) ?? ""
                                                                                    let openId_ = secureKeys?["AES"]?.encrypt(original: self.openId) ?? ""
                                                                                    let money_ = self.money;
                                                                                    let callbackURL_ = self.callbackURL;
                                                                                    let couponId_ = self.couponId;
                                    
        //====   md5 check   ====
                    var md5:[String] = []
                                                            md5.append("accessToken=" + (accessToken_ ?? ""))
                                                                                                                md5.append("&orderId=" + (orderId_ ?? ""))
                                                                                    md5.append("&channel=" + (channel_ ?? ""))
                                                                                                                                                                        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizpayPostGetCharge",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"appChannel",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:9,value:appChannel_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"appChannel",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"orderId",body:self))
                result.append(vo.onFieldValue(.flat,index:3,length:9,value:orderId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"orderId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"channel",body:self))
                result.append(vo.onFieldValue(.flat,index:4,length:9,value:channel_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"channel",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"openId",body:self))
                result.append(vo.onFieldValue(.flat,index:5,length:9,value:openId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"openId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"money",body:self))
                result.append(vo.onFieldValue(.flat,index:6,length:9,value:money_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"money",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"callbackURL",body:self))
                result.append(vo.onFieldValue(.flat,index:7,length:9,value:callbackURL_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"callbackURL",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"couponId",body:self))
                result.append(vo.onFieldValue(.flat,index:8,length:9,value:couponId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"couponId",body:self))
                                    result.append(vo.onFieldBegin(.flat,index:9,length:9,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:9,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:9,field:"sign",body:self))
                result.append(vo.onObjectEnd(index,length:length,objname:"BizpayPostGetCharge",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

open class BizpayRetGetCharge : BaseITWebAPIBody {
    
    //
    open var chargeStatus:String?
    open var chargeData:String?
    
    required public init(){
        super.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getCharge"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getCharge"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        chargeStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("chargeStatus"))
        chargeData = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("chargeData"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizpayPostGetOrders : BaseITWebAPIBody {
	
    open var ordertype:String?
    open var orderStatus:String?
    open var start:String?
    open var limit:String?
    
	required public init(){
		super.init()
		self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrders"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrders"
        	}

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
		guard let vo = visitableObject else {
            return nil
        }

		//====encrypt field====
        let accessToken_ = self.accessToken;
        let ordertype_ = self.ordertype;
        let orderStatus_ = self.orderStatus;
        let start_ = self.start;
        let limit_ = self.limit;
        
		//====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&ordertype=" + (ordertype_ ?? ""))
        md5.append("&orderStatus=" + (orderStatus_ ?? ""))
        md5.append("&start=" + (start_ ?? ""))
        md5.append("&limit=" + (limit_ ?? ""))
        
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"BizpayPostGetOrders",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"ordertype",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:ordertype_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"ordertype",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"orderStatus",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:orderStatus_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"orderStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizpayPostGetOrders",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}
		
open class BizpayRetGetOrders : BaseITWebAPIBody {
	
	open var datacount:String?
    open var data = [BizpayPayOrderInfo]()
			
	required public init(){
		super.init()
		self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrders"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
		self.appName_ = "bizpay"
		self.mapping_ = "/bizpay/payment/getOrders"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizpayPayOrderInfo (visitableSource:visitableSource,secureKeys:secureKeys))
        }
    }

	//-------> one-to-many
    open func addBizpayPayOrderInfo(subBody:BizpayPayOrderInfo) -> Void{
        data.append(subBody)
    }

    open func getBizpayPayOrderInfo() -> [BizpayPayOrderInfo]{
        return data
    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }

	open func isRequestBody() -> Bool{
    	return false;
    }
}
open class BizpayPayOrderInfo : BaseITWebAPIBody {
    
    open var orderId:String?
    open var userId:String?
    open var subject:String?
    open var body:String?
    open var orderNo:String?
    open var orderStatus:String?
    open var orderMoney:String?
    open var orderType:String?
    open var createTime:String?
    open var paidTime:String?
    open var refundedTime:String?
    open var refundFlag:String?
    open var posId:String?
    open var carNum:String?
    
    required public init(){
        super.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getOrders"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "26"
        self.appName_ = "bizpay"
        self.mapping_ = "/bizpay/payment/getOrders"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
        orderId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderId"))
        userId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("userId"))
        subject = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("subject"))
        body = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("body"))
        orderNo = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderNo"))
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
        orderMoney = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderMoney"))
        orderType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderType"))
        createTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("createTime"))
        paidTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("paidTime"))
        refundedTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("refundedTime"))
        refundFlag = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("refundFlag"))
        posId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("posId"))
        carNum = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("carNum"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
