//
//  ProductionCompany.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case logoPath = "logo_path"
        case name = "name"
        case originCountry = "origin_country"
    }
}

// MARK: ProductionCompany convenience initializers and mutators

extension ProductionCompany {
    init(data: Data) throws {
//        self = try newJSONDecoder().decode(ProductionCompany.self, from: data)
        let json = try JSON(data: data)
        id = json["id"].int
        logoPath = json["logo_path"].string
        name = json["name"].string
        originCountry = json["origin_country"].string
        
        
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
        logoPath: String?? = nil,
        name: String?? = nil,
        originCountry: String?? = nil
    ) -> ProductionCompany {
        return ProductionCompany(
            id: id ?? self.id,
            logoPath: logoPath ?? self.logoPath,
            name: name ?? self.name,
            originCountry: originCountry ?? self.originCountry
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
