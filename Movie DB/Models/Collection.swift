//
//  Collection.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct Collection: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: BelongsToCollection convenience initializers and mutators

extension Collection {
    init(data: Data) throws {
        let json = try JSON(data: data)
        id = json["id"].int
        name = json["name"].string
        posterPath = json["poster_path"].string
        backdropPath = json["backdrop_path"].string
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
        id: Int?? = nil,
        name: String?? = nil,
        posterPath: String?? = nil,
        backdropPath: String?? = nil
    ) -> Collection {
        return Collection(
            id: id ?? self.id,
            name: name ?? self.name,
            posterPath: posterPath ?? self.posterPath,
            backdropPath: backdropPath ?? self.backdropPath
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
