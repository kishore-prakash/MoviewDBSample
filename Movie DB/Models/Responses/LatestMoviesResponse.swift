//
//  LatestMoviesResponse.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct LatestMoviesResponse: Codable {
    let page: Int?
    let movies: [Movie]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: LatestMoviesResponse convenience initializers and mutators

extension LatestMoviesResponse {
    init(data: Data) throws {
        let json = try JSON(data: data)
        page = json["page"].int
        var movies = [Movie]()
        for item in json["results"].arrayValue {
            movies.append(try Movie(data: item.rawData()))
        }
        self.movies = movies
        
        totalPages = json["total_pages"].int
        totalResults = json["total_results"].int
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        page: Int?? = nil,
        movies: [Movie]?? = nil,
        totalPages: Int?? = nil,
        totalResults: Int?? = nil
    ) -> LatestMoviesResponse {
        return LatestMoviesResponse(
            page: page ?? self.page,
            movies: movies ?? self.movies,
            totalPages: totalPages ?? self.totalPages,
            totalResults: totalResults ?? self.totalResults
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
