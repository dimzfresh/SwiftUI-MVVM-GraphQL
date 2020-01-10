//
//  String+Date.swift
//  SwiftUI-MVVM
//
//  Created by Dmitrii Ziablikov on 10.01.2020.
//  Copyright © 2020 Dmitrii Ziablikov. All rights reserved.
//

import Foundation

extension String {
     func toDate(dateFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "us")
        return dateFormatter.date(from: self) ?? Date()
    }    
}

extension Date {
     func toString(dateFormat format: String = "MMMM, dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "us")
        return dateFormatter.string(from: self)
    }
}
