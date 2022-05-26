//
//  APIs.swift
//  MoviesApp
//
//  Created by Ruslan on 25.05.2022.
//

struct APIs {
    private static let tmdbAPIKey       = "1c5fbab077da9b9cfca5a72db4548c5c"
    private static let tmdbBaseURL      = "https://api.themoviedb.org/3/"
    private static let youtubeAPIKey    = "AIzaSyAex7-qIGcC62os_5y_kgqdsppwJmRpgYI"
    private static let youtubeBaseURL   = "https://youtube.googleapis.com/youtube/v3/"
    
    static let trendingMoviesURL    = tmdbBaseURL + "trending/movie/day?api_key="    + tmdbAPIKey
    static let trendingTVShowsURL   = tmdbBaseURL + "trending/tv/day?api_key="       + tmdbAPIKey
    static let upcomingMoviesURL    = tmdbBaseURL + "movie/upcoming?api_key="        + tmdbAPIKey + "&language=en-US&page=1"
    static let popularMoviesURL     = tmdbBaseURL + "movie/popular?api_key="         + tmdbAPIKey + "&language=en-US&page=1"
    static let topRatedURL          = tmdbBaseURL + "movie/top_rated?api_key="       + tmdbAPIKey + "&language=en-US&page=1"
    static let discoveringMoviesURL = tmdbBaseURL + "discover/movie?api_key="        + tmdbAPIKey + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let searchingMoviesURL   = tmdbBaseURL + "search/movie?api_key="          + tmdbAPIKey + "&query="
    
    static func getYoutubeSearchURL(with query: String) -> String {
        youtubeBaseURL + "search?" + "q=\(query)%20trailer&" + "key=" + youtubeAPIKey
    }
}
