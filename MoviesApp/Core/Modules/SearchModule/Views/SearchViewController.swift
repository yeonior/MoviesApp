//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private var titles: [Title] = []
    
    // MARK: - Subviews
    private let discoverTableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchDiscoverMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDiscoverTableViewFrame()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        title = "Search"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(discoverTableView)
        discoverTableView.dataSource = self
        discoverTableView.delegate = self
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
    }
    
    private func configureDiscoverTableViewFrame() {
        discoverTableView.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        guard let url = URL(string: APIs.discoveringMoviesURL) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                self?.titles = titles.results
                DispatchQueue.main.async {
                    self?.discoverTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.originalTitle ?? title.originalName) ?? "N/A", posterURL: title.posterPath ?? ""))
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.originalTitle ?? title.originalName,
              let query = titleName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL(string: APIs.getYoutubeSearchURL(with: query)) else { return }
        NetworkManager.shared.request(fromURL: url) { [weak self] (result: Result<YoutubeSearchResponse, Error>) in
            switch result {
            case .success(let response):
                let youtubeView = response.items[0]
                let vc = PreviewViewController()
                let viewModel = PreviewViewModel(title: titleName, youtubeView: youtubeView, titleOverview: title.overview ?? "")
                vc.configure(with: viewModel)
                self?.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let url = URL(string: APIs.searchingMoviesURL + query) else { return }
        
        NetworkManager.shared.request(fromURL: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let titles):
                resultsController.titles = titles.results
                resultsController.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
