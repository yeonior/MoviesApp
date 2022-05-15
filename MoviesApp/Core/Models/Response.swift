//
//  Response.swift
//  MoviesApp
//
//  Created by Ruslan on 15.05.2022.
//

import Foundation

// MARK: - Response
struct Response<T: Codable>: Codable {
    let dates: Dates?
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}
