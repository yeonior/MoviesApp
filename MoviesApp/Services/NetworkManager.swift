//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Ruslan on 14.05.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

struct Constants {
    static let apiKey = "1c5fbab077da9b9cfca5a72db4548c5c"
    static let baseURL = "https://api.themoviedb.org"
    static let trendingMoviesURL = baseURL + "/3/trending/movie/day?api_key=" + apiKey
    static let trendingTVShowsURL = baseURL + "/3/trending/tv/day?api_key=" + apiKey
    static let upcomingMoviesURL = baseURL + "/3/movie/upcoming?api_key=" + apiKey + "&language=en-US&page=1"
    static let popularMoviesURL = baseURL + "/3/movie/popular?api_key=" + apiKey + "&language=en-US&page=1"
    static let topRatedURL = baseURL + "/3/movie/top_rated?api_key=" + apiKey + "&language=en-US&page=1"
}

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    private let sessionConfiguration = URLSessionConfiguration.default
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func request<T: Decodable>(fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        
        let request = URLRequest(url: url)
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // checking the error
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            // trying to get data
            guard let data = data else { return }
            do {
                let elements = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(elements))
            } catch {
                debugPrint("Could not translate the data to the requested type.")
                completionOnMain(.failure(error))
            }
        }.resume()
    }
}
