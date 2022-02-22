//
//  Constants.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import Foundation

let API_KEY = "71050f80b0fb378028b9f21fdd0efa88"
let BASE_URL = "https://api.themoviedb.org/3"
let BASE_POSTER_URL = "https://image.tmdb.org/t/p/w500"

enum EndPoints: String {
    case popular = "/movie/popular"
    case latest = "/movie/now_playing"
    case movieDetails = "/movie/"
}

enum CellIdentifier: String {
    case movieCell = "movieCell"
}

enum SegueIdentifier: String {
    case movieDetails = "movieDetailsSegue"
}
