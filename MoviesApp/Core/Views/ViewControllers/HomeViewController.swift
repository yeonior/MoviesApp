//
//  HomeViewController.swift
//  MoviesApp
//
//  Created by Ruslan on 13.05.2022.
//

import UIKit

enum Sections: Int {
    case trendingMovies = 0
    case trendingTVShows = 1
    case popular        = 2
    case upcoming       = 3
    case topRated       = 4
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let sectionTitles = ["Trending movies", "Trending TV shows", "Popular", "Upcoming movies", "Top rated"]
    
    // MARK: - Subviews
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self,
                           forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTableViewFrame()
    }
    
    // MARK: - Methods
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        tableView.tableHeaderView = headerView
    }
    
    private func configureTableViewFrame() {
        tableView.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    private func getData(from url: String) {
        guard let url = URL(string: url) else { return }
        NetworkManager.shared.request(fromURL: url) { (result: Result<TitleResponse, Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            NetworkManager.shared.request(fromURL: URL(string: Constants.trendingMoviesURL)!) { (result: Result<TitleResponse, Error>) in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.trendingTVShows.rawValue:
            NetworkManager.shared.request(fromURL: URL(string: Constants.trendingTVShowsURL)!) { (result: Result<TitleResponse, Error>) in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.popular.rawValue:
            NetworkManager.shared.request(fromURL: URL(string: Constants.popularMoviesURL)!) { (result: Result<TitleResponse, Error>) in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.upcoming.rawValue:
            NetworkManager.shared.request(fromURL: URL(string: Constants.upcomingMoviesURL)!) { (result: Result<TitleResponse, Error>) in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles.results)
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.topRated.rawValue:
            NetworkManager.shared.request(fromURL: URL(string: Constants.topRatedURL)!) { (result: Result<TitleResponse, Error>) in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles.results)
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController {
    // making the navigation bar scrollable
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}