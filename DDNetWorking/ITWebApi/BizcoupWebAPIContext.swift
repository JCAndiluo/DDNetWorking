import Foundation


open class BizcoupWebAPIContext : ITWebAPIContext{
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
        case "/coupon/business/getcouponlist":
            if type == .requestBody {
                body = BizcoupPostCouponList()
            } else {
                body = BizcoupRetCouponList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/coupon/business/receivecoupon":
            if type == .requestBody {
                body = BizcoupPostReceiveCoupon()
            } else {
                body = BizcoupRetReceiveCoupon(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/coupon/business/payMoney":
            if type == .requestBody {
                body = BizcoupPostCoupPayMoney()
            } else {
                body = BizcoupRetCoupPayMoney(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/coupon/business/percouponlist":
            if type == .requestBody {
                body = BizcoupPostPerCouponList()
            } else {
                body = BizcoupRetPerCouponList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/coupon/business/updateCoupStatus":
            if type == .requestBody {
                body = BizcoupPostUpdateCoupStatus()
            } else {
                body = BizcoupRetUpdateCoupStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/coupon/activity/userOtherChance":
            if type == .requestBody {
                body = BizcoupPostUserOtherChance()
            } else {
                body = BizcoupRetUserOtherChance(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/wallet/queryUserWallet":
            if type == .requestBody {
                body = BizcoupPostQueryUserWallet()
            } else {
                body = BizcoupRetQueryUserWallet(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/wallet/queryWalletConfigList":
            if type == .requestBody {
                body = BizcoupPostQueryWalletConfigList()
            } else {
                body = BizcoupRetQueryWalletConfigList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/wallet/getWalletBuyRecord":
            if type == .requestBody {
                body = BizcoupPostGetWalletBuyRecord()
            } else {
                body = BizcoupRetGetWalletBuyRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/wallet/userWalletConsumeRecord":
            if type == .requestBody {
                body = BizcoupPostUserWalletConsumeRecord()
            } else {
                body = BizcoupRetUserWalletConsumeRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/business/hzActivity":
            if type == .requestBody {
                body = BizcoupPostHzActivity()
            } else {
                body = BizcoupRetHzActivity(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/sign/getSignListAndStatus":
            if type == .requestBody {
                body = BizcoupPostSignListAndStatus()
            } else {
                body = BizcoupRetSignListAndStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/sign/signForDD":
            if type == .requestBody {
                body = BizcoupPostSignForDD()
            } else {
                body = BizcoupRetSignForDD(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/userRedpac":
            if type == .requestBody {
                body = BizcoupPostUserRedpac()
            } else {
                body = BizcoupRetUserRedpac(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/getRedpacObtainRecord":
            if type == .requestBody {
                body = BizcoupPostGetRedpacObtainRecord()
            } else {
                body = BizcoupRetGetRedpacObtainRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/useRedpacRecord":
            if type == .requestBody {
                body = BizcoupPostUseRedpacRecord()
            } else {
                body = BizcoupRetUseRedpacRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/shiftToBanlance":
            if type == .requestBody {
                body = BizcoupPostShiftToBanlance()
            } else {
                body = BizcoupRetShiftToBanlance(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/redpacWithdraw":
            if type == .requestBody {
                body = BizcoupPostRedpacWithdraw()
            } else {
                body = BizcoupRetRedpacWithdraw(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/redpac/receiveRedpac":
            if type == .requestBody {
                body = BizcoupPostReceiveRedpac()
            } else {
                body = BizcoupRetReceiveRedpac(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/points/getMemberLevel":
            if type == .requestBody {
                body = BizcoupPostMemberLevel()
            } else {
                body = BizcoupRetMemberLevel(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/points/getMemberPoints":
            if type == .requestBody {
                body = BizcoupPostMemberPoints()
            } else {
                body = BizcoupRetMemberPoints(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/points/getMemberPointsRecord":
            if type == .requestBody {
                body = BizcoupPostMemberPointsRecord()
            } else {
                body = BizcoupRetMemberPointsRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/business/queryYearCardDaysRemaining":
            if type == .requestBody {
                body = BizcoupPostQueryYearCardDaysRemaining()
            } else {
                body = BizcoupRetQueryYearCardDaysRemaining(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/purchase/getUserBuyYearCardList":
            if type == .requestBody {
                body = BizcoupPostGetUserBuyYearCardList()
            } else {
                body = BizcoupRetGetUserBuyYearCardList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/purchase/getYearCardDetailList":
            if type == .requestBody {
                body = BizcoupPostGetYearCardDetailList()
            } else {
                body = BizcoupRetGetYearCardDetailList(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/purchase/queryUserYearCardStatus":
            if type == .requestBody {
                body = BizcoupPostUserYearCardStatus()
            } else {
                body = BizcoupRetUserYearCardStatus(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/points/yueshi/getURL":
            if type == .requestBody {
                body = BizcoupPostYueshiGetURLRecord()
            } else {
                body = BizcoupRetYueShiGetURLRecord(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/coupon/wallet/exchangeCoupon":
            if type == .requestBody {
                body = BizcoupPostExchangeCoupon()
            } else {
                body = BizcoupRetExchangeCoupon(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        default:
            body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

open class BizcoupPostCouponList : BaseITWebAPIBody {
    
    //
    open var couponType:String?
    open var usedCity:String?
    open var devType:String?
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/getcouponlist"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/getcouponlist"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let couponType_ = self.couponType;
        let usedCity_ = self.usedCity;
        let devType_ = self.devType;
        let beginindex_ = self.beginindex;
        let retcount_ = self.retcount;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostCouponList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"couponType",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:couponType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"couponType",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"usedCity",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:usedCity_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"usedCity",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"devType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:devType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"devType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostCouponList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetCouponList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->one-to-manay
    fileprivate var data = [BizcoupCouponRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/getcouponlist"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/getcouponlist"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupCouponRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBizcoupCouponRecord(subBody:BizcoupCouponRecord) -> Void{
        data.append(subBody)
    }
    
    open func getBizcoupCouponRecord() -> [BizcoupCouponRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
    open class BizcoupCouponRecord : BaseITWebAPIBody {
        
        //
        open var title:String?
        open var couponType:String?
        open var vaildStatTime:String?
        open var vaildEndTime:String?
        open var usedCity:String?
        open var devType:String?
        open var remarks:String?
        open var imagePath:String?
        open var money:String?
        open var discount:String?
        open var quantity:String?
        open var status:String?
        
        required public init(){
            super.init()
            self.appId_ = "40"
            self.appName_ = "bizcoup"
            self.mapping_ = "/coupon/business/getcouponlist"
        }
        
        required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
            self.init()
            self.appId_ = "40"
            self.appName_ = "bizcoup"
            self.mapping_ = "/coupon/business/getcouponlist"
            //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
            }
            title = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("title"))
            couponType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("couponType"))
            vaildStatTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("vaildStatTime"))
            vaildEndTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("vaildEndTime"))
            usedCity = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("usedCity"))
            devType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("devType"))
            remarks = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("remarks"))
            imagePath = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("imagePath"))
            money = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("money"))
            discount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("discount"))
            quantity = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("quantity"))
            status = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("status"))
        }
        
        //-------> one-to-many
        
        override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
        
        
        open func isRequestBody() -> Bool{
            return false;
        }
    }
}


open class BizcoupPostReceiveCoupon : BaseITWebAPIBody {
    
    //
    open var couponId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/receivecoupon"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/receivecoupon"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let couponId_ = self.couponId;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostReceiveCoupon",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"couponId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:couponId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"couponId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostReceiveCoupon",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetReceiveCoupon : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/receivecoupon"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/receivecoupon"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BizcoupPostCoupPayMoney : BaseITWebAPIBody {
    
    //
    open var couponId:String?
    open var money:String?
    open var hireDate:String?
    open var restoreDate:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/payMoney"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/payMoney"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let couponId_ = self.couponId;
        let money_ = self.money;
        let hireDate_ = self.hireDate;
        let restoreDate_ = self.restoreDate;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostCoupPayMoney",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"couponId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:couponId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"couponId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"money",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:money_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"money",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"hireDate",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:hireDate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"hireDate",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"restoreDate",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:restoreDate_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"restoreDate",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostCoupPayMoney",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetCoupPayMoney : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var adjustMoney:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/payMoney"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/payMoney"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        adjustMoney = visitableSource.getValue("adjustMoney")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BizcoupPostPerCouponList : BaseITWebAPIBody {
    
    //
    open var couponClass:String?
    open var couponType:String?
    open var cycleType:String?
    open var orderType:String?
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let couponType_ = self.couponType;
        let cycleType_ = self.cycleType;
        let orderType_ = self.orderType;
        let beginindex_ = self.beginindex;
        let retcount_ = self.retcount;
        let couponClass_ = self.couponClass
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostPerCouponList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"couponClass",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:8,value:couponClass_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"couponClass",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"couponType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:couponType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"couponType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"cycleType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:cycleType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"cycleType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"orderType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:orderType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"orderType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostPerCouponList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetPerCouponList : BaseITWebAPIBody {
    
    open var datacount:String?
    open var data = [BizcoupPerCouponRecord]()
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupPerCouponRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBizcoupPerCouponRecord(subBody:BizcoupPerCouponRecord) -> Void{
        data.append(subBody)
    }
    
    open func getBizcoupPerCouponRecord() -> [BizcoupPerCouponRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
    
}

open class BizcoupPerCouponRecord : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var title:String?
    open var couponType:String?
    open var vaildStatTime:String?
    open var vaildEndTime:String?
    open var scope:String?
    open var devType:String?
    open var intro:String?
    open var imagePath:String?
    open var money:String?
    open var discount:String?
    open var useStatus:String?
    open var couponStatus:String?
    open var orderId:String?
    open var coupClass:String?
    open var qrCode:String?
    open var sellerUsedRules:String?
    open var sellerName:String?
    open var sellerAddress:String?
    open var sellerImg:String?
    open var sellerPhone:String?
    open var wechatAccounts:String?
    open var businessStartHours:String?
    open var businessEndHours:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/percouponlist"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("id"))
        title = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("title"))
        couponType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("couponType"))
        vaildStatTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("vaildStatTime"))
        vaildEndTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("vaildEndTime"))
        scope = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("scope"))
        devType = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("devType"))
        intro = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("intro"))
        imagePath = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("imagePath"))
        money = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("money"))
        discount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("discount"))
        useStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("useStatus"))
        couponStatus = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("couponStatus"))
        orderId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("orderId"))
        coupClass = visitableSource.getValue("coupClass")
        qrCode = visitableSource.getValue("qrCode")
        sellerUsedRules = visitableSource.getValue("sellerUsedRules")
        sellerName = visitableSource.getValue("sellerName")
        sellerAddress = visitableSource.getValue("sellerAddress")
        sellerImg = visitableSource.getValue("sellerImg")
        sellerPhone = visitableSource.getValue("sellerPhone")
        wechatAccounts = visitableSource.getValue("wechatAccounts")
        businessStartHours = visitableSource.getValue("businessStartHXours")
        businessEndHours = visitableSource.getValue("businessEndHours")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostUpdateCoupStatus : BaseITWebAPIBody {
    
    //
    open var id:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/updateCoupStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/updateCoupStatus"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let id_ = self.id;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUpdateCoupStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"id",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:id_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"id",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUpdateCoupStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetUpdateCoupStatus : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/updateCoupStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/business/updateCoupStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupPostUserOtherChance : BaseITWebAPIBody {
    
    //
    open var channl:String?
    open var activityType:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/activity/userOtherChance"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/activity/userOtherChance"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let channl_ = self.channl;
        let activityType_ = self.activityType;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUserOtherChance",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"channl",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:channl_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"channl",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"activityType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:activityType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"activityType",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUserOtherChance",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BizcoupRetUserOtherChance : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/activity/userOtherChance"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/coupon/activity/userOtherChance"
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

open class BizcoupPostQueryUserWallet : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryUserWallet"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryUserWallet"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostQueryUserWallet",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostQueryUserWallet",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetQueryUserWallet : BaseITWebAPIBody {
    
    //
    open var money:String?
    open var giveMoney:String?
    open var lockStatus:String?
    open var flag:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryUserWallet"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryUserWallet"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        money = visitableSource.getValue("money")
        giveMoney = visitableSource.getValue("giveMoney")
        lockStatus = visitableSource.getValue("lockStatus")
        flag = visitableSource.getValue("flag")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostQueryWalletConfigList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostQueryWalletConfigList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostQueryWalletConfigList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetQueryWalletConfigList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizcoupGetWalletConfigList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupGetWalletConfigList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupGetWalletConfigList) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupGetWalletConfigList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupGetWalletConfigList : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var money:String?
    open var giveMoney:String?
    open var order:String?
    open var recommend:String?
    open var remark:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/queryWalletConfigList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        money = visitableSource.getValue("money")
        giveMoney = visitableSource.getValue("giveMoney")
        order = visitableSource.getValue("order")
        recommend = visitableSource.getValue("recommend")
        remark = visitableSource.getValue("remark")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostGetWalletBuyRecord : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
    }
    
    //-------> list
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostGetWalletBuyRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostGetWalletBuyRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetGetWalletBuyRecord : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizcoupGetWalletBuyRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupGetWalletBuyRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupGetWalletBuyRecord) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupGetWalletBuyRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupGetWalletBuyRecord : BaseITWebAPIBody {
    
    //
    open var money:String?
    open var giveMoney:String?
    open var walletConfigName:String?
    open var createTime:String?
    open var rechargeChannel:String?
    open var buyChannel:String?
    open var flag:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/getWalletBuyRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        money = visitableSource.getValue("money")
        giveMoney = visitableSource.getValue("giveMoney")
        walletConfigName = visitableSource.getValue("walletConfigName")
        createTime = visitableSource.getValue("createTime")
        rechargeChannel = visitableSource.getValue("rechargeChannel")
        buyChannel = visitableSource.getValue("buyChannel")
        flag = visitableSource.getValue("flag")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostUserWalletConsumeRecord : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
    }
    
    //-------> list
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUserWalletConsumeRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUserWalletConsumeRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetUserWalletConsumeRecord : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizcoupUserWalletConsumeRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupUserWalletConsumeRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupUserWalletConsumeRecord) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupUserWalletConsumeRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }

}


open class BizcoupUserWalletConsumeRecord : BaseITWebAPIBody {
    
    //
    open var bikeType:String?
    open var usedTime:String?
    open var totalUsedMoney:String?
    open var usedChannel:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/userWalletConsumeRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        bikeType = visitableSource.getValue("bikeType")
        usedTime = visitableSource.getValue("usedTime")
        totalUsedMoney = visitableSource.getValue("totalUsedMoney")
        usedChannel = visitableSource.getValue("usedChannel")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupPostHzActivity : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/hzActivity"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/hzActivity"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostHzActivity",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostHzActivity",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BizcoupRetHzActivity : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/hzActivity"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/hzActivity"
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
open class BizcoupPostSignListAndStatus : BaseITWebAPIBody {
    
    //
    open var signId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/getSignListAndStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/getSignListAndStatus"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let signId_ = self.signId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostSignListAndStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"signId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:signId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"signId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostSignListAndStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BizcoupRetSignListAndStatus : BaseITWebAPIBody {
    
    //
    open var signFlag:String?
    open var signArray:String?
    open var coinNum:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/getSignListAndStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/getSignListAndStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        signFlag = visitableSource.getValue("signFlag")
        signArray = visitableSource.getValue("signArray")
        coinNum = visitableSource.getValue("coinNum")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupPostSignForDD : BaseITWebAPIBody {
    
    //
    open var signId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/signForDD"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/signForDD"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let signId_ = self.signId;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostSignForDD",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"signId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:signId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"signId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostSignForDD",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
open class BizcoupRetSignForDD : BaseITWebAPIBody {
    
    //
    open var signFlag:String?
    open var signArray:String?
    open var coinNum:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/signForDD"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/sign/signForDD"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        signFlag = visitableSource.getValue("signFlag")
        signArray = visitableSource.getValue("signArray")
        coinNum = visitableSource.getValue("coinNum")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostUserRedpac : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/userRedpac"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/userRedpac"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUserRedpac",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUserRedpac",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetUserRedpac : BaseITWebAPIBody {
    
    //
    open var redpacMoney:String?
    open var obtainedCash:String?
    open var withdrawRedpac:String?
    open var lockStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/userRedpac"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/userRedpac"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        redpacMoney = visitableSource.getValue("redpacMoney")
        obtainedCash = visitableSource.getValue("obtainedCash")
        withdrawRedpac = visitableSource.getValue("withdrawRedpac")
        lockStatus = visitableSource.getValue("lockStatus")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BizcoupPostGetRedpacObtainRecord : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
    }
    
    //-------> list
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostGetRedpacObtainRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostGetRedpacObtainRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetGetRedpacObtainRecord : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizcoupRedpacObtainRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupRedpacObtainRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupRedpacObtainRecord) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupRedpacObtainRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupRedpacObtainRecord : BaseITWebAPIBody {
    
    //
    open var obtainRedpac:String?
    open var obtainChannel:String?
    open var createTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/getRedpacObtainRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        obtainRedpac = visitableSource.getValue("obtainRedpac")
        obtainChannel = visitableSource.getValue("obtainChannel")
        createTime = visitableSource.getValue("createTime")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BizcoupPostUseRedpacRecord : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
    }
    
    //-------> list
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUseRedpacRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUseRedpacRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetUseRedpacRecord : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizcoupUseRedpacRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupUseRedpacRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupUseRedpacRecord) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupUseRedpacRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupUseRedpacRecord : BaseITWebAPIBody {
    
    //
    open var useChannel:String?
    open var useRedpacNum:String?
    open var createTime:String?
    open var status:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/useRedpacRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        useChannel = visitableSource.getValue("useChannel")
        useRedpacNum = visitableSource.getValue("useRedpacNum")
        createTime = visitableSource.getValue("createTime")
        status = visitableSource.getValue("status")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostShiftToBanlance : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/shiftToBanlance"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/shiftToBanlance"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostShiftToBanlance",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostShiftToBanlance",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetShiftToBanlance : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/shiftToBanlance"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/shiftToBanlance"
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


open class BizcoupPostRedpacWithdraw : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var money:String?
    open var withdrawAccount:String?
    open var userName:String?
    open var accountFalg:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/redpacWithdraw"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/redpacWithdraw"
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
        let money_ = self.money;
        let withdrawAccount_ = self.withdrawAccount;
        let userName_ = self.userName;
        let accountFalg_ = self.accountFalg;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostRedpacWithdraw",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"money",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:money_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"money",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"withdrawAccount",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:withdrawAccount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"withdrawAccount",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"userName",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:userName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"userName",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"accountFalg",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:accountFalg_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"accountFalg",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostRedpacWithdraw",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetRedpacWithdraw : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/redpacWithdraw"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/redpacWithdraw"
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

open class BizcoupPostReceiveRedpac : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var obtainChannel:String?
    open var redpacPerc:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/receiveRedpac"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/receiveRedpac"
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
        let obtainChannel_ = self.obtainChannel;
        let redpacPerc_ = self.redpacPerc;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostReceiveRedpac",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"obtainChannel",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:obtainChannel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"obtainChannel",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"redpacPerc",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:redpacPerc_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"redpacPerc",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostReceiveRedpac",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetReceiveRedpac : BaseITWebAPIBody {
    
    //
    open var obtainRedpac:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/receiveRedpac"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/redpac/receiveRedpac"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        obtainRedpac = visitableSource.getValue("obtainRedpac")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupPostMemberLevel : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostMemberLevel",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostMemberLevel",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetMemberLevel : BaseITWebAPIBody {
    
    //
    //----->list
    open var data = [BizcoupMemberLevel]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupMemberLevel (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    open func addData(subBody:BizcoupMemberLevel) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupMemberLevel]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupMemberLevel : BaseITWebAPIBody {
    
    //
    open var level:String?
    open var levelName:String?
    open var levelPoints:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberLevel"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        level = visitableSource.getValue("level")
        levelName = visitableSource.getValue("levelName")
        levelPoints = visitableSource.getValue("levelPoints")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostMemberPoints : BaseITWebAPIBody {
    
    //
    open var terminalType:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPoints"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPoints"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let terminalType_ = self.terminalType;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostMemberPoints",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"terminalType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:terminalType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"terminalType",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostMemberPoints",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetMemberPoints : BaseITWebAPIBody {
    
    //
    open var totalPoints:String?
    open var userPoints:String?
    open var createTime:String?
    open var invalidTime:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPoints"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPoints"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        totalPoints = visitableSource.getValue("totalPoints")
        userPoints = visitableSource.getValue("userPoints")
        createTime = visitableSource.getValue("createTime")
        invalidTime = visitableSource.getValue("invalidTime")
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class BizcoupPostMemberPointsRecord : BaseITWebAPIBody {
    
    //
    open var start:String?
    open var limit:String?
    open var addOrSubtract:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let start_ = self.start;
        let limit_ = self.limit;
        let addOrSubtract_ = self.addOrSubtract;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostMemberPointsRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"addOrSubtract",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:addOrSubtract_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"addOrSubtract",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostMemberPointsRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class BizcoupRetMemberPointsRecord : BaseITWebAPIBody {
    
    //
    //----->list
    open var data = [BizcoupPointsRecord]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupPointsRecord (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
    }
    
    //-------> list
    open func addData(subBody:BizcoupPointsRecord) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupPointsRecord]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
open class BizcoupPointsRecord : BaseITWebAPIBody {
    
    //
    open var actionName:String?
    open var actionPoints:String?
    open var actionDate:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/getMemberPointsRecord"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        actionName = visitableSource.getValue("actionName")
        actionPoints = visitableSource.getValue("actionPoints")
        actionDate = visitableSource.getValue("actionDate")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostQueryYearCardDaysRemaining : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/queryYearCardDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/queryYearCardDaysRemaining"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostQueryYearCardDaysRemaining",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostQueryYearCardDaysRemaining",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetQueryYearCardDaysRemaining : BaseITWebAPIBody {
    
    //
    open var userCardStatus:String?
    open var daysRemaining:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/queryYearCardDaysRemaining"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/business/queryYearCardDaysRemaining"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        userCardStatus = visitableSource.getValue("userCardStatus")
        daysRemaining = visitableSource.getValue("daysRemaining")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostGetUserBuyYearCardList : BaseITWebAPIBody {
    
    //
    open var beginindex:String?
    open var retcount:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
    }
    
    //-------> list
    
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostGetUserBuyYearCardList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:beginindex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"beginindex",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:retcount_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"retcount",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostGetUserBuyYearCardList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetGetUserBuyYearCardList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [BizcoupGetUserBuyYearCardList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupGetUserBuyYearCardList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupGetUserBuyYearCardList) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupGetUserBuyYearCardList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupGetUserBuyYearCardList : BaseITWebAPIBody {
    
    //
    open var yearCardName:String?
    open var yearCardRentPrice:String?
    open var returnCurrency:String?
    open var depositTime:String?
    open var yearCardDiscount:String?
    open var createTime:String?
    open var serviceId:String?
    open var buyChannel:String?
    open var orderId:String?
    open var rechargeChannel:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getUserBuyYearCardList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        yearCardName = visitableSource.getValue("yearCardName")
        yearCardRentPrice = visitableSource.getValue("yearCardRentPrice")
        returnCurrency = visitableSource.getValue("returnCurrency")
        depositTime = visitableSource.getValue("depositTime")
        yearCardDiscount = visitableSource.getValue("yearCardDiscount")
        createTime = visitableSource.getValue("createTime")
        serviceId = visitableSource.getValue("serviceId")
        buyChannel = visitableSource.getValue("buyChannel")
        orderId = visitableSource.getValue("orderId")
        rechargeChannel = visitableSource.getValue("rechargeChannel")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostGetYearCardDetailList : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostGetYearCardDetailList",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostGetYearCardDetailList",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetGetYearCardDetailList : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    open var data = [BizcoupGetYearCardDetailList]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizcoupGetYearCardDetailList (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizcoupGetYearCardDetailList) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizcoupGetYearCardDetailList]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupGetYearCardDetailList : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var yearCardName:String?
    open var yearCardRentPrice:String?
    open var yearCardDiscount:String?
    open var returnCurrency:String?
    open var depositTime:String?
    open var display:String?
    open var remark:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/getYearCardDetailList"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        yearCardName = visitableSource.getValue("yearCardName")
        yearCardRentPrice = visitableSource.getValue("yearCardRentPrice")
        yearCardDiscount = visitableSource.getValue("yearCardDiscount")
        returnCurrency = visitableSource.getValue("returnCurrency")
        depositTime = visitableSource.getValue("depositTime")
        display = visitableSource.getValue("display")
        remark = visitableSource.getValue("remark")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostUserYearCardStatus : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/queryUserYearCardStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/queryUserYearCardStatus"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostUserYearCardStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:2,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:2,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostUserYearCardStatus",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetUserYearCardStatus : BaseITWebAPIBody {
    
    //
    open var reqStatus:String?
    open var id:String?
    open var yearCardStartTime:String?
    open var yearCardEndTime:String?
    open var yearCardStatus:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/queryUserYearCardStatus"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/purchase/queryUserYearCardStatus"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        reqStatus = visitableSource.getValue("reqStatus")
        id = visitableSource.getValue("id")
        yearCardStartTime = visitableSource.getValue("yearCardStartTime")
        yearCardEndTime = visitableSource.getValue("yearCardEndTime")
        yearCardStatus = visitableSource.getValue("yearCardStatus")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostYueshiGetURLRecord : BaseITWebAPIBody {
    
    //
    open var redirect:String?
    open var vip:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/yueshi/getURL"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/yueshi/getURL"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let redirect_ = self.redirect;
        let vip_ = self.vip;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostYueshiGetURLRecord",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"redirect",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:redirect_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"redirect",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"vip",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:vip_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"vip",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostYueshiGetURLRecord",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetYueShiGetURLRecord : BaseITWebAPIBody {
    
    //
    open var url:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/yueshi/getURL"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/points/yueshi/getURL"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        url = visitableSource.getValue("url")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizcoupPostLoginSendCoup : BaseITWebAPIBody {
    
    //
                                    open var serviceId:String?
                                open var loginType:String?
                                open var sendType:String?
            
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
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
                                                                                    let loginType_ = self.loginType;
                                                                                    let sendType_ = self.sendType;
                                    
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostLoginSendCoup",body:self))
                                            result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
                result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
                result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"loginType",body:self))
                result.append(vo.onFieldValue(.flat,index:3,length:5,value:loginType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"loginType",body:self))
                                                result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"sendType",body:self))
                result.append(vo.onFieldValue(.flat,index:4,length:5,value:sendType_ ?? "",body:self))
                result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"sendType",body:self))
                                    result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostLoginSendCoup",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
    }

        
open class BizcoupRetLoginSendCoup : BaseITWebAPIBody {
    
    //
                                                open var dataCount:String?
                                //----->list
            fileprivate var data = [BizcoupLoginSendCoupList]()
            //>-----
            
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
                    //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
                        }
                                                                        retcode = visitableSource.getValue("retcode")
                                                                                                            retmsg = visitableSource.getValue("retmsg")
                                                                                                            dataCount = visitableSource.getValue("dataCount")
                                                                                    //----->list
                    for visitableSource in visitableSource.getSubSource("data") {
                        data .append( BizcoupLoginSendCoupList (visitableSource:visitableSource,secureKeys:secureKeys))
                    }
                    //>-----
                                        }

    //-------> list
                                                        open func addData(subBody:BizcoupLoginSendCoupList) -> Void{
            data.append(subBody)
        }

        open func getData() -> [BizcoupLoginSendCoupList]{
            return data
        }
            
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

    
    open func isRequestBody() -> Bool{
        return false;
    }
                                                                                                    
open class BizcoupLoginSendCoupList : BaseITWebAPIBody {
    
    //
                        open var title:String?
                                open var couponType:String?
                                open var vaildStatTime:String?
                                open var vaildEndTime:String?
                                open var usedCity:String?
                                open var devType:String?
                                open var remarks:String?
                                open var imagePath:String?
                                open var money:String?
                                open var discount:String?
                                open var quantity:String?
                                open var status:String?
            
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/activity/loginSendCoup"
                    //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
                        }
                                                                        title = visitableSource.getValue("title")
                                                                                                            couponType = visitableSource.getValue("couponType")
                                                                                                            vaildStatTime = visitableSource.getValue("vaildStatTime")
                                                                                                            vaildEndTime = visitableSource.getValue("vaildEndTime")
                                                                                                            usedCity = visitableSource.getValue("usedCity")
                                                                                                            devType = visitableSource.getValue("devType")
                                                                                                            remarks = visitableSource.getValue("remarks")
                                                                                                            imagePath = visitableSource.getValue("imagePath")
                                                                                                            money = visitableSource.getValue("money")
                                                                                                            discount = visitableSource.getValue("discount")
                                                                                                            quantity = visitableSource.getValue("quantity")
                                                                                                            status = visitableSource.getValue("status")
                                                            }

    //-------> list
                                                                                                                                                    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

    
    open func isRequestBody() -> Bool{
        return false;
    }
    }
                        }

open class BizcoupPostExchangeCoupon : BaseITWebAPIBody {
    
    //
    open var serviceId:String?
    open var command:String?
    open var channel:String?
    
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/exchangeCoupon"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/exchangeCoupon"
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
        let command_ = self.command;
        let channel_ = self.channel;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizcoupPostExchangeCoupon",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serviceId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"command",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:command_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"command",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizcoupPostExchangeCoupon",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizcoupRetExchangeCoupon : BaseITWebAPIBody {
    
    //
                                                open var awardType:String?
                                open var awardDetail:String?
                                open var linkUrl:String?
            
    required public init(){
        super.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/exchangeCoupon"
    }

    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "40"
        self.appName_ = "bizcoup"
        self.mapping_ = "/api/coupon/wallet/exchangeCoupon"
                    //====   md5 check   ====
            if !String.isEmpty(visitableSource.getValue("sign")) {
                        }
                                                                        retcode = visitableSource.getValue("retcode")
                                                                                                            retmsg = visitableSource.getValue("retmsg")
                                                                                                            awardType = visitableSource.getValue("awardType")
                                                                                                            awardDetail = visitableSource.getValue("awardDetail")
                                                                                                            linkUrl = visitableSource.getValue("linkUrl")
                                                            }

    //-------> list
                                                                
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }

    
    open func isRequestBody() -> Bool{
        return false;
    }
    }
