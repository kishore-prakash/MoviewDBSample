//
//  ProductionCountry.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name = "name"
    }
}

// MARK: ProductionCountry convenience initializers and mutators

extension ProductionCountry {
    init(data: Data) throws {
//        self = try newJSONDecoder().decode(ProductionCountry.self, from: data)
        let json = try JSON(data: data)
        iso3166_1 = json["iso_3166_1"].string
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
        iso3166_1: String?? = nil,
        name: String?? = nil
    ) -> ProductionCountry {
        return ProductionCountry(
            iso3166_1: iso3166_1 ?? self.iso3166_1,
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
