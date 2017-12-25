//
//  String+Extension.swift
//  DY
//
//  Created by 满艺网 on 2017/12/25.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

import Foundation

extension String {
    func md5String() -> String {
        let selfString = self.cString(using: String.Encoding.utf8)
        let selfLength = self.lengthOfBytes(using: String.Encoding.utf8)
        let digestLength = CC_MD5_DIGEST_LENGTH
        let buffer = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(digestLength))
        CC_MD5(selfString, CC_LONG(selfLength), buffer)

        let hash = NSMutableString()
        for i in 0..<digestLength {
            hash.appendFormat("%02x", buffer[Int(i)])
        }
        buffer.deallocate(capacity: Int(digestLength))
        return String(hash)
    }

    func hmacMD5StringWithKey(key: String) -> String {
         let keyData = key.cString(using: String.Encoding.utf8)
         let selfData = self.cString(using: String.Encoding.utf8)
         let digestLength = CC_MD5_DIGEST_LENGTH
         let buffer = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(digestLength))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgMD5), keyData, strlen(keyData), selfData, strlen(selfData), buffer)
        let hash = NSMutableString()
        for i in 0..<digestLength {
            hash.appendFormat("%02x", buffer[Int(i)])
        }
        buffer.deallocate(capacity: Int(digestLength))
        return String(hash)
    }
}
