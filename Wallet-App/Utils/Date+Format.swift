//
//  DateFormatter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 15.03.2022.
//

import Foundation


extension Date {
    var formatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "YY, MMM d"
           
        return formatter
    }
    
    func format() -> String {
        if let response = formatter.string(for: self) {
            return response
        } else {
            return "0.0.0"
        }
    }
}
