//
//  TVShow.swift
//  MoviesApp
//
//  Created by Ruslan on 14.05.2022.
//

import Foundation

// MARK: - TVShow
struct TVShow: Codable {
    let originalLanguage, firstAirDate, posterPath, name: String
    let voteAverage: Double
    let overview, originalName: String
    let originCountry: [String]
    let voteCount: Int
    let backdropPath: String
    let id: Int
    let genreIDS: [Int]
    let popularity: Double
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
        case overview
        case originalName = "original_name"
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case backdropPath = "backdrop_path"
        case id
        case genreIDS = "genre_ids"
        case popularity
        case mediaType = "media_type"
    }
}
