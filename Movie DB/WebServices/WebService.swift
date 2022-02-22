//
//  WebService.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation
import UIKit

class Webservice {
    
    func getData(fromURL url: URL, completionHandler: @escaping (_ response: MovieDBResponse) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(MovieDBResponse(status: .failure(String(describing: response))))
                return
            }
            
            guard let data = data else {
                completionHandler(MovieDBResponse(status: .failure("Unable to get any data from \(url.absoluteString)")))
                return
            }
            completionHandler(MovieDBResponse(status: .success(data)))
        })
        task.resume()
    }
    
    func getLatestMovies(completionHandler: @escaping (_ response: MovieDBResponse) -> ()) {
        guard var components = URLComponents(string: BASE_URL + EndPoints.latest.rawValue) else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: "IN")
        ]

        components.percentEncodedQuery = components.percentEncodedQuery
        
        
        guard let url = components.url else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(MovieDBResponse(status: .failure(String(describing: response))))
                return
            }
            
            guard let data = data else {
                completionHandler(MovieDBResponse(status: .failure("Unable to get any data from \(url.absoluteString)")))
                return
            }
            
            do {
                let latestMoviesResponse = try LatestMoviesResponse(data: data)
                completionHandler(MovieDBResponse(status: .success(latestMoviesResponse.movies ?? [Movie]())))
            } catch {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
            }
        })
        task.resume()
    }
    
    func getPopularMovies(completionHandler: @escaping (_ response: MovieDBResponse) -> ()) {
        guard var components = URLComponents(string: BASE_URL + EndPoints.popular.rawValue) else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1")
        ]

        components.percentEncodedQuery = components.percentEncodedQuery
        
        
        guard let url = components.url else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(MovieDBResponse(status: .failure(String(describing: response))))
                return
            }
            
            guard let data = data else {
                completionHandler(MovieDBResponse(status: .failure("Unable to get any data from \(url.absoluteString)")))
                return
            }
            
            do {
                let popularMoviesResponse = try PopularMoviesResponse(data: data)
                completionHandler(MovieDBResponse(status: .success(popularMoviesResponse.movies ?? [Movie]())))
            } catch {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
            }
        })
        task.resume()
    }
    
    func getMovieDetails(id: Int, completionHandler: @escaping (_ response: MovieDBResponse) -> ()) {
        guard var components = URLComponents(string: BASE_URL + EndPoints.movieDetails.rawValue + "\(id)") else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: API_KEY),
            URLQueryItem(name: "language", value: "en-US")
        ]

        components.percentEncodedQuery = components.percentEncodedQuery
        
        
        guard let url = components.url else {
            completionHandler(MovieDBResponse(status: .failure("Invalid URL")))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(MovieDBResponse(status: .failure(String(describing: response))))
                return
            }
            
            guard let data = data else {
                completionHandler(MovieDBResponse(status: .failure("Unable to get any data from \(url.absoluteString)")))
                return
            }
            
            do {
                let movie = try Movie(data: data)
                completionHandler(MovieDBResponse(status: .success(movie)))
            } catch {
                completionHandler(MovieDBResponse(status: .failure(error.localizedDescription)))
            }
        })
        task.resume()
    }

}
