//
//  ITWebAPI.swift
//  ITWebAPI
//
//  Created by 吴知洋 on 16/2/19.
//  Copyright © 2016年 杭州艾拓. All rights reserved.
//

import Foundation
import CommonCrypto
/*!
 安全加密协议
 */
// MARK: SecureKey
public protocol ITSecureKey :class {
    //加密算法名称
    var name : String { get }
    //加密字符串
    func encrypt(original:String?) -> String
    //解密字符串
    func decrypt(original:String?) -> String
}
//ITWebAPISecureKey
//AES对称加密算法
@MainActor 
public class ITAESSecureKey : @preconcurrency ITSecureKey{
    private let key : Data?
    required public init(_ passwd : String){
        self.key = passwd.data(using: String.Encoding.utf8)
    }
    //
    public var name : String = "AES"
    public func encrypt(original: String?) -> String {
        return cryptoOperation(original: original,operation : CCOperation(kCCEncrypt)) ?? ""
    }
    public func decrypt(original: String?) -> String {
        return cryptoOperation(original: original,operation : CCOperation(kCCDecrypt)) ?? ""
    }
    //
    private func cryptoOperation(original: String?,operation: CCOperation) -> String? {
        guard let originalString = original else {
            //            DDLog("cryptoOperation error --->original is nil...")
            return nil
        }
        if String.isEmpty(originalString){
            return nil
        }
        // Prepare data parameters
        let inputData: Data!
        if operation == CCOperation(kCCDecrypt) {
            inputData = Data(base64Encoded: originalString, options: .ignoreUnknownCharacters)
        } else {
            inputData = originalString.data(using: String.Encoding.utf8)
        }
        if inputData == nil {
            return original
        }
        
        let keyData: Data!    = self.key
        //MARK:注意这里
        let keyBytes            = UnsafeRawPointer((keyData as NSData).bytes)
//        let keyBytes            = UnsafePointer<Void>((keyData as NSData).bytes)

        let keyLength           = size_t(kCCKeySizeAES128)
        let dataLength          = Int((inputData as NSData).length)
        let dataBytes           = UnsafeRawPointer((inputData as NSData).bytes)
//        let dataBytes           = UnsafePointer((inputData as NSData).bytes)

        let bufferData          = NSMutableData(length: Int(dataLength) + kCCBlockSizeAES128)!
        let bufferPointer       = UnsafeMutableRawPointer(bufferData.mutableBytes)
//        let bufferPointer       = UnsafeMutablePointer(bufferData.mutableBytes)

        let bufferLength        = size_t(bufferData.length)
        var bytesDecrypted      = Int(0)
        // Perform operation
        let cryptStatus = CCCrypt(
            operation,                  // Operation
            CCAlgorithm(kCCAlgorithmAES128),        // Algorithm
            CCOptions(kCCOptionPKCS7Padding|kCCOptionECBMode),       // Options
            keyBytes,                   // key data
            keyLength,                  // key length
            nil,                        // IV buffer
            dataBytes,                  // input data
            dataLength,                 // input length
            bufferPointer,              // output buffer
            bufferLength,               // output buffer length
            &bytesDecrypted             // output bytes decrypted real length
        )
        if Int32(cryptStatus) == Int32(kCCSuccess) {
            bufferData.length = bytesDecrypted // Adjust buffer size to real bytes
            return operation == CCOperation(kCCDecrypt) ?
                String(data: bufferData as Data, encoding: String.Encoding.utf8):
                bufferData.base64EncodedString(options: .endLineWithCarriageReturn)
        }

        return nil
    }
}

// MARK: extension
private extension NSInteger {
    func encodedOctets() -> [CUnsignedChar] {
        // Short form
        if self < 128 {
            return [CUnsignedChar(self)];
        }
        
        // Long form
        let i = (self / 256) + 1
        var len = self
        var result: [CUnsignedChar] = [CUnsignedChar(i + 0x80)]
        
        for _ in 0..<i {
            result.insert(CUnsignedChar(len & 0xFF), at: 1)
            len = len >> 8
        }
        
        return result
    }
    
    init?(octetBytes: [CUnsignedChar], startIdx: inout NSInteger) {
        if octetBytes[startIdx] < 128 {
            // Short form
            self.init(octetBytes[startIdx])
            startIdx += 1
        } else {
            // Long form
            let octets = NSInteger(octetBytes[startIdx] as UInt8 - 128)
            
            if octets > octetBytes.count - startIdx {
                self.init(0)
                return nil
            }
            
            var result = UInt64(0)
            
            for j in 1...octets {
                result = (result << 8)
                result = result + UInt64(octetBytes[startIdx + j])
            }
            
            startIdx += 1 + octets
            self.init(result)
        }
    }
}



///
/// Manipulating data
///
private extension Data {
    init(modulus: Data, exponent: Data) {
        // Make sure neither the modulus nor the exponent start with a null byte
        var modulusBytes = [CUnsignedChar](UnsafeBufferPointer<CUnsignedChar>(start: (modulus as NSData).bytes.bindMemory(to: CUnsignedChar.self, capacity: modulus.count), count: modulus.count / MemoryLayout<CUnsignedChar>.size))
        let exponentBytes = [CUnsignedChar](UnsafeBufferPointer<CUnsignedChar>(start: (exponent as NSData).bytes.bindMemory(to: CUnsignedChar.self, capacity: exponent.count), count: exponent.count / MemoryLayout<CUnsignedChar>.size))
        
        // Make sure modulus starts with a 0x00
        if let prefix = modulusBytes.first , prefix != 0x00 {
            modulusBytes.insert(0x00, at: 0)
        }
        
        // Lengths
        let modulusLengthOctets = modulusBytes.count.encodedOctets()
        let exponentLengthOctets = exponentBytes.count.encodedOctets()
        
        // Total length is the sum of components + types
        let totalLengthOctets = (modulusLengthOctets.count + modulusBytes.count + exponentLengthOctets.count + exponentBytes.count + 2).encodedOctets()
        
        // Combine the two sets of data into a single container
        var builder: [CUnsignedChar] = []
        let data = NSMutableData()
        
        // Container type and size
        builder.append(0x30)
        builder.append(contentsOf: totalLengthOctets)
        data.append(builder, length: builder.count)
        builder.removeAll(keepingCapacity: false)
        
        // Modulus
        builder.append(0x02)
        builder.append(contentsOf: modulusLengthOctets)
        data.append(builder, length: builder.count)
        builder.removeAll(keepingCapacity: false)
        data.append(modulusBytes, length: modulusBytes.count)
        
        // Exponent
        builder.append(0x02)
        builder.append(contentsOf: exponentLengthOctets)
        data.append(builder, length: builder.count)
        data.append(exponentBytes, length: exponentBytes.count)
        
        self.init(bytes: data.bytes, count: data.length)
        
        //self.init(data: data)
    }

    
    func splitIntoComponents() -> (modulus: Data, exponent: Data)? {
        // Get the bytes from the keyData
        let pointer = (self as NSData).bytes.bindMemory(to: CUnsignedChar.self, capacity: self.count)
        let keyBytes = [CUnsignedChar](UnsafeBufferPointer<CUnsignedChar>(start:pointer, count:self.count / MemoryLayout<CUnsignedChar>.size))
        
        // Assumption is that the data is in DER encoding
        // If we can parse it, then return successfully
        var i: NSInteger = 0
        
        // First there should be an ASN.1 SEQUENCE
        if keyBytes[0] != 0x30 {
            return nil
        } else {
            i += 1
        }
        // Total length of the container
        if let _ = NSInteger(octetBytes: keyBytes, startIdx: &i) {
            // First component is the modulus
            if keyBytes[i] == 0x02 {
                i += 1
                if let modulusLength = NSInteger(octetBytes: keyBytes, startIdx: &i) {
                    let modulus = self.subdata(in: NSRange(location: i, length: modulusLength).toRange()!)
                    i += modulusLength
                    
                    // Second should be the exponent
                    if keyBytes[i] == 0x02 {
                        i += 1
                        if let exponentLength = NSInteger(octetBytes: keyBytes, startIdx: &i) {
                            let exponent = self.subdata(in: NSRange(location: i, length: exponentLength).toRange()!)
                            i += exponentLength
                            
                            return (modulus, exponent)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    func dataByPrependingX509Header() -> Data {
        let result = NSMutableData()
        
        let encodingLength: Int = (self.count + 1).encodedOctets().count
        let OID: [CUnsignedChar] = [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
                                    0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00]
        
        var builder: [CUnsignedChar] = []
        
        // ASN.1 SEQUENCE
        builder.append(0x30)
        
        // Overall size, made of OID + bitstring encoding + actual key
        let size = OID.count + 2 + encodingLength + self.count
        let encodedSize = size.encodedOctets()
        builder.append(contentsOf: encodedSize)
        result.append(builder, length: builder.count)
        result.append(OID, length: OID.count)
        builder.removeAll(keepingCapacity: false)
        
        builder.append(0x03)
        builder.append(contentsOf: (self.count + 1).encodedOctets())
        builder.append(0x00)
        result.append(builder, length: builder.count)
        
        // Actual key bytes
        result.append(self)
        
        return result as Data
    }
 
    
    func dataByStrippingX509Header() -> Data {
        var bytes = [CUnsignedChar](repeating: 0, count: self.count)
        (self as NSData).getBytes(&bytes, length:self.count)
        
        var range = NSRange(location: 0, length: self.count)
        var offset = 0
        
        // ASN.1 Sequence
        if bytes[offset] == 0x30 {
            offset += 1
            
            // Skip over length
            let _ = NSInteger(octetBytes: bytes, startIdx: &offset)
            
            let OID: [CUnsignedChar] = [0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
                                        0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00]
            let slice: [CUnsignedChar] = Array(bytes[offset..<(offset + OID.count)])
            
            if slice == OID {
                offset += OID.count
                
                // Type
                if bytes[offset] != 0x03 {
                    return self
                }
                
                offset += 1
                
                // Skip over the contents length field
                let _ = NSInteger(octetBytes: bytes, startIdx: &offset)
                
                // Contents should be separated by a null from the header
                if bytes[offset] != 0x00 {
                    return self
                }
                
                offset += 1
                range.location += offset
                range.length -= offset
            } else {
                return self
            }
        }
        
        return self.subdata(in: range.toRange()!)
    }}

