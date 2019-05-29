//
//  String+Ext.swift
//  RxExamples
//
//  Created by jin on 2019/5/29.
//  Copyright © 2019 晋先森. All rights reserved.
//

import Foundation
 
extension String {
 
    func contains(regular:String) -> Bool {
        return self.range(of: regular, options: .regularExpression, range: nil, locale: nil) != nil
    }
    func match(_ regular: String) -> Bool {
        return self.contains(regular: regular)
    }
    
    var length: Int {
        return self.count//.characters.count
    }
    
    func substring(to:Int) -> String {
        return self.substring(to: self.index(self.startIndex, offsetBy: to, limitedBy: self.endIndex) ?? self.endIndex)
    }
    
    func substring(from:Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from, limitedBy: self.endIndex) ?? self.endIndex)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound, limitedBy: self.endIndex) ?? self.endIndex
        let end = self.index(self.startIndex, offsetBy: r.upperBound, limitedBy: self.endIndex) ?? self.endIndex
        return String(self[start..<end])
    }
    subscript (n:Int) -> String {
        return self[n..<n+1]
    }
    subscript (str:String) -> Range<Index>? {
        return self.range(of: str)
    }
}
