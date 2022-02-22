//
//  String+MovieDB.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
}
