//
//  DateExtension.swift
//  VacunAccion
//
//  Created by praxis on 27/12/17.
//  Copyright © 2017 Carlos Slim Salud. All rights reserved.
//

import UIKit

extension Date{
    /// Date formatter in dd/MMM/yyyy
    var datteFormaterDDMMMYYY:String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
}
