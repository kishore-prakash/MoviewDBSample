//
//  MovieDBResponse.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation

enum Status {
    case success(Any)
    case failure(String)
}

class MovieDBResponse {
    
    var status: Status
    
    init() {
        self.status = .failure("Unknown")
    }
    
    init(status: Status) {
        self.status = status
    }
}

