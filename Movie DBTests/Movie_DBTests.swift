//
//  Movie_DBTests.swift
//  Movie DBTests
//
//  Created by Kishore on 22/02/22.
//

import XCTest
@testable import Movie_DB

class Movie_DBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWebServiceSucces() throws {
        Webservice().getLatestMovies { response in
            switch response.status {
            case .failure(_):
                XCTFail("Should not fail")
            case .success(let data):
                let movies = data as? [Movie]
                XCTAssertGreaterThan(0, movies?.count ?? 0)
            }
        }
    }

    func testInvaliURL() throws {
        Webservice().getData(fromURL: URL(string: BASE_URL)!) { response in
            switch response.status {
            case .failure(_):
                break
            case .success(_):
                XCTFail("Should not fail")
            }
        }
    }
    
    func testInvalidDataForMovie() throws {
        do {
            _ = try Movie(data: Data())
            XCTFail("Should catch error")
        } catch {
            print("[KP]: \(error.localizedDescription)")
        }
    }
    
}
