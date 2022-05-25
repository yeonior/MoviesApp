//
//  APIs.swift
//  MoviesApp
//
//  Created by Ruslan on 25.05.2022.
//

struct APIs {
    private static let tmdbAPIKey   = "" // you need to write down your own API key here
    private static let tmdbBaseURL  = "https://api.themoviedb.org"
    
    static let trendingMoviesURL    = tmdbBaseURL + "/3/trending/movie/day?api_key="    + tmdbAPIKey
    static let trendingTVShowsURL   = tmdbBaseURL + "/3/trending/tv/day?api_key="       + tmdbAPIKey
    static let upcomingMoviesURL    = tmdbBaseURL + "/3/movie/upcoming?api_key="        + tmdbAPIKey + "&language=en-US&page=1"
    static let popularMoviesURL     = tmdbBaseURL + "/3/movie/popular?api_key="         + tmdbAPIKey + "&language=en-US&page=1"
    static let topRatedURL          = tmdbBaseURL + "/3/movie/top_rated?api_key="       + tmdbAPIKey + "&language=en-US&page=1"
    static let discoveringMoviesURL = tmdbBaseURL + "/3/discover/movie?api_key="        + tmdbAPIKey + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    static let searchingMoviesURL   = tmdbBaseURL + "/3/search/movie?api_key="          + tmdbAPIKey + "&query="
}
