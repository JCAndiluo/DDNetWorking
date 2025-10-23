import Foundation

// MARK: Factory
open class BikecaWebAPIContext : ITWebAPIContext{
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
        				case "/bikeca/business/bizinfo":
				if type == .requestBody {
                    body = BikecaPostBizinfo()
                } else {
                    body = BikecaRetBizinfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/serviceInfo":
				if type == .requestBody {
                    body = BikecaPostServiceinfo()
                } else {
                    body = BikecaRetServiceinfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/querydevices":
				if type == .requestBody {
                    body = BikecaPostQueryDevices()
                } else {
                    body = BikecaRetQueryDevices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/enabletrade":
				if type == .requestBody {
                    body = BikecaPostEnableTrade()
                } else {
                    body = BikecaRetEnableTrade(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/disabletrade":
				if type == .requestBody {
                    body = BikecaPostDisableTrade()
                } else {
                    body = BikecaRetDisableTrade(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/request":
				if type == .requestBody {
                    body = BikecaPostRequest()
                } else {
                    body = BikecaRetRequest(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/pertrips":
				if type == .requestBody {
                    body = BikecaPostPerTripRecords()
                } else {
                    body = BikecaRetPerTripRecords(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/bikeca/business/checkOrderStatus":
				if type == .requestBody {
                    body = BikecaPostCheckOrderStatus()
                } else {
                    body = BikecaRetCheckOrderStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/bikeca/business/checkCertifyStatus":
                            if type == .requestBody {
                                body = BikecaPostCheckCertifyStatus()
                            } else {
                                body = BikecaRetCheckCertifyStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                            }
            break
            
                        case "/bikeca/business/getdevicestatus":
                if type == .requestBody {
                    body = BikecaPostGetDeviceStatus()
                } else {
                    body = BikecaRetGetDeviceStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/bikeca/business/reletPriceList":
                if type == .requestBody {
                    body = BikecaPostReletPriceList()
                } else {
                    body = BikecaRetReletPriceList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/bikeca/business/insertReletRecord":
                if type == .requestBody {
                    body = BikecaPostInsertReletRecord()
                } else {
                    body = BikecaRetInsertReletRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/bikeca/business/getPriceList":
            if type == .requestBody {
                body = BikecaPostGetPriceList()
            } else {
                body = BikecaRetGetPriceList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            
                        case "/bikeca/business/tripOverView":
            if type == .requestBody {
                body = BikecaPostTripOverView()
            } else {
                body = BikecaRetTripOverView(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
                        case "/bikeca/business/queryProgress":

            if type == .requestBody {
                body = BikecaPostQueryProgress()
            } else {
                body = BikecaRetQueryProgress(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
                        case "/bikeca/business/revokeRefund":
            if type == .requestBody {
                body = BikecaPostRevokeRefund()
            } else {
                body = BikecaRetRevokeRefund(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            case "/bikeca/card/userBuyCard":
                if type == .requestBody {
                body = BikecaPostUserBuyCard()
            } else {
                body = BikecaRetUserBuyCard(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/card/queryCardDaysRemaining":
            if type == .requestBody {
                body = BikecaPostQueryCardDaysRemainingd()
            } else {
                body = BikecaRetQueryCardDaysRemaining(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            case "/bikeca/card/queryCardAndDaysRemaining":
            if type == .requestBody {
                body = BikecaPostQueryCardAndDaysRemainingd()
            } else {
                body = BikecaRetQueryCardAndDaysRemaining(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            case "/bikeca/card/getCardDetailList":
            if type == .requestBody {
                body = BikecaPostGetCardDetailList()
            } else {
                body = BikecaRetGetCardDetailList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/business/checkBuyOrderStatus":
            if type == .requestBody {
                body = BikecaPostCheckBuyOrderStatus()
            } else {
                body = BikecaRetCheckBuyOrderStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/card/getUserBuyCardList":
            if type == .requestBody {
                body = BikecaPostGetUserBuyCardList()
            } else {
                body = BikecaRetGetUserBuyCardList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/extra/getInvitationInfo":
            if type == .requestBody {
                body = BikecaPostGetInvitationInfo()
            } else {
                body = BikecaRetGetInvitationInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/extra/inviteExpr":
            if type == .requestBody {
                body = BikecaPostInviteExpr()
            } else {
                body = BikecaRetInviteExpr(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/config/getCommonConfigList":
            if type == .requestBody {
                body = BikecaPostGetCommonConfigList()
            } else {
                body = BikecaRetGetCommonConfigList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/bikeca/business/checkCloudPosOrderStatus":
            if type == .requestBody {
                body = BikecaPostCheckCloudPosOrderStatus()
            } else {
                body = BikecaRetCheckCloudPosOrderStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/business/useWalletForBusiness":
            if type == .requestBody {
                body = BikecaPostUseWalletForBusiness()
            } else {
                body = BikecaRetUseWalletForBusiness(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/business/openBizAgree":
            if type == .requestBody {
                body = BikecaPostOpenBizAgree()
            } else {
                body = BikecaRetOpenBizAgree(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/business/getBizAgree":
            if type == .requestBody {
                body = BikecaPostGetBizAgree()
            } else {
                body = BikecaRetGetBizAgree(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/extra/intimateBind":
            if type == .requestBody {
                body = BikecaPostIntimateBind()
            } else {
                body = BikecaRetIntimateBind(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
        case "/api/bikeca/business/getTripInfo":
            if type == .requestBody {
                body = BikecaPostGetTripInfo()
            } else {
                body = BikecaRetGetTripInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/purchase/checkYearCardOrder":
            if type == .requestBody {
                body = BikecaPostCheckYearCardOrder()
            } else {
                body = BikecaRetCheckYearCardOrder(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bikeca/card/queryUserCard":
            if type == .requestBody {
                body = BikecaPostQueryUserCard()
            } else {
                body = BikecaRetQueryUserCard(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            case "/api/bikeca/business/realNameFreeBet":
            if type == .requestBody {
                body = BikecaPostRealNameFreeBet()
            } else {
                body = BikecaRetRealNameFreeBet(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

		
open class BikecaPostBizinfo : BaseITWebAPIBody {
	
    open var appId:String?
    open var serviceId:String?
    open var bizType:String?
    open var terminalType:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/bizinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/bizinfo"
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
        let bizType_ = self.bizType;
        let terminalType_ = self.terminalType;
									
		//====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
            
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostBizinfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"bizType",body:self))
            result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"terminalType",body:self))
            result.append(vo.onFieldValue(.flat,index:5,length:6,value:terminalType_ ?? "",body:self))
            result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
            
		result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostBizinfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}

		
open class BikecaRetBizinfo : BaseITWebAPIBody {
	
    open var sysTime:String?
    open var userId:String?
    open var phoneNum:String?
    open var bizStatus:String?
    open var bizExtra:String?
    open var bizMoney:String?

    open var reqStatus:String?
    open var reqExtra:String?
    open var operId:String?
    open var openid: String?
    open var openTime:String?
    open var closeTime:String?
    //3.0 新增属性
    open var setTerminalType:String? //设备类型
    open var bizType:String?
    open var requestType:String?
    
    //3.3 新增属性
    open var certStatus:String? //身份认证状态
    
    open var enableMode:String? //开通模式
    
	required public init(){
        
		super.init()
        
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/bizinfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/bizinfo"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            sysTime = visitableSource.getValue("sysTime")
            userId = visitableSource.getValue("userId")
            phoneNum = visitableSource.getValue("phoneNum")
            bizStatus = visitableSource.getValue("bizStatus")
            bizExtra = visitableSource.getValue("bizExtra")
            bizMoney = visitableSource.getValue("bizMoney")
            certStatus = visitableSource.getValue("certStatus")
            enableMode = visitableSource.getValue("enableMode")
            openTime = visitableSource.getValue("openTime")
            closeTime = visitableSource.getValue("closeTime")
            operId = visitableSource.getValue("operId")
        }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }
	
	open func isRequestBody() -> Bool{
    	return false;
    }
}

		
open class BikecaPostServiceinfo : BaseITWebAPIBody {
	
    open var appId:String?
    open var serviceId:String?
    open var bizType:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/serviceInfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/serviceInfo"
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
        let bizType_ = self.bizType;
									
		//====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
																					
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostServiceinfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:4,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:4,length:4,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostServiceinfo",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}

open class BikecaRetServiceinfo : BaseITWebAPIBody {
	
    open var serviceId:String?
    open var serviceName:String?
    open var openMoney:String?
    open var serviceExtra:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/serviceInfo"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/serviceInfo"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            serviceId = visitableSource.getValue("serviceId")
            serviceName = visitableSource.getValue("serviceName")
            openMoney = visitableSource.getValue("openMoney")
            serviceExtra = visitableSource.getValue("serviceExtra")
        }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
	
	open func isRequestBody() -> Bool{
    	return false;
    }
}
		
open class BikecaPostQueryDevices : BaseITWebAPIBody {
	
    open var appId:String?
    open var serviceId:String?
    open var keyword:String?
    open var coordinate:String?
    open var coordType:String?
    open var range:String?
    open var type:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/querydevices"
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
		result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostQueryDevices",body:self))
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
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostQueryDevices",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}

		
open class BikecaRetQueryDevices : BaseITWebAPIBody {
	
    open var datacount:String?
    open var data = [BikecaRetQueryDevicesDetail]()
			
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/querydevices"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/querydevices"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
																					//----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaRetQueryDevicesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
    }

	//-------> one-to-many
    open func addBikecaRetQueryDevicesDetail(subBody:BikecaRetQueryDevicesDetail) -> Void{
        data.append(subBody)
    }

    open func getBikecaRetQueryDevicesDetail() -> [BikecaRetQueryDevicesDetail]{
        return data
    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }

	open func isRequestBody() -> Bool{
    	return false;
    }
}
open class BikecaRetQueryDevicesDetail : BaseITWebAPIBody {
    
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
    open var redpacPileFlag:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/querydevices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/querydevices"
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
        redpacPileFlag = visitableSource.getValue("redpacPileFlag")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
		
open class BikecaPostEnableTrade : BaseITWebAPIBody {
	
    open var serviceId:String?
    open var appId:String?
    open var bizType:String?
    open var bizLevel:String?
    open var certMode:String?
    open var certParams:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/enabletrade"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/enabletrade"
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
        let bizType_ = secureKeys?["AES"]?.encrypt(original: self.bizType) ?? ""
        let bizLevel_ = secureKeys?["AES"]?.encrypt(original: self.bizLevel) ?? ""
        let certMode_ = self.certMode
        let certParams_ = self.certParams
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&bizType=" + (bizType_ ?? ""))
        md5.append("&bizLevel=" + (bizLevel_ ?? ""))
            
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostEnableTrade",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"bizLevel",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:bizLevel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"bizLevel",body:self))
        
        result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"certMode",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:8,value:certMode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"certMode",body:self))
        
        result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"certParams",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:8,value:certParams_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"certParams",body:self))
        
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostEnableTrade",body:self))
        return result.joined(separator:"")
    }
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}
		
open class BikecaRetEnableTrade : BaseITWebAPIBody {
	
    open var bizStatus:String?
    open var orderId:String?
    open var orderNo:String?
    open var certStatus:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/enabletrade"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/enabletrade"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            bizStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bizStatus"))
            orderId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderId"))
            orderNo = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderNo"))
            certStatus = visitableSource.getValue("certStatus")
        }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }
	
	open func isRequestBody() -> Bool{
    	return false;
    }
}
		
open class BikecaPostDisableTrade : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var bizType:String?
    open var refReason:String?
    open var terminalType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/disabletrade"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/disabletrade"
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
        let bizType_ = secureKeys?["AES"]?.encrypt(original: self.bizType) ?? ""
        let refReason_ = self.refReason;
        let terminalType_ = self.terminalType;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&bizType=" + (bizType_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostDisableTrade",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"refReason",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:refReason_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"refReason",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:7,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostDisableTrade",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetDisableTrade : BaseITWebAPIBody {
    
    //
    open var bizStatus:String?
    open var closeTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/disabletrade"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/disabletrade"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bizStatus"))
        closeTime = visitableSource.getValue("closeTime")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostRequest : BaseITWebAPIBody {
	
    open var serviceId:String?
    open var appId:String?
    open var terminalType:String?
    open var requestType:String?
    open var DeviceId:String?
    open var parkNum:String?
    open var cityCode:String?
    open var bizType:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/request"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/request"
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
		result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostRequest",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:10,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:10,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:10,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:10,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:10,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:10,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:10,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:10,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:10,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:10,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:10,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:10,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:10,field:"requestType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:10,value:requestType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:10,field:"requestType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:10,field:"DeviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:10,value:DeviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:10,field:"DeviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:10,field:"parkNum",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:10,value:parkNum_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:10,field:"parkNum",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:10,field:"cityCode",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:10,value:cityCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:10,field:"cityCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:10,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:10,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:10,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:10,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:10,length:10,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:10,length:10,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostRequest",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}
		
open class BikecaRetRequest: BaseITWebAPIBody {
	
    open var bizStatus:String?
    open var reqStatus:String?
    open var serviceId:String?
    open var orderId:String?
    open var reqExtra:String?
    open var operId:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/request"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/request"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            bizStatus = visitableSource.getValue("bizStatus")
            reqStatus = visitableSource.getValue("reqStatus")
            serviceId = visitableSource.getValue("serviceId")
            orderId = visitableSource.getValue("orderId")
            reqExtra = visitableSource.getValue("reqExtra")
            operId = visitableSource.getValue("operId")
        }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }
	
	open func isRequestBody() -> Bool{
    	return false;
    }
}
		
open class BikecaPostPerTripRecords : BaseITWebAPIBody {
	
    open var serviceId:String?
    open var appId:String?
    open var beginindex:String?
    open var retcount:String?
    
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/pertrips"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/pertrips"
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
        let beginindex_ = secureKeys?["AES"]?.encrypt(original: self.beginindex) ?? ""
        let retcount_ = secureKeys?["AES"]?.encrypt(original: self.retcount) ?? ""
									
		//====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&beginindex=" + (beginindex_ ?? ""))
        md5.append("&retcount=" + (retcount_ ?? ""))
            
		//====serialize field====
		var result:[String] = []
		result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostPerTripRecords",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"retcount",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
		result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
		result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostPerTripRecords",body:self))
		return result.joined(separator:"")
	}
	
	open func isRequestBody() -> Bool{
    	return true;
    }
}

open class BikecaRetPerTripRecords : BaseITWebAPIBody {
	
    open var tempLockPwd:String?
    open var datacount:String?
    open var data = [BikecaPerTripRecord]()
			
	required public init(){
		super.init()
		self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/pertrips"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
		self.appName_ = "bikeca"
		self.mapping_ = "/bikeca/business/pertrips"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        tempLockPwd = visitableSource.getValue("tempLockPwd")
    
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaPerTripRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
    }

    open func addBikecaPerTripRecord(subBody:BikecaPerTripRecord) -> Void{
        data.append(subBody)
    }

    open func getBikecaPerTripRecord() -> [BikecaPerTripRecord]{
        return data
    }
	        
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }
	
	open func isRequestBody() -> Bool{
    	return false;
    }
}
open class BikecaPerTripRecord : BaseITWebAPIBody {
    
    //
    open var bikeId:String?
    open var hireStatus:String?
    open var hireTime:String?
    open var restoreTime:String?
    open var hireStationId:String?
    open var hireStationName:String?
    open var hireParkNum:String?
    open var hireCoord:String?
    open var restoreStationId:String?
    open var restoreStationName:String?
    open var restoreParkNum:String?
    open var restoreCoord:String?
    open var money:String?
    open var orderId:String?
    open var orderStatus:String?
    open var cityCode:String?
    open var hLockType:String?
    open var rLockType:String?
    open var id:String?
    open var reletId:String?
    open var releteTime:String?
    open var surplusSecond:String?
    open var releteEndTime:String?
    open var befDiscountMoney:String?
    open var dispatchFee:String?
    open var cardPreFee:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/pertrips"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/pertrips"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        bikeId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bikeId"))
        hireStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireStatus"))
        hireTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireTime"))
        restoreTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restoreTime"))
        hireStationId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireStationId"))
        hireStationName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireStationName"))
        hireParkNum = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireParkNum"))
        hireCoord = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("hireCoord"))
        restoreStationId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restoreStationId"))
        restoreStationName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restoreStationName"))
        restoreParkNum = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restoreParkNum"))
        restoreCoord = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("restoreCoord"))
        money = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("money"))
        orderId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderId"))
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
        cityCode = visitableSource.getValue("cityCode")
        hLockType = visitableSource.getValue("hLockType")
        rLockType = visitableSource.getValue("rLockType")
        id = visitableSource.getValue("id")
        reletId = visitableSource.getValue("reletId")
        releteTime = visitableSource.getValue("releteTime")
        surplusSecond = visitableSource.getValue("surplusSecond")
        releteEndTime = visitableSource.getValue("releteEndTime")
        befDiscountMoney = visitableSource.getValue("befDiscountMoney")
        dispatchFee = visitableSource.getValue("dispatchFee")
        cardPreFee = visitableSource.getValue("cardPreFee")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostCheckOrderStatus : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var orderId:String?
    open var coupUsedId:String?
    open var coupId:String?
    open var finalPayMoney:String?
    open var coupType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkOrderStatus"
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
        let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
        let coupUsedId_ = self.coupUsedId;
        let coupId_ = self.coupId;
        let finalPayMoney_ = self.finalPayMoney;
        let coupType_ = self.coupType;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&orderId=" + (orderId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostCheckOrderStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:9,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:9,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:9,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"coupUsedId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:9,value:coupUsedId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"coupUsedId",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"coupId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:9,value:coupId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"coupId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"finalPayMoney",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:9,value:finalPayMoney_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"finalPayMoney",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"coupType",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:9,value:coupType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"coupType",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:9,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:9,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:9,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostCheckOrderStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetCheckOrderStatus : BaseITWebAPIBody {
    
    open var orderStatus:String?
    open var bizStatus:String?
    open var openTime:String?
    open var bizMoney:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkOrderStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
        bizStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bizStatus"))
        openTime = visitableSource.getValue("openTime")
        bizMoney = visitableSource.getValue("bizMoney")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostGetDeviceStatus : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var deviceId:String?
    open var type:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getdevicestatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getdevicestatus"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetDeviceStatus",body:self))
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
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetDeviceStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetGetDeviceStatus : BaseITWebAPIBody {
    
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
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getdevicestatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getdevicestatus"
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

open class BikecaPostReletPriceList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var bikeType:String?
    open var userId:String?
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
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
        let bikeType_ = secureKeys?["AES"]?.encrypt(original: self.bikeType) ?? ""
        let userId_ = self.userId
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&bikeType=" + (bikeType_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostReletPriceList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"bikeType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:bikeType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"bikeType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"userId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:userId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"userId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:4,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostReletPriceList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetReletPriceList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->one-to-manay
    open var data = [BikecaReletPriceRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaReletPriceRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBikecaReletPriceRecord(subBody:BikecaReletPriceRecord) -> Void{
        data.append(subBody)
    }
    
    open func getBikecaReletPriceRecord() -> [BikecaReletPriceRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostInsertReletRecord : BaseITWebAPIBody {
    
    //
    open var tripId:String?
    open var reletPrice:String?
    open var reletHour:String?
    open var bikeType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/insertReletRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/insertReletRecord"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let tripId_ = secureKeys?["AES"]?.encrypt(original: self.tripId) ?? ""
        let reletPrice_ = secureKeys?["AES"]?.encrypt(original: self.reletPrice) ?? ""
        let reletHour_ = secureKeys?["AES"]?.encrypt(original: self.reletHour) ?? ""
        let bikeType_ = secureKeys?["AES"]?.encrypt(original: self.bikeType) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&tripId=" + (tripId_ ?? ""))
        md5.append("&reletPrice=" + (reletPrice_ ?? ""))
        md5.append("&reletHour=" + (reletHour_ ?? ""))
        md5.append("&bikeType=" + (bikeType_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostInsertReletRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"tripId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:tripId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"tripId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"reletPrice",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:reletPrice_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"reletPrice",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"reletHour",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:reletHour_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"reletHour",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"bikeType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:bikeType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"bikeType",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostInsertReletRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetInsertReletRecord : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/insertReletRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/insertReletRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaReletPriceRecord : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var reletHour:String?
    open var reletPrice:String?
    open var display:String?
    open var bikeType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/reletPriceList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        reletHour = visitableSource.getValue("reletHour")
        reletPrice = visitableSource.getValue("reletPrice")
        display = visitableSource.getValue("display")
        bikeType = visitableSource.getValue("bikeType")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostCheckCertifyStatus : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var channelType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCertifyStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCertifyStatus"
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
        let channelType_ = secureKeys?["AES"]?.encrypt(original: self.channelType) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&channelType=" + (channelType_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostCheckCertifyStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"channelType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:channelType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"channelType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostCheckCertifyStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetCheckCertifyStatus : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCertifyStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCertifyStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("reqStatus"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostGetPriceList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
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
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetPriceList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetPriceList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetGetPriceList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->one-to-manay
    open var data = [BikecaPriceRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaPriceRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBikecaPriceRecord(subBody:BikecaPriceRecord) -> Void{
        data.append(subBody)
    }
    
    open func getBikecaPriceRecord() -> [BikecaPriceRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPriceRecord : BaseITWebAPIBody {
    
    //
    open var hireTimes:String?
    open var price:String?
    open var bikeType:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/getPriceList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        hireTimes = visitableSource.getValue("hireTimes")
        price = visitableSource.getValue("price")
        bikeType = visitableSource.getValue("bikeType")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostTripOverView : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/tripOverView"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/tripOverView"
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
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostTripOverView",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:4,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostTripOverView",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetTripOverView : BaseITWebAPIBody {
    
    //
    open var tripTotalNum:String?
    open var rideRange:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/tripOverView"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/tripOverView"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        tripTotalNum = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("tripTotalNum"))
        rideRange = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("rideRange"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    

    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BikecaPostQueryProgress : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/queryProgress"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/queryProgress"
    }
    
    //-------> one-to-many
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostQueryProgress",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostQueryProgress",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetQueryProgress : BaseITWebAPIBody {
    
    //
    open var refundStatusAndTime:String?
    open var refundStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/queryProgress"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/queryProgress"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        refundStatusAndTime = visitableSource.getValue("refundStatusAndTime")
        refundStatus = visitableSource.getValue("refundStatus")
        retmsg = visitableSource.getValue("retmsg")
        retcode = visitableSource.getValue("retcode")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostRevokeRefund : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/revokeRefund"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/revokeRefund"
    }
    
    //-------> one-to-many
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostRevokeRefund",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostRevokeRefund",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetRevokeRefund : BaseITWebAPIBody {
    
    //
    open var bizMoney:String?
    open var cancelTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/revokeRefund"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/revokeRefund"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }

        bizMoney = visitableSource.getValue("bizMoney")

        cancelTime = visitableSource.getValue("cancelTime")
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostUserBuyCard : BaseITWebAPIBody {
    
    //
    open var cardId:String?
    open var appId:String?
    open var serviceId:String?
    open var walletConfigId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/userBuyCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/userBuyCard"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let cardId_ = self.cardId;
        let appId_ = self.appId;
        let serviceId_ = self.serviceId;
        let walletConfigId_ = self.walletConfigId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostUserBuyCard",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"cardId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:cardId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"cardId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"walletConfigId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:walletConfigId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"walletConfigId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostUserBuyCard",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetUserBuyCard : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var orderId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/userBuyCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/userBuyCard"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        orderId = visitableSource.getValue("orderId")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostGetCardDetailList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var grade:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let serviceId_ = self.serviceId;
        let grade_ = self.grade;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetCardDetailList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"grade",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:grade_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"grade",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetCardDetailList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetGetCardDetailList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [BikecaGetCardDetailList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaGetCardDetailList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BikecaGetCardDetailList) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BikecaGetCardDetailList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaGetCardDetailList : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var bikeType:String?
    open var grade:String?
    open var cardType:String?
    open var cardName:String?
    open var cardDetailType:String?
    open var cardTimes:String?
    open var cardHour:String?
    open var cardRentPrice:String?
    open var cardDiscount:String?
    open var display:String?
    open var remark:String?
    open var limitedTimeOffer:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/getCardDetailList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        bikeType = visitableSource.getValue("bikeType")
        grade = visitableSource.getValue("grade")
        cardType = visitableSource.getValue("cardType")
        cardName = visitableSource.getValue("cardName")
        cardDetailType = visitableSource.getValue("cardDetailType")
        cardTimes = visitableSource.getValue("cardTimes")
        cardHour = visitableSource.getValue("cardHour")
        cardRentPrice = visitableSource.getValue("cardRentPrice")
        cardDiscount = visitableSource.getValue("cardDiscount")
        display = visitableSource.getValue("display")
        remark = visitableSource.getValue("remark")
        limitedTimeOffer = visitableSource.getValue("limitedTimeOffer")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostQueryCardDaysRemainingd : BaseITWebAPIBody {
    
    //
    open var grade:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryCardDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryCardDaysRemaining"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let grade_ = self.grade;
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostQueryCardDaysRemainingd",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"grade",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:grade_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"grade",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostQueryCardDaysRemainingd",body:self))
        return result.joined(separator:"")
    }
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetQueryCardDaysRemaining : BaseITWebAPIBody {
    
    //
    open var userCardStatus:String?
    open var daysRemaining:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardDaysRemaining"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        userCardStatus = visitableSource.getValue("userCardStatus")
        daysRemaining = visitableSource.getValue("daysRemaining")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BikecaPostQueryCardAndDaysRemainingd : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
    }
    
    //-------> one-to-many
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostQueryCardAndDaysRemainingd",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostQueryCardAndDaysRemainingd",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetQueryCardAndDaysRemaining : BaseITWebAPIBody {
    
    //
    open var daysRemaining:String?
    //----->one-to-manay
    fileprivate var data = [BikecaGetAPPCardDetailList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        daysRemaining = visitableSource.getValue("daysRemaining")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaGetAPPCardDetailList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBikecaGetAPPCardDetailList(subBody:BikecaGetAPPCardDetailList) -> Void{
        data.append(subBody)
    }
    
    open func getBikecaGetAPPCardDetailList() -> [BikecaGetAPPCardDetailList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaGetAPPCardDetailList : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var bikeType:String?
    open var cardType:String?
    open var cardName:String?
    open var cardDetailType:String?
    open var cardTimes:String?
    open var cardHour:String?
    open var cardRentPrice:String?
    open var cardDiscount:String?
    open var display:String?
    open var remark:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/queryCardAndDaysRemaining"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        bikeType = visitableSource.getValue("bikeType")
        cardType = visitableSource.getValue("cardType")
        cardName = visitableSource.getValue("cardName")
        cardDetailType = visitableSource.getValue("cardDetailType")
        cardTimes = visitableSource.getValue("cardTimes")
        cardHour = visitableSource.getValue("cardHour")
        cardRentPrice = visitableSource.getValue("cardRentPrice")
        cardDiscount = visitableSource.getValue("cardDiscount")
        display = visitableSource.getValue("display")
        remark = visitableSource.getValue("remark")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostCheckBuyOrderStatus : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var type:String?
    open var orderId:String?
    open var cardId:String?
    open var walletConfigId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkBuyOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkBuyOrderStatus"
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
        let type_ = secureKeys?["AES"]?.encrypt(original: self.type) ?? ""
        let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
        let cardId_ = secureKeys?["AES"]?.encrypt(original: self.cardId) ?? ""
        let walletConfigId_ = self.walletConfigId;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&type=" + (type_ ?? ""))
        md5.append("&orderId=" + (orderId_ ?? ""))
        md5.append("&cardId=" + (cardId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostCheckBuyOrderStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:8,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:8,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:8,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:8,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:8,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"cardId",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:8,value:cardId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"cardId",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"walletConfigId",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:8,value:walletConfigId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"walletConfigId",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:8,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:8,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:8,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostCheckBuyOrderStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetCheckBuyOrderStatus : BaseITWebAPIBody {
    
    //
    open var orderStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkBuyOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkBuyOrderStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostGetUserBuyCardList : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let beginindex_ = self.beginindex;
        let retcount_ = self.retcount;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetUserBuyCardList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetUserBuyCardList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetGetUserBuyCardList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->one-to-manay
    open var data = [BikecaGetUserBuyCardList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BikecaGetUserBuyCardList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBikecaGetUserBuyCardList(subBody:BikecaGetUserBuyCardList) -> Void{
        data.append(subBody)
    }
    
    open func getBikecaGetUserBuyCardList() -> [BikecaGetUserBuyCardList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaGetUserBuyCardList : BaseITWebAPIBody {
    
    //
    open var buyDays:String?
    open var cardName:String?
    open var Price:String?
    open var createTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/card/getUserBuyCardList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        buyDays = visitableSource.getValue("buyDays")
        cardName = visitableSource.getValue("cardName")
        Price = visitableSource.getValue("Price")
        createTime = visitableSource.getValue("createTime")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostGetInvitationInfo : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/getInvitationInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/getInvitationInfo"
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
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetInvitationInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:2,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetInvitationInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetGetInvitationInfo : BaseITWebAPIBody {
    
    //
    open var inviteStatus:String?
    open var inviteCode:String?
    open var oppositePhone:String?
    open var exprRemain:String?
    open var exprBeginTime:String?
    open var exprEndTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/getInvitationInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/getInvitationInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        inviteStatus = visitableSource.getValue("inviteStatus")
        inviteCode = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("inviteCode"))
        oppositePhone = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("oppositePhone"))
        exprRemain = visitableSource.getValue("exprRemain")
        exprBeginTime = visitableSource.getValue("exprBeginTime")
        exprEndTime = visitableSource.getValue("exprEndTime")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostInviteExpr : BaseITWebAPIBody {
    
    //
    open var inviteType:String?
    open var vCode:String?
    open var oppositePhone:String?
    open var inviteCode:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/extra/inviteExpr"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/extra/inviteExpr"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let inviteType_ = self.inviteType;
        let vCode_ = self.vCode;
        let oppositePhone_ = secureKeys?["AES"]?.encrypt(original: self.oppositePhone) ?? ""
        let inviteCode_ = secureKeys?["AES"]?.encrypt(original: self.inviteCode) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostInviteExpr",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"inviteType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:inviteType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"inviteType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"vCode",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:vCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"vCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"oppositePhone",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:oppositePhone_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"oppositePhone",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"inviteCode",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:inviteCode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"inviteCode",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostInviteExpr",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetInviteExpr : BaseITWebAPIBody {
    
    //
    open var bizStatus:String?
    open var inviteStatus:String?
    open var inviteCode:String?
    open var oppositePhone:String?
    open var exprRemain:String?
    open var exprBeginTime:String?
    open var exprEndTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/extra/inviteExpr"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/extra/inviteExpr"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bizStatus"))
        inviteStatus = visitableSource.getValue("inviteStatus")
        inviteCode = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("inviteCode"))
        oppositePhone = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("oppositePhone"))
        exprRemain = visitableSource.getValue("exprRemain")
        exprBeginTime = visitableSource.getValue("exprBeginTime")
        exprEndTime = visitableSource.getValue("exprEndTime")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostGetCommonConfigList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetCommonConfigList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetCommonConfigList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetGetCommonConfigList : BaseITWebAPIBody {
    
    open var datacount:String?
    open var data = [BikecaGetCommonConfig]()
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append(BikecaGetCommonConfig (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BikecaGetCommonConfig) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BikecaGetCommonConfig]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }

}

open class BikecaGetCommonConfig : BaseITWebAPIBody {
    
    //
    open var name:String?
    open var value:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/config/getCommonConfigList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        name = visitableSource.getValue("name")
        value = visitableSource.getValue("value")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostCheckCloudPosOrderStatus: BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var appId:String?
    open var type:String?
    open var orderId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCloudPosOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCloudPosOrderStatus"
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
        let type_ = secureKeys?["AES"]?.encrypt(original: self.type) ?? ""
        let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&serviceId=" + (serviceId_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&type=" + (type_ ?? ""))
        md5.append("&orderId=" + (orderId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostCheckCloudPosOrderStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostCheckCloudPosOrderStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetCheckCloudPosOrderStatus : BaseITWebAPIBody {
    
    //
    open var orderStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCloudPosOrderStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/bikeca/business/checkCloudPosOrderStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostUseWalletForBusiness : BaseITWebAPIBody {
    
    //
    open var orderId:String?
    open var usedChannel:String?
    open var serviceId:String?
    open var coupUsedId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/useWalletForBusiness"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/useWalletForBusiness"
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
        let coupUsedId_ = self.coupUsedId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostUseWalletForBusiness",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"usedChannel",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:usedChannel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"usedChannel",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"coupUsedId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:coupUsedId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"coupUsedId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostUseWalletForBusiness",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetUseWalletForBusiness : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/useWalletForBusiness"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/useWalletForBusiness"
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
open class BikecaPostOpenBizAgree : BaseITWebAPIBody {
    
    //
    open var bizType:String?
    open var version:String?
    open var terminalType:String?
    open var pamrams:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/openBizAgree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/openBizAgree"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let bizType_ = self.bizType;
        let version_ = self.version;
        let terminalType_ = self.terminalType;
        let pamrams_ = self.pamrams;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostOpenBizAgree",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"bizType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:bizType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"bizType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"version",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:version_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"version",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"terminalType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"pamrams",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:pamrams_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"pamrams",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostOpenBizAgree",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BikecaRetOpenBizAgree : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/openBizAgree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/openBizAgree"
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


open class BikecaPostGetBizAgree : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getBizAgree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getBizAgree"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetBizAgree",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetBizAgree",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetGetBizAgree : BaseITWebAPIBody {
    
    //
    open var agreeExtra:String?
    open var baseExtra:String?
    open var rentFlag:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getBizAgree"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getBizAgree"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        agreeExtra = visitableSource.getValue("agreeExtra")
        baseExtra = visitableSource.getValue("baseExtra")
        rentFlag = visitableSource.getValue("rentFlag")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostIntimateBind : BaseITWebAPIBody {
    
    //
    open var reqType:String?
    open var intimatePhone:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/intimateBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/intimateBind"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let reqType_ = self.reqType;
        let intimatePhone_ = self.intimatePhone;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostIntimateBind",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"reqType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:reqType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"reqType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"intimatePhone",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:intimatePhone_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"intimatePhone",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostIntimateBind",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetIntimateBind : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var oldIntimatePhone:String?
    open var newIntimatePhone:String?
    open var intimateBindStatus:String?
    open var exprBeginTime:String?
    open var exprEndTime:String?
    open var exprRemain:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/intimateBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/extra/intimateBind"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        oldIntimatePhone = visitableSource.getValue("oldIntimatePhone")
        newIntimatePhone = visitableSource.getValue("newIntimatePhone")
        intimateBindStatus = visitableSource.getValue("intimateBindStatus")
        exprBeginTime = visitableSource.getValue("exprBeginTime")
        exprEndTime = visitableSource.getValue("exprEndTime")
        exprRemain = visitableSource.getValue("exprRemain")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BikecaPostGetTripInfo : BaseITWebAPIBody {
    
    //
    open var tripId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getTripInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getTripInfo"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostGetTripInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"tripId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:tripId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"tripId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostGetTripInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetGetTripInfo : BaseITWebAPIBody {
    
    //
    open var requestTime:String?
    open var bikeId:String?
    open var hireStatus:String?
    open var hireTime:String?
    open var restoreTime:String?
    open var hireStationId:String?
    open var hireStationName:String?
    open var hireParkNum:String?
    open var hireCoord:String?
    open var restoreStationId:String?
    open var restoreStationName:String?
    open var restoreParkNum:String?
    open var restoreCoord:String?
    open var money:String?
    open var orderId:String?
    open var orderStatus:String?
    open var cityCode:String?
    open var hLockType:String?
    open var rLockType:String?
    open var id:String?
    open var reletId:String?
    open var releteTime:String?
    open var surplusSecond:String?
    open var releteEndTime:String?
    open var befDiscountMoney:String?
    open var dispatchFee:String?
    open var cardPreFee:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getTripInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/getTripInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        requestTime = visitableSource.getValue("requestTime")
        bikeId = visitableSource.getValue("bikeId")
        hireStatus = visitableSource.getValue("hireStatus")
        hireTime = visitableSource.getValue("hireTime")
        restoreTime = visitableSource.getValue("restoreTime")
        hireStationId = visitableSource.getValue("hireStationId")
        hireStationName = visitableSource.getValue("hireStationName")
        hireParkNum = visitableSource.getValue("hireParkNum")
        hireCoord = visitableSource.getValue("hireCoord")
        restoreStationId = visitableSource.getValue("restoreStationId")
        restoreStationName = visitableSource.getValue("restoreStationName")
        restoreParkNum = visitableSource.getValue("restoreParkNum")
        restoreCoord = visitableSource.getValue("restoreCoord")
        money = visitableSource.getValue("money")
        orderId = visitableSource.getValue("orderId")
        orderStatus = visitableSource.getValue("orderStatus")
        cityCode = visitableSource.getValue("cityCode")
        hLockType = visitableSource.getValue("hLockType")
        rLockType = visitableSource.getValue("rLockType")
        id = visitableSource.getValue("id")
        reletId = visitableSource.getValue("reletId")
        releteTime = visitableSource.getValue("releteTime")
        surplusSecond = visitableSource.getValue("surplusSecond")
        releteEndTime = visitableSource.getValue("releteEndTime")
        befDiscountMoney = visitableSource.getValue("befDiscountMoney")
        dispatchFee = visitableSource.getValue("dispatchFee")
        cardPreFee = visitableSource.getValue("cardPreFee")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostCheckYearCardOrder : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    open var orderId:String?
    open var yearCardId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/purchase/checkYearCardOrder"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/purchase/checkYearCardOrder"
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
        let orderId_ = secureKeys?["AES"]?.encrypt(original: self.orderId) ?? ""
        let yearCardId_ = secureKeys?["AES"]?.encrypt(original: self.yearCardId) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("orderId=" + (orderId_ ?? ""))
        md5.append("&yearCardId=" + (yearCardId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostCheckYearCardOrder",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"orderId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:orderId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"orderId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"yearCardId",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:yearCardId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"yearCardId",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:6,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:6,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostCheckYearCardOrder",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetCheckYearCardOrder : BaseITWebAPIBody {
    
    //
    open var orderStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/purchase/checkYearCardOrder"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/purchase/checkYearCardOrder"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        orderStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderStatus"))
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostQueryUserCard : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryUserCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryUserCard"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostQueryUserCard",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostQueryUserCard",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BikecaRetQueryUserCard : BaseITWebAPIBody {
    
    //
    open var userCardStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryUserCard"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/card/queryUserCard"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        userCardStatus = visitableSource.getValue("userCardStatus")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BikecaPostRealNameFreeBet : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/realNameFreeBet"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/realNameFreeBet"
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
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BikecaPostRealNameFreeBet",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BikecaPostRealNameFreeBet",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BikecaRetRealNameFreeBet : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/realNameFreeBet"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "37"
        self.appName_ = "bikeca"
        self.mapping_ = "/api/bikeca/business/realNameFreeBet"
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
