import Foundation

// MARK: Factory
open class UumWebAPIContext : ITWebAPIContext{
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
        				case "/uum/security/getVcode":
				if type == .requestBody {
                    body = UumPostGetVcode()
                } else {
                    body = UumRetGetVcode(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
						case "/uum/security/vcodeLogin":
				if type == .requestBody {
                    body = UumPostVCodeLogin()
                } else {
                    body = UumRetVCodeLogin(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/uum/member/updateAvatar":
                if type == .requestBody {
                    body = UumPostUpdateAvatar()
                } else {
                    body = UumRetUpdateAvatar(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/uum/member/isThirdBind":
                if type == .requestBody {
                    body = UumPostIsThirdBind()
                } else {
                    body = UumRetIsThirdBind(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                        case "/uum/member/ThirdSwitchBind":
                if type == .requestBody {
                    body = UumPostThirdSwitchBind()
                } else {
                    body = UumRetThirdSwitchBind(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
            break
                         case "/uum/security/thirdBindLogin":
                if type == .requestBody {
                    body = UumPostThirdBindLogin()
                } else {
                    body = UumRetThirdBindLogin(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
                break
                        case "/uum/member/getMemberInfo":
                if type == .requestBody {
                    body = UumPostGetMemberInfo()
                } else {
                    body = UumRetGetMemberInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
                break
                        case "/uum/member/updateMemberInfo":
                if type == .requestBody {
                    body = UumPostUpdateMemberInfo()
                } else {
                    body = UumRetUpdateMemberInfo(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
                }
                break
        case "/api/uum/security/memLoginLog":
            if type == .requestBody {
                body = UumPostMemLoginLog()
            } else {
                body = UumRetMemLoginLog(visitableSource: self.visitablePair.getVisitableSource(content ?? ""),secureKeys:secureKeys)
            }
            break
						default:
			body = BaseITWebAPIBody()
        }
        body.context = self
        return body
    }
}


		
open class UumPostGetVcode : BaseITWebAPIBody {
    
    //
    open var appId:String?
    open var phoneNO:String?
    open var type:String?
    open var channel:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/getVcode"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/getVcode"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let appId_ = self.appId;
        let phoneNO_ = self.phoneNO;
        let type_ = self.type;
        let channel_ = self.channel;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostGetVcode",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:appId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"appId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"phoneNO",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:phoneNO_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"phoneNO",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"type",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:type_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"type",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:channel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"channel",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostGetVcode",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
		
open class UumRetGetVcode : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/getVcode"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/getVcode"
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
		
open class UumPostVCodeLogin : BaseITWebAPIBody {
    
    //
    open var loginName:String?
    open var vcode:String?
    open var userToken:String?
    open var password:String?
    open var registerChannel:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/vcodeLogin"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/vcodeLogin"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let loginName_ = self.loginName;
        let vcode_ = self.vcode;
        let userToken_ = self.userToken;
        let password_ = self.password;
        let registerChannel_ = self.registerChannel;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostVCodeLogin",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"loginName",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:loginName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"loginName",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"vcode",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:vcode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"vcode",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"userToken",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:userToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"userToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"password",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:password_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"password",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"registerChannel",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:registerChannel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"registerChannel",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostVCodeLogin",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}
		
open class UumRetVCodeLogin : BaseITWebAPIBody {
	
    open var userId:String?
    open var phoneNO:String?
    open var avatarURL:String?
    open var userToken:String?
    open var exchangeKey:String?
    
	required public init(){
		super.init()
		self.appId_ = "20"
		self.appName_ = "uum"
		self.mapping_ = "/uum/security/vcodeLogin"
	}

	required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
		self.appName_ = "uum"
		self.mapping_ = "/uum/security/vcodeLogin"
        			//====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {}
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        userId = visitableSource.getValue("userId")
        phoneNO = visitableSource.getValue("phoneNO")
        avatarURL = visitableSource.getValue("avatarURL")
        userToken = visitableSource.getValue("userToken")
        exchangeKey = visitableSource.getValue("exchangeKey")
        accessToken = visitableSource.getValue("accessToken")
    }

	//-------> one-to-many
	override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
	open func isRequestBody() -> Bool{
    	return false;
    }
}

open class UumPostUpdateAvatar : BaseITWebAPIBody {
    
    //
    open var avatarURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateAvatar"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateAvatar"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let avatarURL_ = self.avatarURL;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("avatarURL=" + (avatarURL_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostUpdateAvatar",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:3,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:3,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:3,field:"avatarURL",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:3,value:avatarURL_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:3,field:"avatarURL",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:3,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:3,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostUpdateAvatar",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}


open class UumRetUpdateAvatar : BaseITWebAPIBody {
    
    //
    open var avatarURL:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateAvatar"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateAvatar"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        avatarURL = visitableSource.getValue("avatarURL")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class UumPostThirdBindLogin : BaseITWebAPIBody {
    
    //
    open var memberName:String?
    open var avatarURL:String?
    open var bindId:String?
    open var thirdBindType:String?
    open var userPhone:String?
    open var vcode:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/thirdBindLogin"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/thirdBindLogin"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let memberName_ = self.memberName;
        let avatarURL_ = self.avatarURL;
        let bindId_ = self.bindId;
        let thirdBindType_ = self.thirdBindType;
        let userPhone_ = self.userPhone;
        let vcode_ = self.vcode;
        
        //====   md5 check   ====
        var md5:[String] = []
        md5.append("avatarURL=" + (avatarURL_ ?? ""))
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostThirdBindLogin",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:7,field:"memberName",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:7,value:memberName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:7,field:"memberName",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:7,field:"avatarURL",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:7,value:avatarURL_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:7,field:"avatarURL",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:7,field:"bindId",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:7,value:bindId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:7,field:"bindId",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:7,field:"thirdBindType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:7,value:thirdBindType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:7,field:"thirdBindType",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:7,field:"userPhone",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:7,value:userPhone_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:7,field:"userPhone",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:7,field:"vcode",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:7,value:vcode_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:7,field:"vcode",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:7,value:md5.joined(separator:"").md5,body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:7,field:"sign",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostThirdBindLogin",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetThirdBindLogin : BaseITWebAPIBody {
    
    //
    open var userId:String?
    open var phoneNO:String?
    open var avatarURL:String?
    open var userToken:String?
    open var exchangeKey:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/thirdBindLogin"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/security/thirdBindLogin"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        userId = visitableSource.getValue("userId")
        phoneNO = visitableSource.getValue("phoneNO")
        avatarURL = visitableSource.getValue("avatarURL")
        userToken = visitableSource.getValue("userToken")
        exchangeKey = visitableSource.getValue("exchangeKey")
        accessToken = visitableSource.getValue("accessToken")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class UumPostThirdSwitchBind : BaseITWebAPIBody {
    
    //
    open var memberPhone:String?
    open var loginId:String?
    open var thirdBindType:String?
    open var bindId:String?
    open var switchType:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/ThirdSwitchBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/ThirdSwitchBind"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let memberPhone_ = self.memberPhone;
        let loginId_ = self.loginId;
        let thirdBindType_ = self.thirdBindType;
        let bindId_ = self.bindId;
        let switchType_ = self.switchType;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostThirdSwitchBind",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:6,field:"memberPhone",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:6,value:memberPhone_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:6,field:"memberPhone",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:6,field:"loginId",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:6,value:loginId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:6,field:"loginId",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:6,field:"thirdBindType",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:6,value:thirdBindType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:6,field:"thirdBindType",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:6,field:"bindId",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:6,value:bindId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:6,field:"bindId",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:6,field:"switchType",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:6,value:switchType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:6,field:"switchType",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostThirdSwitchBind",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetThirdSwitchBind : BaseITWebAPIBody {
    
    //
    open var result:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/ThirdSwitchBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/ThirdSwitchBind"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        result = visitableSource.getValue("result")
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}


open class UumPostIsThirdBind : BaseITWebAPIBody {
    
    //
    open var bindId:String?
    open var thirdBindType:String?
    open var memberPhone:String?
    open var requestType:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/isThirdBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/isThirdBind"
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let bindId_ = self.bindId;
        let thirdBindType_ = self.thirdBindType;
        let memberPhone_ = self.memberPhone;
        let requestType_ = self.requestType;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostIsThirdBind",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:5,field:"bindId",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:5,value:bindId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:5,field:"bindId",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:5,field:"thirdBindType",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:5,value:thirdBindType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:5,field:"thirdBindType",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:5,field:"memberPhone",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:5,value:memberPhone_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:5,field:"memberPhone",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:5,field:"requestType",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:5,value:requestType_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:5,field:"requestType",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostIsThirdBind",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetIsThirdBind : BaseITWebAPIBody {
    
    //
    open var isRegister:String?
    open var userId:String?
    open var phoneNO:String?
    open var avatarURL:String?
    open var userToken:String?
    open var exchangeKey:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/isThirdBind"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/isThirdBind"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        isRegister = visitableSource.getValue("isRegister")
        userId = visitableSource.getValue("userId")
        phoneNO = visitableSource.getValue("phoneNO")
        avatarURL = visitableSource.getValue("avatarURL")
        userToken = visitableSource.getValue("userToken")
        exchangeKey = visitableSource.getValue("exchangeKey")
        
        if visitableSource.getValue("accessToken") != "" && visitableSource.getValue("accessToken") != "null" {
            accessToken = visitableSource.getValue("accessToken")
        }
    }
    
    //-------> one-to-many
    
    override open var serverMode:ITSeverMode { get { return .sermode_no_token } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class UumPostUpdateMemberInfo : BaseITWebAPIBody {
    
    //
    open var nickName:String?
    open var avatarURL:String?
    open var memberAlias:String?
    open var memberSex:String?
    open var memberBirthday:String?
    open var memberIndustry:String?
    open var memberTags:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateMemberInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateMemberInfo"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let nickName_ = self.nickName;
        let avatarURL_ = self.avatarURL;
        let memberAlias_ = self.memberAlias;
        let memberSex_ = self.memberSex;
        let memberBirthday_ = self.memberBirthday;
        let memberIndustry_ = self.memberIndustry;
        let memberTags_ = self.memberTags;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostUpdateMemberInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"nickName",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:9,value:nickName_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"nickName",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"avatarURL",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:9,value:avatarURL_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"avatarURL",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"memberAlias",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:9,value:memberAlias_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"memberAlias",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"memberSex",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:9,value:memberSex_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"memberSex",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"memberBirthday",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:9,value:memberBirthday_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"memberBirthday",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"memberIndustry",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:9,value:memberIndustry_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"memberIndustry",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"memberTags",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:9,value:memberTags_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"memberTags",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostUpdateMemberInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetUpdateMemberInfo : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateMemberInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/updateMemberInfo"
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

open class UumPostGetMemberInfo : BaseITWebAPIBody {
    
    //
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/getMemberInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/getMemberInfo"
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
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostGetMemberInfo",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:2,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:2,field:"accessToken",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostGetMemberInfo",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetGetMemberInfo : BaseITWebAPIBody {
    
    //
    open var bizStatus:String?
    open var userId:String?
    open var phoneNo:String?
    open var nickName:String?
    open var avatarURL:String?
    open var memberAlias:String?
    open var memberSex:String?
    open var memberBirthday:String?
    open var memberIndustry:String?
    open var memberTags:String?
    open var firstEditFlag:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/getMemberInfo"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/uum/member/getMemberInfo"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        bizStatus = visitableSource.getValue("bizStatus")
        userId = visitableSource.getValue("userId")
        phoneNo = visitableSource.getValue("phoneNo")
        nickName = visitableSource.getValue("nickName")
        avatarURL = visitableSource.getValue("avatarURL")
        memberAlias = visitableSource.getValue("memberAlias")
        memberSex = visitableSource.getValue("memberSex")
        memberBirthday = visitableSource.getValue("memberBirthday")
        memberIndustry = visitableSource.getValue("memberIndustry")
        memberTags = visitableSource.getValue("memberTags")
        firstEditFlag = visitableSource.getValue("firstEditFlag")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}

open class UumPostMemLoginLog : BaseITWebAPIBody {
    
    //
    open var terminaltype:String?
    open var phoneFirm:String?
    open var phonemodel:String?
    open var phoneVersion:String?
    open var appVersion:String?
    open var ipAdd:String?
    open var serviceId:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/memLoginLog"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/memLoginLog"
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    override open func encode(_ index:UInt8,length:UInt8,visitableObject:ITVisitableObject?,secureKeys:[String:ITSecureKey]?) -> String?{
        guard let vo = visitableObject else {
            return nil
        }
        
        //====encrypt field====
        let accessToken_ = self.accessToken;
        let terminaltype_ = self.terminaltype;
        let phoneFirm_ = self.phoneFirm;
        let phonemodel_ = self.phonemodel;
        let phoneVersion_ = self.phoneVersion;
        let appVersion_ = self.appVersion;
        let ipAdd_ = self.ipAdd;
        let serviceId_ = self.serviceId;
        
        //====   md5 check   ====
        
        //====serialize field====
        var result:[String] = []
        result.append(vo.onObjectBegin(index,length:length,objname:"UumPostMemLoginLog",body:self))
        result.append(vo.onFieldBegin(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldValue(.flat,index:1,length:9,value:accessToken_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:1,length:9,field:"accessToken",body:self))
        result.append(vo.onFieldBegin(.flat,index:2,length:9,field:"terminaltype",body:self))
        result.append(vo.onFieldValue(.flat,index:2,length:9,value:terminaltype_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:2,length:9,field:"terminaltype",body:self))
        result.append(vo.onFieldBegin(.flat,index:3,length:9,field:"phoneFirm",body:self))
        result.append(vo.onFieldValue(.flat,index:3,length:9,value:phoneFirm_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:3,length:9,field:"phoneFirm",body:self))
        result.append(vo.onFieldBegin(.flat,index:4,length:9,field:"phonemodel",body:self))
        result.append(vo.onFieldValue(.flat,index:4,length:9,value:phonemodel_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:4,length:9,field:"phonemodel",body:self))
        result.append(vo.onFieldBegin(.flat,index:5,length:9,field:"phoneVersion",body:self))
        result.append(vo.onFieldValue(.flat,index:5,length:9,value:phoneVersion_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:5,length:9,field:"phoneVersion",body:self))
        result.append(vo.onFieldBegin(.flat,index:6,length:9,field:"appVersion",body:self))
        result.append(vo.onFieldValue(.flat,index:6,length:9,value:appVersion_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:6,length:9,field:"appVersion",body:self))
        result.append(vo.onFieldBegin(.flat,index:7,length:9,field:"ipAdd",body:self))
        result.append(vo.onFieldValue(.flat,index:7,length:9,value:ipAdd_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:7,length:9,field:"ipAdd",body:self))
        result.append(vo.onFieldBegin(.flat,index:8,length:9,field:"serviceId",body:self))
        result.append(vo.onFieldValue(.flat,index:8,length:9,value:serviceId_ ?? "",body:self))
        result.append(vo.onFieldEnd(.flat,index:8,length:9,field:"serviceId",body:self))
        result.append(vo.onObjectEnd(index,length:length,objname:"UumPostMemLoginLog",body:self))
        return result.joined(separator:"")
    }
    
    open func isRequestBody() -> Bool{
        return true;
    }
}

open class UumRetMemLoginLog : BaseITWebAPIBody {
    
    //
    open var loginFlag:String?
    open var expire:String?
    
    required public init(){
        super.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/memLoginLog"
    }
    
    required public convenience init(visitableSource:ITVisitableSource,secureKeys:[String:ITSecureKey]){
        self.init()
        self.appId_ = "20"
        self.appName_ = "uum"
        self.mapping_ = "/api/uum/security/memLoginLog"
        //====   md5 check   ====
        if !String.isEmpty(visitableSource.getValue("sign")) {
        }
        retcode = visitableSource.getValue("retcode")
        retmsg = visitableSource.getValue("retmsg")
        loginFlag = visitableSource.getValue("loginFlag")
        expire = visitableSource.getValue("expire")
    }
    
    //-------> list
    
    override open var serverMode:ITSeverMode { get { return .sermode_normal } }
    
    
    open func isRequestBody() -> Bool{
        return false;
    }
}
