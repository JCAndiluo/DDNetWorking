//
//  ITWebAPIVisit.swift
//  ITWebAPI
//
//  Created by 吴知洋 on 16/2/23.
//  Copyright © 2016年 杭州艾拓. All rights reserved.
//

import Foundation
import AEXML
import SwiftyJSON
/**
 
*/
public enum ITVisitableObjectFieldType{
    case flat
    case array
    case object
}
// MARK:VisitableObject
/**
 对象访问接口
 主要实现将对象的属性转换成String
 */
public protocol ITVisitableObject{
    func onObjectBegin(_ index:UInt8,length:UInt8,objname:String,body:ITWebAPIBody) -> String
    func onObjectEnd(_ index:UInt8,length:UInt8,objname:String,body:ITWebAPIBody) -> String
    func onFieldBegin(_ type:ITVisitableObjectFieldType,index:UInt8,length:UInt8,field:String,body:ITWebAPIBody) -> String
    func onFieldValue(_ type:ITVisitableObjectFieldType,index:UInt8,length:UInt8,value:String,body:ITWebAPIBody) -> String
    func onFieldEnd(_ type:ITVisitableObjectFieldType,index:UInt8,length:UInt8,field:String,body:ITWebAPIBody) -> String
}
/**
 Json实现类
*/
open class ITJsonVisitableObject : ITVisitableObject{
    open func onObjectBegin(_ index: UInt8, length: UInt8, objname: String,body:ITWebAPIBody) -> String {

        let result = String(format: "{name_=\"%@\" appId_=\"%@\" appName_=\"%@\" mapping_=\"%@\" ",
                            arguments: [objname,body.appId_,body.appName_,body.mapping_])
        return result
    }
    open func onObjectEnd(_ index: UInt8, length: UInt8, objname: String,body:ITWebAPIBody) -> String {
        return String(format: "} %@", arguments: [(index == length ? "" : ",")])
    }
    
    open func onFieldBegin(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, field: String,body:ITWebAPIBody) -> String {
        return String(format : "\"%@\":%@",[field,(type == .array ? "[" : "")])
    }
    
    open func onFieldValue(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, value: String,body:ITWebAPIBody) -> String {
        return String(format: "\"%@\"", arguments: [value])
    }
    open func onFieldEnd(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, field: String,body:ITWebAPIBody) -> String {
        return String(format: "%@%@",[(type == .array ? "]" :""),(index == length ? "" :",")])
    }
}
/**
 xml实现类
 */
open class ITXmlVisitableObject : ITVisitableObject{
    open func onObjectBegin(_ index: UInt8, length: UInt8, objname: String,body:ITWebAPIBody) -> String {
        return String(format: "<%@ appId_=\"%@\" appName_=\"%@\" mapping_=\"%@\">", 
	arguments: [objname,body.appId_,body.appName_,body.mapping_])
    }
    open func onObjectEnd(_ index: UInt8, length: UInt8, objname: String,body:ITWebAPIBody) -> String {
        return String(format: "</%@>", arguments: [objname])
    }
    open func onFieldBegin(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, field: String,body:ITWebAPIBody) -> String {
        return String(format: "<%@>", arguments: [field])
    }
    open func onFieldValue(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, value: String,body:ITWebAPIBody) -> String {
        return String(format: "<![CDATA[%@]]>", arguments: [value])
    }
    open func onFieldEnd(_ type: ITVisitableObjectFieldType, index: UInt8, length: UInt8, field: String,body:ITWebAPIBody) -> String {
        return String(format: "</%@>", arguments: [field])
    }
}
// MARK:VisitableSource
/**
 数据源访问接口
 主要实现从各种数据源获取数据，如：xml，josn，database
*/
public protocol ITVisitableSource{
    func getValue(_ field:String) -> String
    func getSubSource(_ field:String) -> [ITVisitableSource]
}

/**
 Json实现类
 */
open class ITJsonVisitableSource :ITVisitableSource{
    fileprivate var jsonObject : JSON?
    
    init(_ jsonObject : JSON){
        self.jsonObject = jsonObject
    }
    
    convenience init(_ jsonSource : String){
        self.init(SwiftyJSON.JSON.init(parseJSON: jsonSource))
    }

    open func getValue(_ field: String) -> String {
        return jsonObject?[field].string ?? ""
    }
    
    open func getSubSource(_ field: String) -> [ITVisitableSource] {
        var subSource = [ITVisitableSource]()
        jsonObject?[field].forEach {
            (_,jsonObject) in
            subSource.append(ITJsonVisitableSource(jsonObject))
        }
        return subSource
    }
}
/**
 Xml实现类
 */
open class ITXmlVisitableSource :ITVisitableSource{
    fileprivate var xmlElement : AEXMLElement?
    
    init(_ xmlElement : AEXMLElement){
        self.xmlElement = xmlElement
    }
    
    public init(_ xmlString : String){
        guard let xmlElement = try? AEXMLDocument(xml: xmlString.data(using: String.Encoding.utf8)!) else{
            self.xmlElement = nil
            return
        }
        self.xmlElement = xmlElement.root
    }
    
    open func getValue(_ field: String) -> String {
        if let temp = xmlElement?[field]{
            if temp.name != "AEXMLError" {
                return temp.value.toString()!
            }
        }
        return ""
    }
    
    open func getSubSource(_ field: String) -> [ITVisitableSource] {
        var subSource = [ITVisitableSource]()
        xmlElement?[field].children.forEach({
            (xmlElement) in
            subSource.append(ITXmlVisitableSource(xmlElement))
        })
        return subSource
    }
}
//MARK:VisitablePair
/**
 数据访问对
*/
public protocol ITVisitablePair{
    init()
    func getVisitableSource(_ source:String) -> ITVisitableSource
    func getVisitableObject() -> ITVisitableObject
}

open class ITJsonVisitablePair : ITVisitablePair{
    required public init(){}
    open func getVisitableSource(_ source:String) -> ITVisitableSource {
        return ITJsonVisitableSource(source)
    }
    open func getVisitableObject() -> ITVisitableObject {
        return ITJsonVisitableObject()

    }
}

open class ITXmlVisitablePair : ITVisitablePair{
    required public init(){}
    open func getVisitableSource(_ source:String) -> ITVisitableSource {
        return ITXmlVisitableSource(source)
    }
    
    open func getVisitableObject() -> ITVisitableObject {
        return ITXmlVisitableObject()
    }
}
