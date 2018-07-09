//
//  CoreText.swift
//  potencia
//
//  Created by Adrian Salazar on 30/03/17.
//  Copyright © 2017 Adrian Salazar. All rights reserved.
//

import UIKit

struct TextAttribute {
    let text:String
    let textFont:UIFont
    let textColor:UIColor
}

class CoreText: NSObject {
    
    /// Create attributes
    ///
    /// - Parameter arrTextAttrbutes: array of TextAttribute
    /// - Returns: NSAttributedString
    func attributeTextWith(arrTextAttrbutes:[TextAttribute])->NSAttributedString{
        let retAttributedText = NSMutableAttributedString(string: "")
        for textAttribute in arrTextAttrbutes{
            let attributes:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font:textAttribute.textFont,NSAttributedStringKey.foregroundColor:textAttribute.textColor]
            let substring =  NSAttributedString(string: textAttribute.text, attributes: attributes)
            retAttributedText.append(substring)
        }
        return retAttributedText
    }        

}
