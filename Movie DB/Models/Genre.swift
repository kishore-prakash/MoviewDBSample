//
//  Collection.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct Genre: Codable {
    let id: Int
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: Genre convenience initializers and mutators

extension Genre {
    init(data: Data) throws {
//        self = try newJSONDecoder().decode(Genre.self, from: data)
        let json = try JSON(data: data)
        id = json["id"].intValue
        name = json["name"].string
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
        id: Int,
        name: String?? = nil
    ) -> Genre {
        return Genre(
            id: id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
