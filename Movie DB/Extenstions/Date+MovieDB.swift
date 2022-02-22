//
//  Date+MovieDB.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation


import Foundation

extension Date {
    func toString(format: String = "dd MMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
