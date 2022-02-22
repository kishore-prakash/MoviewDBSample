//
//  Movie.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import SwiftyJSON

struct Movie: Codable {
    
    let adult: Bool?
    let backdropPath: String?
    let collection: Collection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: Date?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case collection = "belongs_to_collection"
        case budget = "budget"
        case genres = "genres"
        case homepage = "homepage"
        case id = "id"
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case spokenLanguages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: Movie convenience initializers and mutators

extension Movie {
    init(data: Data) throws {
        let json = try JSON(data: data)
        adult = json["adult"].bool
        backdropPath = json["backdrop_path"].string
//        collection = try Collection(data: json["belongs_to_collection"].rawData())
        collection = nil
        budget = json["budget"].int
        var genres = [Genre]()
        for item in json["genres"].arrayValue {
            genres.append(try Genre(data: item.rawData()))
        }
        self.genres = genres
        homepage = json["homepage"].string
        id = json["id"].intValue
        imdbID = json["imdb_id"].string
        originalLanguage = json["original_language"].string
        originalTitle = json["original_title"].string
        overview = json["overview"].string
        popularity = json["popularity"].double
        posterPath = json["poster_path"].string
        var productionCompanies = [ProductionCompany]()
        for item in json["production_companies"].arrayValue {
            productionCompanies.append(try ProductionCompany(data: item.rawData()))
        }
        self.productionCompanies = productionCompanies

        var productionCountries = [ProductionCountry]()
        for item in json["production_countries"].arrayValue {
            productionCountries.append(try ProductionCountry(data: item.rawData()))
        }
        self.productionCountries = productionCountries
        releaseDate = json["release_date"].string?.toDate()
        revenue = json["revenue"].int
        runtime = json["runtime"].int
        
        var spokenLanguages = [SpokenLanguage]()
        for item in json["spoken_languages"].arrayValue {
            spokenLanguages.append(try SpokenLanguage(data: item.rawData()))
        }
        self.spokenLanguages = spokenLanguages
        status = json["status"].string
        tagline = json["tagline"].string
        title = json["title"].string
        video = json["video"].bool
        voteAverage = json["vote_average"].double
        voteCount = json["vote_count"].int
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

//    func with(
//        adult: Bool?? = nil,
//        backdropPath: String?? = nil,
//        belongsToCollection: Collection?? = nil,
//        budget: Int?? = nil,
//        genres: [Genre]?? = nil,
//        homepage: String?? = nil,
//        id: Int,
//        imdbID: String?? = nil,
//        originalLanguage: String?? = nil,
//        originalTitle: String?? = nil,
//        overview: String?? = nil,
//        popularity: Double?? = nil,
//        posterPath: String?? = nil,
//        productionCompanies: [ProductionCompany]?? = nil,
//        productionCountries: [ProductionCountry]?? = nil,
//        releaseDate: Date?? = nil,
//        revenue: Int?? = nil,
//        runtime: Int?? = nil,
//        spokenLanguages: [SpokenLanguage]?? = nil,
//        status: String?? = nil,
//        tagline: String?? = nil,
//        title: String?? = nil,
//        video: Bool?? = nil,
//        voteAverage: Double?? = nil,
//        voteCount: Int?? = nil
//    ) -> Movie {
//        return Movie(
//            adult: adult ?? self.adult,
//            backdropPath: backdropPath ?? self.backdropPath,
//            belongsToCollection: belongsToCollection ?? self.collection,
//            budget: budget ?? self.budget,
//            genres: genres ?? self.genres,
//            homepage: homepage ?? self.homepage,
//            id: id,
//            imdbID: imdbID ?? self.imdbID,
//            originalLanguage: originalLanguage ?? self.originalLanguage,
//            originalTitle: originalTitle ?? self.originalTitle,
//            overview: overview ?? self.overview,
//            popularity: popularity ?? self.popularity,
//            posterPath: posterPath ?? self.posterPath,
//            productionCompanies: productionCompanies ?? self.productionCompanies,
//            productionCountries: productionCountries ?? self.productionCountries,
//            releaseDate: releaseDate ?? self.releaseDate,
//            revenue: revenue ?? self.revenue,
//            runtime: runtime ?? self.runtime,
//            spokenLanguages: spokenLanguages ?? self.spokenLanguages,
//            status: status ?? self.status,
//            tagline: tagline ?? self.tagline,
//            title: title ?? self.title,
//            video: video ?? self.video,
//            voteAverage: voteAverage ?? self.voteAverage,
//            voteCount: voteCount ?? self.voteCount
//        )
//    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
