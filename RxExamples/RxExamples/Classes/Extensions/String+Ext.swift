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
        return self.count //.characters.count
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
