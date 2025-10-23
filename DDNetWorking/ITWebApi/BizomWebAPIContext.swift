import Foundation

// MARK: Factory
open class BizomWebAPIContext : ITWebAPIContext{
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
            case "/api/bizom/activity/createActivity":
				if type == .requestBody {
                    body = BizomPostCreateAcitvity()
                } else {
                    body = BizomRetCreateAcitvity(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
            case "/bizom/activity/getActivities":
				if type == .requestBody {
                    body = BizomPostGetActivities()
                } else {
                    body = BizomRetGetActivities(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
            case "/bizom/activity/getUserActivities":
                if type == .requestBody {
                    body = BizomPostGetUserActivities()
                } else {
                    body = BizomRetGetUserActivities(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
            case "/bizom/oss/getOssAccessKey":
                if type == .requestBody {
                    body = BizomPostAccessKey()
                } else {
                    body = BizomRetAccessKey(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
            case "/bizom/activity/getNotices":
                if type == .requestBody {
                    body = BizomPostGetNotices()
                } else {
                    body = BizomRetGetNotices(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
            case "/bizom/activity/getAPPAds":
            if type == .requestBody {
                body = BizomPostGetAPPAdss()
            } else {
                body = BizomRetGetAPPAds(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            case "/bizom/games/getGamesLists":
            if type == .requestBody {
                body = BizomPostGetGamesLists()
            } else {
                body = BizomRetGetGamesLists(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
        case "/api/bizom/activity/getDynamicAds":
            if type == .requestBody {
                body = BizomPostGetDynamicAds()
            } else {
                body = BizomRetGetDynamicAds(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
            default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}

open class BizomPostCreateAcitvity : BaseITWebAPIBody {
    
    //
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var lonLat:String?
    open var faultPart:String?
    open var faultDetail:String?
    open var bikeType:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/createActivity"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/createActivity"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let type_ = secureKeys?["AES"]?.encrypt(original: self.type) ?? ""
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let serId_ = secureKeys?["AES"]?.encrypt(original: self.serId) ?? ""
        let title_ = secureKeys?["AES"]?.encrypt(original: self.title) ?? ""
        let content_ = secureKeys?["AES"]?.encrypt(original: self.content) ?? ""
        let lonLat_ = self.lonLat;
        let faultPart_ = self.faultPart;
        let faultDetail_ = self.faultDetail;
        let bikeType_ = self.bikeType;
        let media1_ = self.media1;
        let media2_ = self.media2;
        let media3_ = self.media3;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&type=" + (type_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        md5.append("&title=" + (title_ ?? ""))
        md5.append("&content=" + (content_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostCreateAcitvity",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:13,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:13,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:13,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:13,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:13,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:13,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:13,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:13,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:13,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:13,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:13,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:13,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:13,field:"title",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:13,value:title_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:13,field:"title",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:13,field:"content",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:13,value:content_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:13,field:"content",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:13,field:"lonLat",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:13,value:lonLat_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:13,field:"lonLat",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:13,field:"faultPart",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:13,value:faultPart_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:13,field:"faultPart",body:self))
        result.append(vo.onFieldBegin(.flat,index:9,length:13,field:"faultDetail",body:self))
        result.append(vo.onFieldValue(.flat,index:9,length:13,value:faultDetail_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:9,length:13,field:"faultDetail",body:self))
        result.append(vo.onFieldBegin(.flat,index:10,length:14,field:"bikeType",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:14,value:bikeType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:14,field:"bikeType",body:self))
        
        result.append(vo.onFieldBegin(.flat,index:10,length:13,field:"media1",body:self))
        result.append(vo.onFieldValue(.flat,index:10,length:13,value:media1_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:10,length:13,field:"media1",body:self))
        result.append(vo.onFieldBegin(.flat,index:11,length:13,field:"media2",body:self))
        result.append(vo.onFieldValue(.flat,index:11,length:13,value:media2_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:11,length:13,field:"media2",body:self))
        result.append(vo.onFieldBegin(.flat,index:12,length:13,field:"media3",body:self))
        result.append(vo.onFieldValue(.flat,index:12,length:13,value:media3_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:12,length:13,field:"media3",body:self))
        result.append(vo.onFieldBegin(.flat,index:13,length:13,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:13,length:13,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:13,length:13,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostCreateAcitvity",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
		
open class BizomRetCreateAcitvity : BaseITWebAPIBody {
	
    open var actId:String?
    
	required public init(){
		super.init()
		self.appId_ = "23"
		self.appName_ = "bizom"
		self.mapping_ = "/api/bizom/activity/createActivity"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
		self.appName_ = "bizom"
		self.mapping_ = "/api/bizom/activity/createActivity"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
            retcode = visitableSource.getValue("retcode")
            retmsg = visitableSource.getValue("retmsg")
            actId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("actId"))
        }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_normal } }
	open func isRequestBody() -> Bool{
    	return false;
    }
}

		
open class BizomPostGetActivities : BaseITWebAPIBody {
    
    //
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var start:String?
    open var limit:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let type_ = self.type;
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let serId_ = secureKeys?["AES"]?.encrypt(original: self.serId) ?? ""
        let title_ = secureKeys?["AES"]?.encrypt(original: self.title) ?? ""
        let start_ = self.start;
        let limit_ = self.limit;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("type=" + (type_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        md5.append("&title=" + (title_ ?? ""))
        md5.append("&start=" + (start_ ?? ""))
        md5.append("&limit=" + (limit_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetActivities",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"title",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:title_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"title",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:7,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetActivities",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetActivities : BaseITWebAPIBody {
    
    open var datacount:String?
    open var data = [BizomRetGetActivitiesDetail]()
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizomRetGetActivitiesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBizomRetGetActivitiesDetail(subBody:BizomRetGetActivitiesDetail) -> Void{
        data.append(subBody)
    }
    
    open func getBizomRetGetActivitiesDetail() -> [BizomRetGetActivitiesDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }

}

open class BizomRetGetActivitiesDetail : BaseITWebAPIBody {
    
    //
    open var actId:String?
    open var userId:String?
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var reply:String?
    open var createTime:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getActivities"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        actId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("actId"))
        userId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("userId"))
        type = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("type"))
        appId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("appId"))
        serId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("serId"))
        title = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("title"))
        content = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("content"))
        reply = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("reply"))
        createTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("createTime"))
        media1 = visitableSource.getValue("media1")
        media2 = visitableSource.getValue("media2")
        media3 = visitableSource.getValue("media3")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostAccessKey : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serId:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/oss/getOssAccessKey"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/oss/getOssAccessKey"
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
        let serId_ = secureKeys?["AES"]?.encrypt(original: self.serId) ?? ""
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&appId=" + (appId_ ))
        md5.append("&serId=" + (serId_ ))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostAccessKey",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:4,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:4,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:4,value:appId_ ,body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:4,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:serId_ ,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:4,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:4,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostAccessKey",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetAccessKey : BaseITWebAPIBody {
    
    //
    open var accessKeyID:String?
    open var accessKeySecret:String?
    open var bucketName:String?
    open var endPoint:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/oss/getOssAccessKey"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/oss/getOssAccessKey"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        accessKeyID = visitableSource.getValue("accessKeyID")
        accessKeySecret = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("accessKeySecret"))
        bucketName = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("bucketName"))
        endPoint = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("endPoint"))
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostGetNotices : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serId:String?
    open var start:String?
    open var limit:String?
    open var virStatus:String?
    open var openChannel:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let serId_ = self.serId;
        let start_ = self.start;
        let limit_ = self.limit;
        let virStatus_ = self.virStatus;
        let openChannel_ = self.openChannel;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        md5.append("&start=" + (start_ ?? ""))
        md5.append("&limit=" + (limit_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetNotices",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"virStatus",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:virStatus_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"virStatus",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"openChannel",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:openChannel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"openChannel",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:7,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetNotices",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetNotices : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    var data = [BizomRetGetNoticesDetail]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizomRetGetNoticesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizomRetGetNoticesDetail) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizomRetGetNoticesDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostGetAPPAdss : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serId:String?
    open var type:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getAPPAds"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getAPPAds"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let serId_ = self.serId;
        let type_ = self.type;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetAPPAdss",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:4,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:4,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:4,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetAPPAdss",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetAPPAds : BaseITWebAPIBody {
    
    //
    open var title:String?
    open var content:String?
    open var media1:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getAPPAds"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getAPPAds"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        title = visitableSource.getValue("title")
        content = visitableSource.getValue("content")
        media1 = visitableSource.getValue("media1")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}



open class BizomRetGetNoticesDetail : BaseITWebAPIBody {
    
    //
    open var noticeId:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var createTime:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getNotices"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        noticeId = visitableSource.getValue("noticeId")
        appId = visitableSource.getValue("appId")
        serId = visitableSource.getValue("serId")
        title = visitableSource.getValue("title")
        content = visitableSource.getValue("content")
        createTime = visitableSource.getValue("createTime")
        media1 = visitableSource.getValue("media1")
        media2 = visitableSource.getValue("media2")
        media3 = visitableSource.getValue("media3")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostGetUserActivities : BaseITWebAPIBody {
    
    //
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var start:String?
    open var limit:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let type_ = self.type;
        let appId_ = secureKeys?["AES"]?.encrypt(original: self.appId) ?? ""
        let serId_ = secureKeys?["AES"]?.encrypt(original: self.serId) ?? ""
        let title_ = secureKeys?["AES"]?.encrypt(original: self.title) ?? ""
        let start_ = self.start;
        let limit_ = self.limit;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("accessToken=" + (accessToken_ ?? ""))
        md5.append("&type=" + (type_ ?? ""))
        md5.append("&appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        md5.append("&title=" + (title_ ?? ""))
        md5.append("&start=" + (start_ ?? ""))
        md5.append("&limit=" + (limit_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetUserActivities",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:8,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:8,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:8,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:8,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:8,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:8,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:8,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:8,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:8,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:8,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:8,field:"title",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:8,value:title_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:8,field:"title",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:8,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:8,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:8,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:8,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:8,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:8,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:8,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:8,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:8,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetUserActivities",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetUserActivities : BaseITWebAPIBody {
    
    open var datacount:String?
    open var data = [BizomRetGetUserActivitiesDetail]()
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("datacount"))
        //----->one-to-manay
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizomRetGetUserActivitiesDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> one-to-many
    open func addBizomRetGetUserActivitiesDetail(subBody:BizomRetGetUserActivitiesDetail) -> Void{
        data.append(subBody)
    }
    
    open func getBizomRetGetUserActivitiesDetail() -> [BizomRetGetUserActivitiesDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomRetGetUserActivitiesDetail : BaseITWebAPIBody {
    
    //
    open var actId:String?
    open var userId:String?
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var reply:String?
    open var createTime:String?
    open var lonLat:String?
    open var faultPart:String?
    open var faultDetail:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/activity/getUserActivities"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        actId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("actId"))
        userId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("userId"))
        type = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("type"))
        appId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("appId"))
        serId = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("serId"))
        title = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("title"))
        content = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("content"))
        lonLat = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("lonLat"))
        faultPart = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("faultPart"))
        faultDetail = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("faultDetail"))
        reply = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("reply"))
        createTime = secureKeys["AES"]?.decrypt(original: visitableSource.getValue("createTime"))
        media1 = visitableSource.getValue("media1")
        media2 = visitableSource.getValue("media2")
        media3 = visitableSource.getValue("media3")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostGetGamesLists : BaseITWebAPIBody {
    
    //
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var start:String?
    open var limit:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let type_ = self.type;
        let appId_ = self.appId;
        let serId_ = self.serId;
        let start_ = self.start;
        let limit_ = self.limit;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetGamesLists",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"limit",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetGamesLists",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetGamesLists : BaseITWebAPIBody {
    
    open var datacount:String?
    open var data = [BizomRetGetGames]()
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data.append( BizomRetGetGames (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizomRetGetGames) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizomRetGetGames]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomRetGetGames : BaseITWebAPIBody {
    
    //
    open var id:String?
    open var type:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var createTime:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/bizom/games/getGamesLists"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        id = visitableSource.getValue("id")
        type = visitableSource.getValue("type")
        appId = visitableSource.getValue("appId")
        serId = visitableSource.getValue("serId")
        title = visitableSource.getValue("title")
        content = visitableSource.getValue("content")
        createTime = visitableSource.getValue("createTime")
        media1 = visitableSource.getValue("media1")
        media2 = visitableSource.getValue("media2")
        media3 = visitableSource.getValue("media3")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomPostGetDynamicAds : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var serId:String?
    open var start:String?
    open var limit:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let serId_ = self.serId;
        let start_ = self.start;
        let limit_ = self.limit;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("appId=" + (appId_ ?? ""))
        md5.append("&serId=" + (serId_ ?? ""))
        md5.append("&start=" + (start_ ?? ""))
        md5.append("&limit=" + (limit_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"BizomPostGetDynamicAds",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"serId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:serId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"serId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"start",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:start_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"start",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"limit",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:limit_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"limit",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:5,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:5,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"BizomPostGetDynamicAds",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class BizomRetGetDynamicAds : BaseITWebAPIBody {
    
    //
    open var datacount:String?
    //----->list
    fileprivate var data = [BizomRetGetDynamicAdsDetail]()
    //>-----
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        datacount = visitableSource.getValue("datacount")
        //----->list
        for visitableSource in visitableSource.getSubSource("data") {
            data .append( BizomRetGetDynamicAdsDetail (visitableSource:visitableSource,secureKeys:secureKeys))
        }
        //>-----
    }
    
    //-------> list
    open func addData(subBody:BizomRetGetDynamicAdsDetail) -> Void{
        data.append(subBody)
    }
    
    open func getData() -> [BizomRetGetDynamicAdsDetail]{
        return data
    }
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class BizomRetGetDynamicAdsDetail : BaseITWebAPIBody {
    
    //
    open var adId:String?
    open var appId:String?
    open var serId:String?
    open var title:String?
    open var content:String?
    open var createTime:String?
    open var media1:String?
    open var media2:String?
    open var media3:String?
    open var linkURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "23"
        self.appName_ = "bizom"
        self.mapping_ = "/api/bizom/activity/getDynamicAds"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        adId = visitableSource.getValue("adId")
        appId = visitableSource.getValue("appId")
        serId = visitableSource.getValue("serId")
        title = visitableSource.getValue("title")
        content = visitableSource.getValue("content")
        createTime = visitableSource.getValue("createTime")
        media1 = visitableSource.getValue("media1")
        media2 = visitableSource.getValue("media2")
        media3 = visitableSource.getValue("media3")
        linkURL = visitableSource.getValue("linkURL")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
