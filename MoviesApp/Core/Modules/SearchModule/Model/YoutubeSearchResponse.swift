//
//  YoutubeSearchResponse.swift
//  MoviesApp
//
//  Created by Ruslan on 25.05.2022.
//

import Foundation

// MARK: - YoutubeSearchResponse
struct YoutubeSearchResponse: Codable {
    let items: [YoutubeVideo]
}

// MARK: - YoutubeVideo
struct YoutubeVideo: Codable {
    let id: YoutubeID
}

// MARK: - YoutubeID
struct YoutubeID: Codable {
    let kind: String
    let videoID: String
}
