//
//  StringExtension.swift
//  VacunAccion
//
//  Created by praxis on 18/12/17.
//  Copyright © 2017 Carlos Slim Salud. All rights reserved.
//

import UIKit

extension String{
    
    /// Date to string
    ///
    /// - Parameter dateFormatStr: String
    /// - Returns: Date?
    func dateToString(dateFormatStr:String)->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatStr
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateFormatter.date(from: self) else {
            fatalError("ERROR: Date conversion failed due to mismatched format.")
        }
        return date
    }
    
}
