//
//  APIs.swift
//  MoviesApp
//
//  Created by Ruslan on 25.05.2022.
//

struct APIs {
    private static let tmdbAPIKey       = "" // you need to write down your own API key here
    private static let tmdbBaseURL      = "https://api.themoviedb.org/3/"
    private static let youtubeAPIKey    = "" // you need to write down your own API key here
    private static let youtubeBaseURL   = "https://youtube.googleapis.com/youtube/v3/"
    
    static let trendingMoviesURL    = tmdbBaseURL + "trending/movie/day?api_key="    + tmdbAPIKey
    static let trendingTVShowsURL   = tmdbBaseURL + "trending/tv/day?api_key="       + tmdbAPIKey
    static let upcomingMoviesURL    = tmdbBaseURL + "movie/upcoming?api_key="        + tmdbAPIKey + "&language=en-US&page=1"
    static let popularMoviesURL     = tmdbBaseURL + "movie/popular?api_key="         + tmdbAPIKey + "&language=en-US&page=1"
    static let topRatedURL          = tmdbBaseURL + "movie/top_rated?api_key="       + tmdbAPIKey + "&language=en-US&page=1"
    static let discoveringMoviesURL = tmdbBaseURL + "discover/movie?api_key="        + tmdbAPIKey + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let searchingMoviesURL   = tmdbBaseURL + "search/movie?api_key="          + tmdbAPIKey + "&query="
    
    static func getYoutubeSearchURL(with query: String) -> String {
        youtubeBaseURL + "search?" + "q=\(query)&" + "key=" + youtubeAPIKey
    }
}
