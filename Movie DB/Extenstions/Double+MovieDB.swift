//
//  Double+MovieDB.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

