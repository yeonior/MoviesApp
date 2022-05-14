//
//  Movie.swift
//  MoviesApp
//
//  Created by Ruslan on 14.05.2022.
//

import Foundation

// MARK: - Movie
struct TrendingMoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let originalLanguage: String
    let originalTitle: String?
    let posterPath: String
    let video: Bool?
    let voteAverage: Double
    let overview: String
    let releaseDate: String?
    let voteCount: Int
    let title: String?
    let adult: Bool?
    let backdropPath: String
    let id: Int
    let genreIDS: [Int]
    let popularity: Double
    let mediaType: MediaType
    let firstAirDate, name: String?
    let originCountry: [String]?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case title, adult
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case popularity
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}
