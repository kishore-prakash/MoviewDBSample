//
//  SpokenLanguage.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name = "name"
    }
}

// MARK: SpokenLanguage convenience initializers and mutators

extension SpokenLanguage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SpokenLanguage.self, from: data)
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
        englishName: String?? = nil,
        iso639_1: String?? = nil,
        name: String?? = nil
    ) -> SpokenLanguage {
        return SpokenLanguage(
            englishName: englishName ?? self.englishName,
            iso639_1: iso639_1 ?? self.iso639_1,
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
